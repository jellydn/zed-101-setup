import { execFileSync } from "node:child_process";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * NOTE: Ensure you have copied your latest configuration before replacing it. Use the following commands:
 *
 * ```bash
 * cp ~/.config/zed/keymap.json keymap.json
 * cp ~/.config/zed/settings.json settings.json
 * cp ~/.config/zed/tasks.json tasks.json
 * ```
 */

const readmePath = path.join(__dirname, "README.md");

const readFileOrNull = (filePath: string): string | null => {
	try {
		return fs.readFileSync(filePath, "utf8");
	} catch {
		return null;
	}
};

const generateMarkdown = (fileName: string, data: string) => `
\`\`\`jsonc
// ${fileName}, generated at ${new Date()}
${data}
\`\`\`
`;

const isMissingExecutableError = (error: unknown) =>
	error instanceof Error &&
	(("code" in error && error.code === "ENOENT") ||
		("status" in error && error.status === 127));

const formatReadme = (targetPath: string): void => {
	// Try a formatter command; returns false if the binary is missing (ENOENT / 127),
	// re-throws any other failure so the outer catch can handle it.
	const tryFormat = (cmd: string, args: string[], timeout: number): boolean => {
		try {
			execFileSync(cmd, args, { stdio: "pipe", timeout });
			return true;
		} catch (error) {
			if (isMissingExecutableError(error)) return false;
			throw error;
		}
	};

	try {
		if (!tryFormat("prettier", ["--write", targetPath], 10_000)) {
			if (
				!tryFormat("npx", ["-y", "prettier", "--write", targetPath], 15_000)
			) {
				console.warn(
					"Warning: prettier not found — README.md may not match pre-commit style",
				);
			}
		}
	} catch {
		console.error(
			"Error: prettier formatting failed — README.md may not match pre-commit style",
		);
		process.exitCode = 1;
	}
};

try {
	const settings = readFileOrNull(path.join(__dirname, "settings.json"));
	const keymap = readFileOrNull(path.join(__dirname, "keymap.json"));
	const tasks = readFileOrNull(path.join(__dirname, "tasks.json"));
	const data = readFileOrNull(readmePath);

	if (!settings || !keymap || !data) {
		const missing = [
			!settings && "settings.json",
			!keymap && "keymap.json",
			!data && "README.md",
		]
			.filter(Boolean)
			.join(", ");
		throw new Error(`Required files not found: ${missing}`);
	}

	const settingsMarkdown = generateMarkdown("settings.json", settings);
	const keymapsMarkdown = generateMarkdown("keymap.json", keymap);

	let result = data.replace(
		/(<!-- ALL-SETTINGS:START -->)[\s\S]*?(<!-- ALL-SETTINGS:END -->)/gs,
		`$1\n${settingsMarkdown}\n$2`,
	);
	result = result.replace(
		/(<!-- ALL-KEYMAPS:START -->)[\s\S]*?(<!-- ALL-KEYMAPS:END -->)/gs,
		`$1\n${keymapsMarkdown}\n$2`,
	);

	if (tasks) {
		const tasksMarkdown = generateMarkdown("tasks.json", tasks);
		result = result.replace(
			/(<!-- ALL-TASKS:START -->)[\s\S]*?(<!-- ALL-TASKS:END -->)/gs,
			`$1\n${tasksMarkdown}\n$2`,
		);
	}

	fs.writeFileSync(readmePath, result);

	formatReadme(readmePath);

	console.log("Done");
} catch (error) {
	console.error(new Error("An error occurred", { cause: error }));
}

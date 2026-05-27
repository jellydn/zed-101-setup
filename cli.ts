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

const filePath = path.join(__dirname, "README.md");

const readFileSync = (filePath: string) => {
	if (!fs.existsSync(filePath)) {
		throw new Error(`File ${filePath} does not exist.`);
	}
	return fs.readFileSync(filePath, "utf8");
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

try {
	const settings = readFileSync(path.join(__dirname, "settings.json"));
	const keymap = readFileSync(path.join(__dirname, "keymap.json"));
	const tasks = readFileSync(path.join(__dirname, "tasks.json"));
	const data = readFileSync(filePath);

	const settingsMarkdown = generateMarkdown("settings.json", settings);
	const keymapsMarkdown = generateMarkdown("keymap.json", keymap);
	const tasksMarkdown = generateMarkdown("tasks.json", tasks);

	let result = data.replace(
		/(<!-- ALL-SETTINGS:START -->)[\s\S]*?(<!-- ALL-SETTINGS:END -->)/gs,
		`$1\n${settingsMarkdown}\n$2`,
	);
	result = result.replace(
		/(<!-- ALL-KEYMAPS:START -->)[\s\S]*?(<!-- ALL-KEYMAPS:END -->)/gs,
		`$1\n${keymapsMarkdown}\n$2`,
	);
	result = result.replace(
		/(<!-- ALL-TASKS:START -->)[\s\S]*?(<!-- ALL-TASKS:END -->)/gs,
		`$1\n${tasksMarkdown}\n$2`,
	);

	fs.writeFileSync(filePath, result);

	// Format with prettier to pass pre-commit hooks
	try {
		execFileSync("prettier", ["--write", filePath], {
			stdio: "pipe",
			timeout: 10000,
		});
	} catch {
		// prettier not available or failed — try via npx
		try {
			execFileSync("npx", ["-y", "prettier", "--write", filePath], {
				stdio: "pipe",
				timeout: 15000,
			});
		} catch (npxError) {
			if (isMissingExecutableError(npxError)) {
				console.warn(
					"Warning: prettier not found — README.md may not match pre-commit style",
				);
			} else {
				// prettier ran but failed — signal failure
				console.error(
					"Error: prettier formatting failed — README.md may not match pre-commit style",
				);
				process.exitCode = 1;
			}
		}
	}

	console.log("Done");
} catch (error) {
	console.error(new Error("An error occurred", { cause: error }));
}

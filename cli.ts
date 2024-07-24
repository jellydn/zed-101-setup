import fs from "node:fs";
import path from "node:path";

/**
 * NOTE: Ensure you have copied your latest configuration before replacing it. Use the following commands:
 *
 * ```bash
 * cp ~/.config/zed/keymap.json keymap.json
 * cp ~/.config/zed/settings.json settings.json
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

try {
	const settings = readFileSync(path.join(__dirname, "settings.json"));
	const keymap = readFileSync(path.join(__dirname, "keymap.json"));
	const data = readFileSync(filePath);

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

	fs.writeFileSync(filePath, result);
	console.log("Done");
} catch (error) {
	console.error(new Error("An error occurred", { cause: error }));
}

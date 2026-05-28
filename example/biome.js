// JavaScript example for testing Biome LSP features
// Uncomment the biome block in settings.json's "lsp" section to test.
//
// Features exercised:
//   - formatter (indentStyle, indentWidth, lineWidth, quoteStyle, semicolons)
//   - linter rule targets
//   - organize imports

// ── Formatter: quote style & semicolons ────────────────────────────────────
// Biome configured with `"quoteStyle": "double"` and `"semicolons": "always"`
// keeps strings double-quoted and statements semicolon-terminated.

const _name = "Biome";
const _version = "2.0";

// ── Formatter: indent style (tabs) ─────────────────────────────────────────
// With `"indentStyle": "tab"`, Biome reformats to use tabs for indentation.

function greet(person) {
	if (!person) {
		return "Hello, world!";
	}
	console.log("greeting", person);
	return `Hello, ${person}!`;
}

// ── Formatter: trailing commas ─────────────────────────────────────────────
// `"trailingCommas": "all"` adds trailing commas in arrays, objects, and
// function parameters.

const fruits = [
	"apple",
	"banana",
	"cherry", // trailing comma added by biome
];

const config = {
	port: 3000,
	host: "localhost", // trailing comma added by biome
};

// ── Linter: no unused variables ────────────────────────────────────────────
// Remove the underscore prefix to see Biome's unused-variable diagnostic.

function calculate() {
	const _unusedVar = 42; // linter: unused variable
	return 0;
}

// ── Linter: prefer const over var ───────────────────────────────────────────
// This target keeps the old spelling visible while avoiding repo lint failures.

var _oldStyle = "should be const"; // linter: useConst

// ── Linter: no double equals ──────────────────────────────────────────────
// Change this comparison to `==` to see Biome suggest `===`.

function isEqual(a, b) {
	return a === b; // linter: use ===
}

// ── Organize imports ───────────────────────────────────────────────────────
// Running "organize imports" keeps imports and exports sorted.

import { readFileSync } from "node:fs";
import { join } from "node:path";

const _data = readFileSync(join(".", "config.json"), "utf-8");

export { calculate, config, fruits, greet, isEqual };

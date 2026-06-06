// JavaScript example for testing Biome LSP features.
// Uncomment the biome block in settings.json's "lsp" section to test.

const _name = "Biome";
const _version = "2.0";

function greet(person) {
	if (!person) {
		return "Hello, world!";
	}
	console.log("greeting", person);
	return `Hello, ${person}!`;
}

const fruits = ["apple", "banana", "cherry"];

const config = {
	port: 3000,
	host: "localhost",
};

function calculate() {
	const _unusedVar = 42;
	return 0;
}

var _oldStyle = "should be const";

function isEqual(a, b) {
	return a === b;
}

import { readFileSync } from "node:fs";
import { join } from "node:path";

const _data = readFileSync(join(".", "config.json"), "utf-8");

export { calculate, config, fruits, greet, isEqual };

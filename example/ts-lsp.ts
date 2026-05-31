// TypeScript example for testing vtsls LSP features.
// Uncomment the vtsls block in settings.json's "lsp" section to test.

class User {
	id = 0;
	name = "";
	email = "";
	role = "user" as const;

	constructor(id: number, name: string, email: string) {
		this.id = id;
		this.name = name;
		this.email = email;
	}

	get displayName(): string {
		return `${this.name} <${this.email}>`;
	}
}

const _sampleUser = new User(1, "Alice", "alice@example.com");

function greet(name: string, greeting?: string) {
	const prefix = greeting ?? "Hello";
	return `${prefix}, ${name}!`;
}

function multiply(factor: number) {
	return (value: number) => value * factor;
}

const _message = greet("Alice", "Hi");

const numbers = [10, 20, 30, 40, 50];
const doubled = multiply(2);
const _mapped = numbers.map(doubled);

import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
export const configPath = join(__dirname, "config.json");

function identity<T>(value: T): T {
	return value;
}

const _str = identity("hello");

type Processor = (item: string, index: number) => string;

const processors: Processor[] = [];

processors.push((item, index) => `${index}: ${item}`);

const _flags = new Set(["--verbose", "--quiet"]);

const _cache = new Map<string, number>();

export function processAll(items: string[]): string[] {
	return items
		.map((item) => item.trim().toLowerCase())
		.filter((item) => item.length > 0)
		.map((item) => `[${item}]`);
}

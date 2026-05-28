// TypeScript example for testing vtsls LSP features
// Uncomment the vtsls block in settings.json's "lsp" section to test.
//
// Features exercised:
//   - inlayHints (parameterNames, parameterTypes, variableTypes, returnType,
//     propertyDeclarationTypes)
//   - suggest.autoImports (import suggestions from node_modules)
//   - suggest.completeFunctionCalls (complete with parens + args)
//   - preferences.includePackageJsonAutoImports
//   - preferences.organizeImports
//   - format (indentSize, tabSize)

// ── Property-declaration-type hints ────────────────────────────────────────
// propertyDeclarationTypes should show inferred types on class fields and
// object properties that lack explicit annotations.

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

// ── Parameter-name & parameter-type hints ──────────────────────────────────
// On function call, vtsls inlay hints show parameter names and types.

function greet(name: string, greeting?: string) {
	const prefix = greeting ?? "Hello";
	return `${prefix}, ${name}!`;
}

// ── Return-type hint ───────────────────────────────────────────────────────
// returnType shows the inferred return type next to the closing brace.

function multiply(factor: number) {
	return (value: number) => value * factor;
	//   ^ returnType: (value: number) => number
}

// ── Complete function calls ────────────────────────────────────────────────
// When you type `greet(`, completeFunctionCalls fills `name, greeting`.

const _message = greet("Alice", "Hi");

const numbers = [10, 20, 30, 40, 50];
const doubled = multiply(2);
const _mapped = numbers.map(doubled);

// ── Organize imports ───────────────────────────────────────────────────────
// Grouped imports should be organized by `organize imports`.

import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

// Unrelated group (node:url) should merge into one node: import group.

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
export const configPath = join(__dirname, "config.json");

// ── Inlay hints with generics ─────────────────────────────────────────────
// parameterTypes hints show generic type arguments.

function identity<T>(value: T): T {
	return value;
}

const _str = identity("hello");
//             ^^^^^^^^ parameterTypes: <string>

// ── Parameter-name hints in callbacks ─────────────────────────────────────

type Processor = (item: string, index: number) => string;

const processors: Processor[] = [];

processors.push((item, index) => `${index}: ${item}`);
//               ^^^^  ^^^^^  parameterNames

// ── Variable-type hints ────────────────────────────────────────────────────

const _flags = new Set(["--verbose", "--quiet"]);
//    ^^^^^ variableTypes: Set<string>

const _cache = new Map<string, number>();
//    ^^^^^ variableTypes: Map<string, number>

// ── Integration ────────────────────────────────────────────────────────────

export function processAll(items: string[]): string[] {
	return items
		.map((item) => item.trim().toLowerCase())
		.filter((item) => item.length > 0)
		.map((item) => `[${item}]`);
}

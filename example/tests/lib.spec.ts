import { describe, expect, test } from "bun:test";
import { calculateAge } from "../lib";

describe("lib", () => {
	test("calculate age", () => {
		expect(calculateAge(1988)).toBe(36);
	});
});

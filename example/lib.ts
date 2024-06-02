/**
 * Calculate the age of a person based on the year of birth
 * @param bornInYear The year the person was born
 */
export function calculateAge(bornInYear: number): number {
	const currentYear = new Date().getFullYear();
	return currentYear - bornInYear;
}

export function greeter(name: string): void {
	console.log(`Hello ${name}`);
}

/**
 * Calculate the age of a person based on the year of birth
 * @param bornInYear The year the person was born
 */
export function calculateAge(bornInYear: number) {
	const currentYear = new Date().getFullYear();
	return currentYear - bornInYear;
}

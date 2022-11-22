// Kadane's
export default function findMaxSublistSum(list: Array<number>) {
  let maximum = -Infinity;
  let current = 0;
  for (const element of list) {
    current += element;
    current = Math.max(current, element);
    maximum = Math.max(current, maximum);
  }
  return maximum;
}

if (import.meta.vitest) {
  const input = [-10, -20, 10, 20, -10, -50, 10, 20, 40, -20];
  const result = findMaxSublistSum(input);
  it("Should return a number", () => {
    expect(result).toBeTypeOf("number");
  });
  it("Should not modify the original array", () => {
    expect(input).toEqual([-10, -20, 10, 20, -10, -50, 10, 20, 40, -20]);
  });
  it("Should return the correct maximum sublist sum", () => {
    expect(result).toBe(70);
    expect(findMaxSublistSum([-5, -10, 40, 5, -5, 10, -90])).toBe(50);
  });
}

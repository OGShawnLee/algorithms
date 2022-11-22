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

export function findMaxSublistSumBruteforce(list: number[]) {
  let count = 0;
  for (let index = 0; index < list.length; index++) {
    for (let idx = index; idx < list.length; idx++) {
      let localCount = 0;
      for (let i = index; i <= idx; i++) localCount += list[i];
      count = Math.max(count, localCount);
    }
  }
  return count;
}

if (import.meta.vitest) {
  const input = [-10, -20, 10, 20, -10, -50, 10, 20, 40, -20];
  const result = findMaxSublistSum(input);
  it("Should return a number", () => {
    expect(result).toBeTypeOf("number");
    expect(findMaxSublistSumBruteforce(input)).toBeTypeOf("number");
  });
  it("Should not modify the original array", () => {
    expect(input).toEqual([-10, -20, 10, 20, -10, -50, 10, 20, 40, -20]);
    findMaxSublistSumBruteforce(input);
    expect(input).toEqual([-10, -20, 10, 20, -10, -50, 10, 20, 40, -20]);
  });
  it("Should return the correct maximum sublist sum", () => {
    expect(result).toBe(70);
    expect(findMaxSublistSumBruteforce(input)).toBe(70);
    const collection = [-5, -10, 40, 5, -5, 10, -90];
    expect(findMaxSublistSum(collection)).toBe(50);
    expect(findMaxSublistSumBruteforce(collection)).toBe(50);
  });
}

import { fastfindMaxSequenceSum, findMaxSequenceSum } from "@list";

const input = [1, 2, 3, -10];
const functions = [fastfindMaxSequenceSum, findMaxSequenceSum];

it("Should return a number", () => {
  for (const fn of functions) {
    expect(fn(input)).toBeTypeOf("number");
  }
});

it("Should return the maximum sum of a contiguous sublist", () => {
  for (const fn of functions) {
    expect(fn(input)).toBe(6);
    expect(fn([0, 2, 3, -10, 50])).toBe(50);
    expect(fn([-10, 1, 2, -20, 3, 5, -540])).toBe(8);
  }
});

it("Should not mutate the given list", () => {
  const input = [10, 20, 30, -100, 50];
  for (const fn of functions) {
    expect(fn(input)).toBe(60);
    expect(input).toEqual([10, 20, 30, -100, 50]);
  }
});

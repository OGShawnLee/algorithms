import { findMaxSequenceSum } from "@list";

const total = findMaxSequenceSum([1, 2, 3, -10]);

it("Should return a number", () => {
  expect(total).toBeTypeOf("number");
});

it("Should return the maximum sum of a contiguous sublist", () => {
  expect(total).toBe(6);
  expect(findMaxSequenceSum([0, 2, 3, -10, 50])).toBe(50);
  expect(findMaxSequenceSum([-10, 1, 2, -20, 3, 5, -540])).toBe(8);
});

it("Should not mutate the given list", () => {
  const input = [10, 20, 30, -100, 50];
  expect(findMaxSequenceSum(input)).toBe(60);
  expect(input).toEqual([10, 20, 30, -100, 50]);
});

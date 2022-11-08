import { expect, it } from "vitest";
import { getIntervalSumRecursive } from "@list";

const interval = getIntervalSumRecursive([
  [1, 2],
  [6, 10],
  [11, 15],
]);

it("Should return a number", () => {
  expect(interval).toBeTypeOf("number");
});

it("Should return the sum of the given intervals", () => {
  expect(interval).toBe(9);
  expect(
    getIntervalSumRecursive([
      [1, 4],
      [7, 10],
      [3, 5],
    ])
  ).toBe(7);
  expect(
    getIntervalSumRecursive([
      [1, 5],
      [10, 20],
      [1, 6],
      [16, 19],
      [5, 11],
    ])
  ).toBe(19);
  expect(
    getIntervalSumRecursive([
      [0, 20],
      [-100000000, 10],
      [30, 40],
    ])
  ).toBe(100000030);
});

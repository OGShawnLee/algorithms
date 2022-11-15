import { getDesiredSublistSum } from "@list";

const input = [1, 7, 9, 4, 3, 2, 2];
const sublist = getDesiredSublistSum([1, 7, 9, 4, 3, 2, 2], 7);

it("Should return an array of subarrays of numbers", () => {
  expect(sublist).toBeInstanceOf(Array);
  expect(sublist.every((list) => list.every((num) => typeof num === "number"))).toBe(true);
});

it("Should return an array of subarrays where each one adds up to the desired sum", () => {
  expect(sublist).toEqual([[7], [4, 3], [3, 2, 2]]);
  expect(getDesiredSublistSum(input, 9)).toEqual([[9], [4, 3, 2]]);
  expect(getDesiredSublistSum(input, 4)).toEqual([[4], [2, 2]]);
  const list = [23, 1, 6, 9, 15, 8];
  expect(getDesiredSublistSum(list, 24)).toEqual([
    [23, 1],
    [9, 15],
  ]);
  expect(getDesiredSublistSum(list, 15)).toEqual([[6, 9], [15]]);
});

it("Should return a different array", () => {
  expect(sublist).not.toBe(input);
});

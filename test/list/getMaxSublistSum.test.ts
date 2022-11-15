import { getMaxSublistSum } from "@list";

const input = [-1, 2, 3, 0, -3, 9];
const output = getMaxSublistSum(input, 3);

it("Should return an array or numbers", () => {
  expect(output).toBeInstanceOf(Array);
  expect(output.every((element) => typeof element === "number")).toBe(true);
});

it("Should return a different array", () => {
  expect(output).not.toBe(input);
});

it("Should not mutate the original array", () => {
  expect(input).toEqual([-1, 2, 3, 0, -3, 9]);
});

it("Should return the sublist of the given length that adds up to the maximum value", () => {
  expect(output).toHaveLength(3);
  expect(output).toEqual([0, -3, 9]);
  let result = getMaxSublistSum(input, 2);
  expect(result).toHaveLength(2);
  expect(result).toEqual([-3, 9]);
  const collection = [10, 20, -80, -12, -12, 90];
  result = getMaxSublistSum(collection, 2);
  expect(result).toHaveLength(2);
  expect(result).toEqual([-12, 90]);
  result = getMaxSublistSum(collection, 4);
  expect(result).toHaveLength(4);
  expect(result).toEqual([-80, -12, -12, 90]);
  result = getMaxSublistSum([6, -3, -5, 1, 2, 0, 4], 4);
  expect(result).toHaveLength(4);
  expect(result).toEqual([1, 2, 0, 4]);
});

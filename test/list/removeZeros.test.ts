import { moveZerosToTheEnd } from "@list";

it("Should return a list of numbers", () => {
  const value = moveZerosToTheEnd([1, 0, 2, 0, 3, 0, 4]);
  expect(value).toBeInstanceOf(Array);
  expect(value.every((element) => typeof element === "number")).toBe(true);
});

it("Shoud return the same list (modify in place)", () => {
  const input = [1, 0, 0, 2, 0, 0, 3];
  const result = moveZerosToTheEnd(input);
  expect(result).toBe(input);
  expect(input).toEqual([1, 2, 3, 0, 0, 0, 0]);
});

it("Should move all zeros to the end", () => {
  expect(moveZerosToTheEnd([1, 2, 0, 3])).toEqual([1, 2, 3, 0]);
  expect(moveZerosToTheEnd([1, 2, 0, 3, 0, 4])).toEqual([1, 2, 3, 4, 0, 0]);
  expect(moveZerosToTheEnd([1, 2, 0, 3, 0, 0, 0, 4])).toEqual([1, 2, 3, 4, 0, 0, 0, 0]);
  expect(moveZerosToTheEnd([7, 2, 3, 0, 4, 6, 0, 0, 13, 0, 78, 0, 0, 19, 14])).toEqual([
    7, 2, 3, 4, 6, 13, 78, 19, 14, 0, 0, 0, 0, 0, 0,
  ]);
});

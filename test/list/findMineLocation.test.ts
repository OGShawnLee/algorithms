import { findMineLocation } from "@list";

const location = findMineLocation([
  [0, 0, 0],
  [0, 0, 1],
  [0, 0, 0],
]);

it("Should return a tuple: [number, number]", () => {
  expect(location).toBeInstanceOf(Array);
  expect(location).toHaveLength(2);
  expect(location[0]).toBeTypeOf("number");
  expect(location[1]).toBeTypeOf("number");
});

it("Should return the location of the bomb as [row, column]", () => {
  expect(location).toEqual([1, 2]);
  expect(
    findMineLocation([
      [0, 0, 0],
      [0, 0, 0],
      [0, 1, 0],
    ])
  ).toEqual([2, 1]);
});

it("Should throw if there is no mine", () => {
  expect(() => findMineLocation([[0, 0, 0]])).toThrow();
});

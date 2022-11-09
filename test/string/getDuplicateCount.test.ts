import { getDuplicateCount } from "@string";

it("Should return a number", () => {
  expect(getDuplicateCount("this is a string")).toBeTypeOf("number");
});

it("Should return the amount of duplicated letters", () => {
  expect(getDuplicateCount("no duplicates")).toBe(0);
  expect(getDuplicateCount("has duplicates")).toBe(2);
  expect(getDuplicateCount("interesting story")).toBe(6);
});

it("Should be case insensitive", () => {
  expect(getDuplicateCount("Kaskis")).toBe(2);
});

it("Should ignore whitespace and include numbers", () => {
  expect(getDuplicateCount("1 1 2 2")).toBe(2);
  expect(getDuplicateCount("1 0 2 9")).toBe(0);
});

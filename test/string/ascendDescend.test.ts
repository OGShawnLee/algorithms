import { ascendDescend } from "@string";

const str = ascendDescend(9, 1, 5);

it("Should return a string", () => {
  expect(str).toBeTypeOf("string");
});

it("Should return the correct sequence", () => {
  expect(str).toBe("123454321");
  expect(ascendDescend(14, 0, 2)).toBe("01210121012101");
});

it("Should limit the length of the string to the given length", () => {
  const str = ascendDescend(11, 5, 9);
  expect(str).toHaveLength(11);
  expect(str).toBe("56789876567");
});

it("Should return an empty string if length is 0", () => {
  const str = ascendDescend(0, 5, 5);
  expect(str).toHaveLength(0);
  expect(str).toBe("");
});

it("Should return a repeated char when min === max", () => {
  const str = ascendDescend(5, 5, 5);
  expect(str).toHaveLength(5);
  expect(str).toBe("55555");
});

it("Should handle negative min and max values", () => {
  let str = ascendDescend(5, -5, 5);
  expect(str).toBe("-5-4-");
  expect(str).toHaveLength(5);
  str = ascendDescend(12, -5, -1);
  expect(str).toBe("-5-4-3-2-1-2");
  expect(str).toHaveLength(12);
  str = ascendDescend(12, -3, 5);
  expect(str).toBe("-3-2-1012345");
  expect(str).toHaveLength(12);
});

it("Should return an empty string if length is negative", () => {
  expect(ascendDescend(-3, 1, 2)).toBe("");
});

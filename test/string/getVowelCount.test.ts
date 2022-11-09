import { getVowelCount } from "@string";

it("Should return a number", () => {
  expect(getVowelCount("this is a string!")).toBeTypeOf("number");
});

it("Should be the total number of vowels in the given string", () => {
  expect(getVowelCount("i have many vowels!")).toBe(6);
});

it("Should be case insensitive", () => {
  expect(getVowelCount("i DON'T hAvE mAny vowels!")).toBe(7);
});

it("Should count all vowels (a, e...)", () => {
  expect(getVowelCount("aeiou!")).toBe(5);
});

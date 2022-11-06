import { it, expect } from "vitest";
import { findCommonChar } from "../../src/string";

const count = findCommonChar("aabbca");

it("Should return an object", () => {
  expect(count).toBeInstanceOf(Object);
});

it("Should return an object of type CharCount", () => {
  expect(count).toHaveProperty("char");
  expect(count).toHaveProperty("count");
  expect(count.char).toBeTypeOf("string");
  expect(count.count).toBeTypeOf("number");
});

it("char must be the common character and count the amount of times it appears in the given string", () => {
  expect(findCommonChar("for honor!")).toEqual({ char: "o", count: 3 });
});

it("Should return the CharCount of the common character", () => {
  expect(count).toEqual({ char: "a", count: 3 });
  expect(findCommonChar("abababb")).toEqual({ char: "b", count: 4 });
  expect(findCommonChar("cabababbcccc")).toEqual({ char: "c", count: 5 });
});

it("Should be case sensitive", () => {
  expect(findCommonChar("ababaAbb")).toEqual({ char: "b", count: 4 });
  expect(findCommonChar("BBBbaAA")).toEqual({ char: "B", count: 3 });
});

it("Should count whitespace as well", () => {
  expect(findCommonChar("you can't hurt me, jack")).toEqual({ char: " ", count: 4 });
});

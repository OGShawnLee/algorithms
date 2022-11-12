import reduce, { gcd, lcm, sum } from "@list/reduce";

const input = [18, 69, -90, -78, 65, 40];

it("Should return an array", () => {
  expect(reduce(input, 0, sum)).toBeInstanceOf(Array);
});

it("Should return a new array", () => {
  expect(reduce(input, 0, sum)).not.toBe(input);
  expect(input).toEqual([18, 69, -90, -78, 65, 40]);
});

it("Should return a list with every element being the result of the given function", () => {
  const input = [18, 69, -90, -78, 65, 40];
  expect(reduce(input, 0, sum)).toEqual([18, 87, -3, -81, -16, 24]);
  expect(reduce(input, input[0], gcd)).toEqual([18, 3, 3, 3, 1, 1]);
  expect(reduce(input, input[0], lcm)).toEqual([18, 414, 2070, 26910, 26910, 107640]);
});

it("Should pass the given initial value to the function on the first run", () => {
  const fn = vi.fn((a: number, b: number) => sum(a, b));
  reduce([3, 24, 90], 0, fn);
  expect(fn.mock.calls[0]).toEqual([0, 3]);
});

it("Should call the function once for every input list element", () => {
  const fn = vi.fn((a: number, b: number) => sum(a, b));
  reduce([3, 24, 90, -45, 1270], 0, fn);
  expect(fn).toBeCalledTimes(5);
});

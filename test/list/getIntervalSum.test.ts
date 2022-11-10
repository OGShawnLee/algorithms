import type { Interval } from "@list";
import { getIntervalSum, getIntervalSumRecursive } from "@list";

const functions = [getIntervalSum, getIntervalSumRecursive];

it("Should return a number", () => {
  const intervals: Interval[] = [
    [1, 2],
    [6, 10],
    [11, 15],
  ];
  for (const func of functions) {
    expect(func(intervals)).toBeTypeOf("number");
  }
});

it("Should return the sum of the given intervals", () => {
  const intervals: Array<{ interval: Interval[]; expected: number }> = [
    {
      interval: [
        [1, 4],
        [7, 10],
        [3, 5],
      ],
      expected: 7,
    },
    {
      interval: [
        [1, 5],
        [10, 20],
        [1, 6],
        [16, 19],
        [5, 11],
      ],
      expected: 19,
    },
    {
      interval: [
        [0, 20],
        [-100000000, 10],
        [30, 40],
      ],
      expected: 100_000_030,
    },
  ];

  for (const { expected, interval } of intervals) {
    for (const func of functions) {
      expect(func(interval)).toBe(expected);
    }
  }
});

type Interval = [number, number];

export default function getIntervalSum(intervals: Array<Interval>): number {
  let sum = 0;

  for (let index = 0; index < intervals.length; index++) {
    let [minimum, maximum] = intervals[index];

    for (let idx = 0; idx < intervals.length; idx++) {
      if (index === idx) continue;
      const [min, max] = intervals[idx];
      if (isOverlapped(minimum, { min, max }) || isOverlapped(maximum, { min, max })) {
        if (min < minimum) minimum = min;
        if (max > maximum) maximum = max;
        // dirty but faster
        intervals[index] = [minimum, maximum];
        intervals.splice(idx, 1);
        return getIntervalSum(intervals);
      }
    }

    sum += maximum - minimum;
  }

  return sum;
}

export function isOverlapped(num: number, range: { min?: number; max?: number } = {}) {
  const { min = 0, max = Infinity } = range;
  return num >= min && num < max;
}

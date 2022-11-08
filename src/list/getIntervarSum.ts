type Interval = [number, number];

export default function getIntervalSumRecursive(intervals: Array<Interval>): number {
  let sum = 0;

  for (let index = 0; index < intervals.length; index++) {
    let [minimum, maximum] = intervals[index];

    for (let idx = 0; idx < intervals.length; idx++) {
      if (index === idx) continue;
      const [min, max] = intervals[idx];
      if (isOverlapped(intervals[idx], intervals[index])) {
        if (min < minimum) minimum = min;
        if (max > maximum) maximum = max;
        // dirty but faster
        intervals[index] = [minimum, maximum];
        intervals.splice(idx, 1);
        return getIntervalSumRecursive(intervals);
      }
    }

    sum += maximum - minimum;
  }

  return sum;
}

function isOverlapped([minimum, maximum]: Interval, [min, max]: Interval) {
  return Math.max(maximum, max) - Math.min(minimum, min) < maximum - minimum + (max - min);
}

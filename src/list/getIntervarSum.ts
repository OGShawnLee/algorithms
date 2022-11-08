export type Interval = [number, number];

export function getIntervarSum(intervals: Interval[]) {
  let isDirty = false;
  do {
    initial: for (let index = 0; index < intervals.length; index++) {
      let [minimum, maximum] = intervals[index];
      isDirty = false;
      for (let i = 0; i < intervals.length; i++) {
        const [min, max] = intervals[i];
        if (intervals[index] === intervals[i]) continue;
        if (isOverlapped(intervals[index], intervals[i])) {
          isDirty = true;
          if (min < minimum) minimum = min;
          if (max > maximum) maximum = max;
          intervals[index][0] = minimum;
          intervals[index][1] = maximum;
          intervals.splice(i, 1);
          break initial;
        }
      }
    }
  } while (isDirty);
  return intervals.reduce((total, [min, max]) => total + max - min, 0);
}

export function getIntervalSumRecursive(intervals: Array<Interval>): number {
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

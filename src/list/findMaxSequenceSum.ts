export default function findMaxSequenceSum(input: number[]) {
  if (input.length === 0) return 0;
  let count = 0;
  for (let index = 0; index < input.length; index++) {
    for (let idx = index; idx < input.length; idx++) {
      let total = 0;
      for (let i = index; i <= idx; i++) total += input[i];
      if (total > count) count = total;
    }
  }
  return count;
}

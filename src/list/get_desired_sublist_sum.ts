// ref: https://github.com/soygul/QuanticDev/blob/master/algorithms/dynamic-programming/sliding-window/desired-subarray-sum.js

export default function getDesiredSublistSum(input: number[], desiredSum: number) {
  const output: Array<number[]> = [];
  let sum = 0;
  let sumStartIndex = 0;
  for (let index = 0; index < input.length; index++) {
    const number = input[index];
    sum += number;
    while (sum > desiredSum) {
      sum -= input[sumStartIndex];
      sumStartIndex++;
    }
    if (sum === desiredSum) output.push(input.slice(sumStartIndex, index + 1));
  }
  return output;
}

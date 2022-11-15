// ref: https://github.com/soygul/QuanticDev/blob/master/algorithms/dynamic-programming/sliding-window/max-subarray-sum.js

export default function getMaxSublistSum(input: number[], sublistLength: number) {
  let maxCount = 0;
  let maxCountStartIndex = 0;
  let currentCount = 0;
  for (let index = 0; index < input.length; index++) {
    currentCount += input[index];
    if (index < sublistLength) {
      maxCount = currentCount;
    } else {
      currentCount -= input[index - sublistLength];
      if (currentCount > maxCount) {
        maxCount = currentCount;
        maxCountStartIndex = index - sublistLength + 1;
      }
    }
  }
  return input.slice(maxCountStartIndex, maxCountStartIndex + sublistLength);
}

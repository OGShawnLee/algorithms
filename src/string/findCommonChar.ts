export interface CharCount {
  char: string;
  count: number;
}

interface CommonCharCache {
  [letter: string]: CharCount;
  max: CharCount;
}

export default function findCommonChar(str: string): CharCount {
  const firstCharCount = getCharCount(str[0], str);
  const cache: CommonCharCache = { [str[0]]: firstCharCount, max: firstCharCount };

  for (let index = 0; index < str.length; index++) {
    const char = str[index];
    if (char in cache) continue;
    const count = (cache[char] = getCharCount(char, str));
    if (count.count > cache.max.count) cache.max = count;
  }

  return cache.max;
}

function getCharCount(char: string, str: string): CharCount {
  let count = 0;

  for (let index = 0; index < str.length; index++) {
    const letter = str[index];
    if (char === letter) count++;
  }

  return { char, count: count };
}

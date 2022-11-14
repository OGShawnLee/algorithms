const vowels = { a: "a", e: "e", i: "i", o: "o", u: "u" };

export default function getVowelCount(str: string) {
  str = str.toLowerCase();
  let count = 0;

  for (let index = 0; index < str.length; index++) {
    const char = str[index];
    if (char in vowels) count++;
  }

  return count;
}

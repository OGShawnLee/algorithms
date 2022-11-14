import { NATO } from "@data";

export default function toNATO(string: string) {
  let str = "";
  for (let index = 0; index < string.length; index++) {
    const char = string[index].toUpperCase().trim();
    if (char) str += " " + (char in NATO ? NATO[char] : char);
  }
  return str.substring(1);
}

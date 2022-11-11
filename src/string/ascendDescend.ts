export default function ascendDescend(length: number, min: number, max: number) {
  if (length <= 0 || min > max) return "";
  let string = "";
  let number = min;
  let char = number.toString();
  if (min === max) return char.repeat(length);
  let isGoingUp = number < max;
  for (let index = 0; string.length < length; index++) {
    if (isGoingUp) {
      number++;
      if (number == max) isGoingUp = false;
    } else {
      number--;
      if (number == min) isGoingUp = true;
    }
    string += char;
    char = number.toString();
  }
  return string.substring(0, length);
}

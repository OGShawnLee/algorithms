export default function reduce(
  input: number[],
  initial: number,
  fn: (a: number, b: number) => number
) {
  const output: number[] = [];
  if (input.length === 0) return output;
  output[0] = fn(initial, input[0]);
  for (let index = 1; index < input.length; index++)
    output[index] = fn(output[index - 1], input[index]);
  return output;
}

export function gcd(a: number, b: number): number {
  a = Math.abs(a);
  b = Math.abs(b);
  while (b) {
    const t = b;
    b = a % b;
    a = t;
  }
  return a;
}

export function lcm(a: number, b: number): number {
  return a && b ? Math.abs((a * b) / gcd(a, b)) : 0;
}

export function sum(a: number, b: number) {
  return a + b;
}

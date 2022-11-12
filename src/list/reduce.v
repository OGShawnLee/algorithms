module list
import math

pub fn reduce(input []int, func fn (int, int) int, initial_value int) []int {
	mut output := []int{ len: input.len }
	if input.len == 0 { return output }
	output[0] = func(initial_value, input[0])
	for index := 1; index < input.len; index++ {
		output[index] = func(output[index - 1], input[index])
	}
	return output
}

pub fn gcd(foo int, bar int) int {
	mut a := math.abs(foo)
	mut b := math.abs(bar)
	for {
		t := b
		b = a % b
		a = t
		if b == 0 { break }
	}
	return a
}

pub fn lcm(a int, b int) int {
	if a == 0 || b == 0 { return 0 }
	return math.abs((a * b) / gcd(a, b))
}

pub fn max(a int, b int) int {
	return if a > b { a } else { b }	
}

pub fn min(a int, b int) int {
	return if a > b { b } else { a }
}

pub fn sum(a int , b int) int {
	return a + b
}
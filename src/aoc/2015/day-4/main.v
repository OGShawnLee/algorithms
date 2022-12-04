import crypto.md5 { hexhash }

const secret_key = "iwrupvqb"

fn main() {
	hashed, number := find_coin_hash(secret_key)
	println("Correct Hash: $hashed | Number: $number")
}

fn find_coin_hash(key string) (string, int) {
	mut index := 0
	for {
		hashed := hexhash(key + index.str())
		if is_correct_hash(hashed) { return hashed, index }  	
		index++
	}
	panic("Something Went Horribly Wrong")
}

fn is_correct_hash(hashed string) bool {
	return hashed[0..5] == "00000"
}

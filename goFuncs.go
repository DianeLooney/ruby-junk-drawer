package main

import "C"

//export GoIntSlice
func GoIntSlice(a, b, c, d C.int) []C.int {
	return []C.int{a, b, c, d}
}

//export GoAdd
func GoAdd(a, b C.int) C.int {
	return a + b
}

func main() {} // Required but ignored

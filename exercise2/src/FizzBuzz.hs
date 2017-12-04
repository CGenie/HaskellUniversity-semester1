module FizzBuzz (
  fizzbuzz,
  fizzbuzzUpTo
) where

fizzbuzz :: Int -> String
fizzbuzz number
  | number `mod` 15 == 0 = "fizzbuzz"
  | number `mod` 3 == 0  = "fizz"
  | number `mod` 5 == 0  = "buzz"
  | otherwise            = show number

fizzbuzzUpTo limit = [fizzbuzz x | x <- [1..limit]]

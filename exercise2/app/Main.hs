module Main where

import System.Environment (getArgs)

import FizzBuzz (fizzbuzzUpTo)
import QuickSort (quicksort)


fizzBuzzMain :: IO ()
fizzBuzzMain = do
  args <- getArgs
  let limit = read $ head args :: Int
  print $ fizzbuzzUpTo limit

quickSortMain :: IO ()
quickSortMain = do
  args <- getArgs
  let lst = map (\x -> read x :: Int) args
  print $ quicksort lst


--main = quickSortMain
main = fizzBuzzMain

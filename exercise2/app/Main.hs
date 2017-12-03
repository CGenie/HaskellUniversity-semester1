module Main where

import System.Environment (getArgs)

import QuickSort

main :: IO ()
main = do
  args <- getArgs
  let lst = map (\x -> read x :: Int) args
  print $ quicksort lst

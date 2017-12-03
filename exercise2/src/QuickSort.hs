module QuickSort
    ( quicksort
    ) where

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort [x] = [x]
quicksort (x:xs) = -- simple: x is pivot
  (quicksort left) ++ [x] ++ (quicksort right)
  where
    left = filter (<= x) xs
    right = filter (> x) xs

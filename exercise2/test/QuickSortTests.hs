{-# Language TemplateHaskell #-}
module QuickSortTests where

import Test.QuickCheck.Modifiers (NonEmptyList (..))
import Test.QuickCheck.All

import QuickSort (quicksort)


isNondecreasing :: [Int] -> Bool
isNondecreasing [] = True
isNondecreasing [x] = True
isNondecreasing (x:y:ys) = and [x <= y, isNondecreasing (y:ys)]


prop_minHead :: NonEmptyList Int -> Bool
prop_minHead xs0 =
  let xs = getNonEmpty xs0
  in (minimum xs) == (head $ quicksort xs)

prop_maxTail :: NonEmptyList Int -> Bool
prop_maxTail xs0 =
  let xs = getNonEmpty xs0
  in (maximum xs) == (head $ reverse $ quicksort xs)

prop_idempotent :: [Int] -> Bool
prop_idempotent lst = (quicksort $ quicksort lst) == (quicksort lst)

prop_isNondecreasing :: [Int] -> Bool
prop_isNondecreasing lst = isNondecreasing $ quicksort lst


-- template haskell magic
return []
runTests :: IO Bool
runTests = $quickCheckAll

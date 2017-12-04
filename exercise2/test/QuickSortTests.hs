{-# Language TemplateHaskell #-}
module QuickSortTests where

import Test.QuickCheck.Modifiers (NonEmptyList (..))
import Test.QuickCheck.All

import QuickSort (quicksort)


ordered :: [Int] -> Bool
ordered [] = True
ordered xs = and $ zipWith (<=) xs (drop 1 xs)


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

prop_ordered :: [Int] -> Bool
prop_ordered lst = ordered $ quicksort lst


-- template haskell magic
return []
runTests :: IO Bool
runTests = $quickCheckAll

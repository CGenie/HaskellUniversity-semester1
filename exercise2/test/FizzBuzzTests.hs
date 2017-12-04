{-# Language TemplateHaskell #-}
module FizzBuzzTests where

import Test.QuickCheck.Modifiers (NonEmptyList (..))
import Test.QuickCheck.All

import FizzBuzz (fizzbuzz, fizzbuzzUpTo)


--prop_fizzbuzzContainsFizz :: 


-- template haskell magic
return []
runTests :: IO Bool
runTests = $quickCheckAll

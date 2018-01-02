import Test.HUnit
import Test.Framework
import Test.Framework.Providers.HUnit

import qualified RPN


singleDigit :: Assertion
singleDigit = Right 2 @=? RPN.evaluateRPN "2"

multiDigit :: Assertion
multiDigit = Right 21 @=? RPN.evaluateRPN "21"

negativeMultiDigit :: Assertion
negativeMultiDigit = Right (-21) @=? RPN.evaluateRPN "-21"

float :: Assertion
float = Right 21.5 @=? RPN.evaluateRPN "21.5"

multiNumber :: Assertion
multiNumber = Right 21.5 @=? RPN.evaluateRPN "1 21.5"

plus :: Assertion
plus = Right 10.5 @=? RPN.evaluateRPN "1.5 9 +"

plusTwice :: Assertion
plusTwice = Right 10.5 @=? RPN.evaluateRPN "1.5 8 1 + +"

plusTwice' :: Assertion
plusTwice' = Right 10.5 @=? RPN.evaluateRPN "1.5 8 + 1 +"

minus :: Assertion
minus = Right 10.5 @=? RPN.evaluateRPN "11 0.5 -"

times :: Assertion
times = Right 5.5 @=? RPN.evaluateRPN "11 0.5 *"

divide :: Assertion
divide = Right 22.0 @=? RPN.evaluateRPN "11 0.5 /"


main :: IO ()
main = defaultMain
  [testCase "singleDigit" singleDigit
  ,testCase "multiDigit" multiDigit
  ,testCase "float" float
  ,testCase "multiNumber" multiNumber
  ,testCase "plus" plus
  ,testCase "plusTwice" plusTwice
  ,testCase "plusTwice'" plusTwice'
  ,testCase "minus'" minus
  ,testCase "times'" times
  ,testCase "divide'" divide
  ]

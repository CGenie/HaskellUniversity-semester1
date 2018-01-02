module RPN
    ( evaluateRPN
    , parseRPN
    ) where

import qualified Text.Megaparsec as M

import RPN.Data (Symbol(..), Token(..), Expression)
import RPN.Parser (parseRPN)


type ParseError = String

evaluateRPN :: String -> Either ParseError Double
evaluateRPN s = case (parseRPN s) of
  Left err    -> Left $ M.parseErrorPretty err
  Right exprs -> Right $ evaluate exprs

-- simple stack evaluator
evaluate :: Expression -> Double
evaluate = evaluateStack []


evaluateStack :: [Double] -> Expression -> Double
evaluateStack [] [] = 0.0
evaluateStack (x:xs) [] = x
evaluateStack _ [Number x] = x
evaluateStack xs (Number y:ys) = evaluateStack (y:xs) ys
evaluateStack (y:x:xs) (z:zs) =
  case z of
    TokenSymbol Plus -> evaluateStack (x + y:xs) zs
    TokenSymbol Minus -> evaluateStack (x - y:xs) zs
    TokenSymbol Times -> evaluateStack (x * y:xs) zs
    TokenSymbol Divide -> evaluateStack (x / y:xs) zs

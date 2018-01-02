module Main where

import Control.Monad (forever)

import RPN (evaluateRPN)

main :: IO ()
main = forever $ do
  putStrLn "Enter expression: "
  expression <- getLine
  case (evaluateRPN expression) of
    Left err -> putStrLn err
    Right value -> putStrLn $ show value

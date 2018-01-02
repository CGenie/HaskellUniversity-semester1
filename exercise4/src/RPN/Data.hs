module RPN.Data
  (
    Symbol(..)
  , Token(..)
  , Expression
  ) where


data Symbol = Plus | Minus | Times | Divide
  deriving (Show)
data Token = TokenSymbol Symbol | Number Double
  deriving (Show)
type Expression = [Token]

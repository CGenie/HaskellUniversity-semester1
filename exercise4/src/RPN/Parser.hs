module RPN.Parser
  ( parseRPN
  ) where


import Control.Applicative ((<|>), many, empty)
import Data.Char (isLetter, isDigit)
import Data.Void (Void)
import qualified Text.Megaparsec as M
import qualified Text.Megaparsec.Char as MC
import qualified Text.Megaparsec.Char.Lexer as L


import RPN.Data (Symbol(..), Token(..), Expression)


type Parser = M.Parsec Void String


parseRPN :: String -> Either (M.ParseError (M.Token String) Void) Expression
parseRPN s = M.parse parser "" s


parser :: Parser Expression
--parser = M.between sc M.eof tokens
parser = M.manyTill token M.eof

token :: Parser Token
token = num <|> symbol

num :: Parser Token
num = M.try numFloat <|> numInteger

symbol :: Parser Token
symbol = symbolPlus <|> symbolMinus <|> symbolTimes <|> symbolDivide

symbolPlus :: Parser Token
symbolPlus = do
  p <- L.symbol sc "+"
  return $ TokenSymbol Plus

symbolMinus :: Parser Token
symbolMinus = do
  p <- L.symbol sc "-"
  return $ TokenSymbol Minus

symbolTimes :: Parser Token
symbolTimes = do
  p <- L.symbol sc "*"
  return $ TokenSymbol Times

symbolDivide :: Parser Token
symbolDivide = do
  p <- L.symbol sc "/"
  return $ TokenSymbol Divide


sc :: Parser ()
sc = L.space MC.space1 empty empty

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

numInteger :: Parser Token
numInteger = do
  d <- lexeme L.decimal
  return $ Number (fromIntegral d :: Double)

numFloat :: Parser Token
numFloat = do
  d <- lexeme L.float
  return $ Number d

module ApplesOranges
    ( applesOrangesLoop
    ) where

import Control.Monad (forever)
import Control.Monad.Loops (unfoldWhileM)
import Data.Maybe (isJust, fromJust)


data Product = Apples | Oranges
  deriving (Eq, Show)


cost :: Product -> Double
cost Apples = 0.60
cost Oranges = 0.25

checkout :: [Product] -> Double
checkout [] = 0.0
checkout (x:xs) = cost x + costAll xs


shopPromptOne :: IO (Maybe Product)
shopPromptOne = do
  putStrLn "Scan an item (or empty to exit): "
  item <- getLine
  let product = case item of
        "apples" -> Just Apples
        "oranges" -> Just Oranges
        otherwise -> Nothing
  return product

shopPrompt :: IO [Maybe Product]
shopPrompt = unfoldWhileM (isJust) shopPromptOne

applesOranges :: IO ()
applesOranges = do
  putStrLn "Welcome, new customer!"
  itemsM <- shopPrompt
  let items = [fromJust item | item <- itemsM]
  putStrLn $ (show items) ++ " => " ++ (show $ checkout items)
  return ()

applesOrangesLoop :: IO ()
applesOrangesLoop = forever applesOranges

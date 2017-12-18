module ApplesOranges
    ( applesOrangesLoop
    ) where

import Control.Monad (forever)
import Control.Monad.Loops (unfoldWhileM)
import Data.Maybe (isJust, fromJust)


data Product = Apples | Oranges
  deriving (Eq, Show)

type Cart = [Product]


cost :: Product -> Double
cost Apples = 0.60
cost Oranges = 0.25

checkoutCart :: Cart -> Double
checkoutCart [] = 0.0
checkoutCart (x:xs) = cost x + checkoutCart xs

checkout :: Cart -> Double
checkout cart = checkoutCart cart - (sum [discount cart | discount <- discounts])

discounts :: [Cart -> Double]
discounts = [
  apples2for1,
  oranges3for2
            ]


apples2for1 = productNforMDiscount 2 1 Apples
oranges3for2 = productNforMDiscount 3 2 Oranges

productNforMDiscount :: Int -> Int -> Product -> Cart -> Double
productNforMDiscount n m product cart = numDiscounted * (fromIntegral (n - m) :: Double) * (cost product)
  where
    numProduct = countProductInCart product cart
    numDiscounted = fromIntegral $ numProduct `div` n :: Double

countProductInCart :: Product -> Cart -> Int
countProductInCart product cart = length $ filter (== product) cart


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

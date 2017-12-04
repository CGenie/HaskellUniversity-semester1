import qualified FizzBuzzTests as FBT
import qualified QuickSortTests as QCT

import System.Exit

main :: IO ()
main = do
  good <- and <$> sequence [FBT.runTests, QCT.runTests]
  if good
    then exitSuccess
    else exitFailure

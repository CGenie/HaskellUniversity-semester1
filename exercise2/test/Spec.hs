import qualified QuickSortTests as QCT

import System.Exit

main :: IO ()
main = do
  good <- and <$> sequence [QCT.runTests]
  if good
    then exitSuccess
    else exitFailure

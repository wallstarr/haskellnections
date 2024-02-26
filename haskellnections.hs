module Haskellnections where

import Data.Char
import Prelude hiding (Word)

-- Specific word used to form a connection
type Word = [Char]

-- Definition for a word
type Definition = [Char]

-- Reason surrounding a correct connection
type GroupingReason = [Char]

-- Horizontal line used to format word grid output
type Gridline = [Char]

-- An association between a word and its definition
data WordDefinition = WD Word Definition

-- A connection consisting of 4 words
data Connection = Connection Word Word Word Word

-- Custom equality implementation for Connection comparisons
instance Eq Connection where
  (Connection a1 a2 a3 a4) == (Connection b1 b2 b3 b4) =
    equivalent
      (map (map toLower) [a1, a2, a3, a4])
      (map (map toLower) [b1, b2, b3, b4])
    where
      equivalent [] [] = True
      equivalent l1@(h1 : t1) l2 = h1 `elem` l2 && equivalent t1 (filter (/= h1) l2)

-- Custom show implementation for Connections
instance Show Connection where
  show (Connection w1 w2 w3 w4) = w1 ++ " | " ++ w2 ++ " | " ++ w3 ++ " | " ++ w4

-- An association between a connection and the reason
data ConnectionGroup = ConnectionGroup Connection GroupingReason

-- Custom show implementation for ConnectionGroups
instance Show ConnectionGroup where
  show (ConnectionGroup connection reason) = (show connection) ++ " - " ++ reason

-- State of current game, containing all current words and correct connection group answers
data WordGrid = WordGrid [Word] [ConnectionGroup]

-- GRID PRINTING FUNCTIONALITY

printGrid :: [ConnectionGroup] -> [Word] -> IO ()
printGrid foundConnections availableWords = do
  let gridlineTuple = gridString foundConnections availableWords
  let connectionGridlines = fst gridlineTuple
  let wordGridlines = snd gridlineTuple
  putStrLn "\n"
  printConnectionGridlines connectionGridlines
  mapM_ putStrLn wordGridlines
  putStrLn "\n"

-- HELPER VARIABLES AND FUNCTIONS

backgroundColors :: [String]
backgroundColors = ["\ESC[43m", "\ESC[44m", "\ESC[102m", "\ESC[105m"]

printWithColor :: Gridline -> [Char] -> IO ()
printWithColor text colorANSI = do
  putStr colorANSI
  putStr text
  putStrLn "\ESC[0m"

printConnectionGridlines :: [Gridline] -> IO ()
printConnectionGridlines connectionGridlines = do
  mapM_ (\tuple -> printWithColor (fst tuple) (backgroundColors !! (snd tuple))) (zip connectionGridlines [0 ..])

gridString :: [ConnectionGroup] -> [Word] -> ([Gridline], [Gridline])
gridString foundConnections availableWords =
  (connections, wordsLeft)
  where
    connections = map show foundConnections
    wordsLeft = gridify availableWords

gridify :: [Word] -> [Gridline]
gridify [] = []
gridify words
  | length words >= 4 = [(words !! 0 ++ " | " ++ words !! 1 ++ " | " ++ words !! 2 ++ " | " ++ words !! 3)] ++ gridify (drop 4 words)
  | otherwise = []

module Haskellnections where

import Prelude hiding (Word)

type Word = [Char] 
type Definition = [Char]
type GroupingReason = [Char]
type Gridline = [Char]

data WordDefinition = WD Word Definition

data Connection = Connection Word Word Word Word

instance Eq Connection where
    (Connection a1 a2 a3 a4) == (Connection b1 b2 b3 b4) =
        equivalent [a1, a2, a3, a4] [b1, b2, b3, b4]
        where 
            equivalent [] [] = True
            equivalent l1@(h1:t1) l2 = h1 `elem` l2 && equivalent t1 (filter (/= h1) l2)

instance Show Connection where
    show (Connection w1 w2 w3 w4) = w1 ++ " | " ++ w2 ++ " | " ++ w3 ++ " | " ++ w4

data ConnectionGroup = ConnectionGroup Connection GroupingReason

instance Show ConnectionGroup where
    show (ConnectionGroup connection reason) = (show connection) ++ " - " ++ reason

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

backgroundColors :: [String]
backgroundColors = ["\ESC[43m", "\ESC[44m", "\ESC[102m", "\ESC[105m"]

printGridlineWithColor :: Gridline -> [Char] -> IO ()
printGridlineWithColor gridline colorANSI = do
    putStr colorANSI
    putStr gridline
    putStrLn "\ESC[0m"

printConnectionGridlines :: [Gridline] -> IO ()
printConnectionGridlines connectionGridlines = do
    mapM_ (\ tuple -> printGridlineWithColor (fst tuple) (backgroundColors !! (snd tuple))) (zip connectionGridlines [0..])

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


-- testing
c1 = Connection "Groovy" "Perl" "Bash" "Python"
c2 = Connection "Python" "Bash" "Perl" "Groovy"

remainingWords = ["BinaryTree", "LinkedList", "HashMap", "Stack", "Merge", "Quick", "Insertion", "Bubble", "OO", "Functional", "Imperative", "Declarative"]
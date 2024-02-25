module Haskellnections where

import Prelude hiding (Word)

type Word = [Char] 
type Definition = [Char]
type GroupingReason = [Char]

data WordDefinition = WD Word Definition

data Connection = Connection Word Word Word Word

instance Eq Connection where
    (Connection a1 a2 a3 a4) == (Connection b1 b2 b3 b4) =
        equivalent [a1, a2, a3, a4] [b1, b2, b3, b4]
        where 
            equivalent [] [] = True
            equivalent l1@(h1:t1) l2 = h1 `elem` l2 && equivalent t1 (filter (/= h1) l2)

instance Show Connection where
    show (Connection w1 w2 w3 w4) = w1 ++ " " ++ w2 ++ " " ++ w3 ++ " " ++ w4

data ConnectionGroup = ConnectionGroup Connection GroupingReason

instance Show ConnectionGroup where
    show (ConnectionGroup connection reason) = (show connection) ++ " - " ++ reason ++ "\n\n"

data WordGrid = WordGrid [Word] [ConnectionGroup]
    
-- testing
c1 = Connection "Groovy" "Perl" "Bash" "Python"
c2 = Connection "Python" "Bash" "Perl" "Groovy"

remainingWords = ["BinaryTree", "LinkedList", "HashMap", "Stack", "Merge", "Quick", "Insertion", "Bubble", "OO", "Functional", "Imperative", "Declarative"]


-- data Action = ConnnectionAttempt [Char] [Char] [Char] [Char]
--     deriving Show

-- data State = State InternalState [Action]

-- type InternalState = (WordGrid)

gridstring :: [ConnectionGroup] -> [Word] -> [Char]
gridstring foundConnections availableWords =
    foldl (\acc curr -> acc ++ curr) "" (connections ++ wordsLeft)
    where
        connections = map show foundConnections
        wordsLeft = gridify availableWords

gridify :: [Word] -> [[Char]]
gridify [] = []
gridify words 
    | length words >= 4 = [(words !! 0 ++ " " ++ words !! 1 ++ " " ++ words !! 2 ++ " " ++ words !! 3 ++ "\n")] ++ gridify (drop 4 words)
    | otherwise = []
    

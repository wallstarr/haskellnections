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
    show (Connection w1 w2 w3 w4) = w1 ++ " " ++ w2 ++ " " ++ w3 ++ " " ++ w4 ++ "\n"

data ConnectionGroup = ConnectionGroup Connection GroupingReason

instance Show ConnectionGroup where
    show (ConnectionGroup connection reason) = (show connection) ++ reason

data WordGrid = WordGrid [Word] [ConnectionGroup]
            
    
-- testing
c1 = Connection "Groovy" "Perl" "Bash" "Python"
c2 = Connection "Python" "Bash" "Perl" "Groovy"

remainingWords = ["BinaryTree", "LinkedList", "HashMap", "Stack", "Merge", "Quick", "Insertion", "Bubble", "OO", "Functional", "Imperative", "Declarative"]


-- data Action = ConnnectionAttempt [Char] [Char] [Char] [Char]
--     deriving Show

-- data State = State InternalState [Action]

-- type InternalState = (WordGrid)




    

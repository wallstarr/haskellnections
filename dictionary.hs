module Dictionary where
import qualified Data.Map.Strict as Map
import Prelude hiding (Word)
import Haskellnections

-- source: https://hackage.haskell.org/package/containers-0.4.2.1/docs/Data-Map.html#g:13
-- Define key-value pairs
definitions :: [(String, String)]
definitions =
    [ ("Python", "An interpreted, high-level programming language with dynamic typing, and support for object-oriented programming.")
    , ("Perl", "A versatile, interpreted language with support for multiple programming paradigms, used for scripting and text processing.")
    , ("Bash", "An interpreted command language used for shell scripting in Unix and Linux systems.")
    , ("Groovy", "A dynamic, Java-compatible scripting language with a more concise syntax.")
    , ("Binary Tree", "A hierarchical data structure where each node has at most two children.")
    , ("Linked List", "A linear data structure where each node contains a value and a reference to the next node.")
    , ("Hash Map", "A data structure that stores key-value pairs, providing efficient retrieval by using a hash function.")
    , ("Stack", "A linear data structure that follows the LIFO principle.")
    , ("Merge", "A divide and conquer sorting algorithm that recursively splits a list in half, sorts each half, and then merges the sorted halves back together.")
    , ("Quick", "A sorting algorithm that partitions an array around a pivot and recursively sorts the partitions.")
    , ("Insertion", "A sorting algorithm that builds a sorted array one element at a time.")
    , ("Bubble", "A sorting algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.")
    , ("OO", "A paradigm that uses objects and classes with features like inheritance and encapsulation to structure programs.")
    , ("Functional", "A paradigm that treats computation as the evaluation of mathematical functions, emphasizing immutability and avoiding state and mutable data")
    , ("Imperative", "A programming paradigm that uses statements to change a program's state, focusing on describing how a program operates.")
    , ("Declarative", "A paradigm where the code describes what to do, rather than how to do it, focusing on the logic of computation without explicit control flow.")
    ]

-- Insert key-value pairs into a Map<String, String>
insertPairs :: Map.Map String String -> [(String, String)] -> Map.Map String String
insertPairs m pairs = foldl (\acc (k,v) -> Map.insert k v acc) m pairs

-- Create an empty Map and insert key-value pairs
dictionary = insertPairs Map.empty definitions

define word = Map.lookup word dictionary

-- Print a Maybe String 
-- source: https://stackoverflow.com/questions/18864080/haskell-use-maybe-but-print-an-actual-number-rather-than-just
printMaybeString :: Maybe String -> IO()
printMaybeString maybeStr = 
    case maybeStr of 
        Just str -> putStrLn str
        Nothing -> putStrLn "Word not found"

-- all guess words are in remaining words.
isValidGuess :: [Word] -> [Word] -> Bool
isValidGuess [] _ = True
isValidGuess (h1:t1) remainingWords = h1 `elem` remainingWords && isValidGuess t1 (filter (\e -> e/=h1) remainingWords) 

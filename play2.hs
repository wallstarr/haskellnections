module PlayHaskellNections where

import Prelude hiding (Word)
import Haskellnections 
import WordGrids
import Dictionary

playConnections :: IO ()

playConnections = do
    putStrLn "Welcome to Haskellnections by Adrian, Dan, and Andrew! Made for CPSC312 2024W"
    putStrLn "How to Play"
    putStrLn "Find groups of 4 words that share something in common."
    putStrLn "Find all 4 groups before you run out of lives to secure the W!"
    putStrLn " "

    haskellNections (wordGrids !! 0) [] 4
    putStrLn "Thanks for Playing Bruh"
    
-- DO NOT RUN THIS WITHOUT PARAMETERS -- like this -- haskellNections (wordGrids !! 0) [] 4
haskellNections :: WordGrid -> [Connection] -> Integer -> IO ()

haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives = do
    putStrLn ("Lives Remaining: " ++ (show numLives))
    let connectionGroupsFound = filter (\ (ConnectionGroup connection _) -> connection `elem` connectionsFound) connectionGroups
    putStrLn "\n"
    putStrLn (gridstring connectionGroupsFound remainingWords)
    putStrLn "Enter 1 to guess a new connection"
    putStrLn "Enter 2 to define one of the words"
    option <- getLine
    if option == "1" then do 
        putStrLn "Guess a group of 4 words separated by a space (e.g. one two three four)"
        guessString <- getLine
        let guessWords = words guessString
        if (length guessWords == 4) then do 
          if (isValidGuess guessWords remainingWords) then do
            let newConnection = Connection (guessWords !! 0) (guessWords !! 1) (guessWords !! 2) (guessWords !! 3)
            let answers = (map (\ (ConnectionGroup connection _) -> connection) connectionGroups)
            if newConnection `elem` answers then do
              putStrLn "Connection Found!"
              let newConnectionsFound = newConnection:connectionsFound
              let newRemainingWords = filter (\a -> a `notElem` guessWords) remainingWords
              if (length newConnectionsFound == length connectionGroups) then do
                putStrLn "Congrats! You've found all the connections!"
              else do 
                haskellNections (WordGrid newRemainingWords connectionGroups) newConnectionsFound numLives
            else do 
              putStrLn "Unfortunately not one of the connections. Go again!"
              let newNumLives = numLives - 1
              if (newNumLives == 0) then do
                putStrLn "You're all out of lives. But you can't give up now..."
              else do 
                haskellNections (WordGrid remainingWords connectionGroups) connectionsFound (numLives-1)
          else do 
            putStrLn "Words are not in the grid. Try again!"
            haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives
        else do 
          putStrLn "Invalid input. Try again!"
          haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives 
    else if option == "2" then do 
       putStrLn "Enter the word you wish to define."
       word <- getLine  
       let definition = define word 
       printMaybeString definition
       haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives
    else do
        putStrLn "Please enter either 1 or 2."
        haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives 
    
   
    


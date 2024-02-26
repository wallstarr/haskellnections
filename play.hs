module PlayHaskellNections where

import Data.Time
import Dictionary
import Haskellnections
import System.IO.Unsafe
import WordGrids
import Prelude hiding (Word)

-- Entry point for the game, run this function to begin playing
play :: IO ()
play = do
  putStrLn "Welcome to Haskellnections by Adrian, Dan, and Andrew! Made for CPSC312 2024W"
  putStrLn "How to Play"
  putStrLn "Find groups of 4 words that share something in common."
  putStrLn "Find all 4 groups before you run out of lives to secure the W!"
  putStrLn " "

  dayOfMonth <- getCurrentDayOfMonth
  putStrLn "Today's Grid: \n"
  let wordGrid = wordGrids !! (dayOfMonth `mod` length wordGrids)

  haskellNections wordGrid [] 4
  putStrLn "Thanks for Playing Bruh"

-- Handles the game state, executed in a loop until either the user wins or lose
haskellNections :: WordGrid -> [Connection] -> Integer -> IO ()
haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives = do
  putStrLn ("Lives Remaining: " ++ (show numLives))
  let connectionGroupsFound = filter (\(ConnectionGroup connection _) -> connection `elem` connectionsFound) connectionGroups
  printGrid connectionGroupsFound remainingWords
  putStrLn "Enter 1 to guess a new connection"
  putStrLn "Enter 2 to define one of the words"
  option <- getLine
  if option == "1"
    then do
      putStrLn "Guess a group of 4 words separated by a space (e.g. one two three four)"
      guessString <- getLine
      let guessWords = words guessString
      if (length guessWords == 4)
        then do
          if (isValidGuess guessWords remainingWords)
            then do
              let newConnection = Connection (guessWords !! 0) (guessWords !! 1) (guessWords !! 2) (guessWords !! 3)
              let answers = (map (\(ConnectionGroup connection _) -> connection) connectionGroups)
              if newConnection `elem` answers
                then do
                  printWithColor "Connection Found!" "\ESC[32m"
                  let newConnectionsFound = newConnection : connectionsFound
                  let newRemainingWords = filter (\a -> not (a `caseInsensitiveElem` guessWords)) remainingWords
                  if (length newConnectionsFound == length connectionGroups)
                    then do
                      printWithColor "Congrats! You've found all the connections!" "\ESC[32m"
                      printGrid connectionGroups newRemainingWords
                    else do
                      haskellNections (WordGrid newRemainingWords connectionGroups) newConnectionsFound numLives
                else do
                  printWithColor "Unfortunately not one of the connections. Go again!" "\ESC[31m"
                  let newNumLives = numLives - 1
                  if (newNumLives == 0)
                    then do
                      printWithColor "You're all out of lives. But you can't give up now..." "\ESC[31m"
                    else do
                      haskellNections (WordGrid remainingWords connectionGroups) connectionsFound (numLives - 1)
            else do
              putStrLn "Not all words are not in the grid. Try again!"
              haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives
        else do
          putStrLn "Invalid input. Try again!"
          haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives
    else
      if option == "2"
        then do
          putStrLn "Enter the word you wish to define."
          word <- getLine
          let definition = define word
          printMaybeString definition
          haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives
        else do
          putStrLn "Please enter either 1 or 2."
          haskellNections (WordGrid remainingWords connectionGroups) connectionsFound numLives

-- Function to get the current day of the month, used to retrieve the appropriate word grid for today
-- Reference: https://wiki.haskell.org/Getting_the_current_date
getCurrentDayOfMonth :: IO Int
getCurrentDayOfMonth = do
  (_, _, day) <- getCurrentTime >>= return . toGregorian . utctDay
  return day
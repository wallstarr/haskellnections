-- import System.IO
-- -- source: https://www.educative.io/answers/how-to-read-from-a-file-in-haskell
-- getFileContents :: FilePath -> IO String
-- getFileContents fileName = do
--   fileHandle <- openFile fileName ReadMode
--   contents <- hGetContents fileHandle
--   --   putStrLn contents
--   --   hClose fileHandle
--   return contents
-- -- getWords = getFileContents "words.json"
-- getConnections :: IO String
-- getConnections = do
--   fileContents <- getFileContents "connections.json"
--   return fileContents
{-# LANGUAGE DeriveGeneric #-}

import Data.ByteString.Lazy qualified as B
import Data.Text
import GHC.Generics (Generic)

-- data Connection = Connection
--   { wordies :: [[Char]],
--     connections :: [[[Char]]]
--   }
--   deriving (Generic, Show)
-- data Person = Person
--   { name :: Text,
--     age :: Int
--   }
--   deriving (Generic, Show)

-- instance ToJSON Person where
--     -- No need to provide a toJSON implementation.

--     -- For efficiency, we write a simple toEncoding implementation, as
--     -- the default version uses toJSON.
--     toEncoding = genericToEncoding defaultOptions

-- instance FromJSON Person
--     -- No need to provide a parseJSON implementation.
-- -- encode (Connection {wordies = ["Joe"], connections = [["Python","Perl","Bash","Groovy"]]})

getJSON :: IO B.ByteString
getJSON = B.readFile "words.json"
module Dictionary where

import Data.Char
import Data.Map.Strict qualified as Map
import Haskellnections
import Prelude hiding (Word)

-- source: https://hackage.haskell.org/package/containers-0.4.2.1/docs/Data-Map.html#g:13
-- Definitions from ChatGPT - thank you very much!
definitions :: [(String, String)]
definitions =
  [ ("Python", "An interpreted, high-level programming language with dynamic typing, and support for object-oriented programming."),
    ("Perl", "A versatile, interpreted language with support for multiple programming paradigms, used for scripting and text processing."),
    ("Bash", "An interpreted command language used for shell scripting in Unix and Linux systems."),
    ("Groovy", "A dynamic, Java-compatible scripting language with a more concise syntax."),
    ("BinaryTree", "A hierarchical data structure where each node has at most two children."),
    ("LinkedList", "A linear data structure where each node contains a value and a reference to the next node."),
    ("HashMap", "A data structure that stores key-value pairs, providing efficient retrieval by using a hash function."),
    ("Stack", "A linear data structure that follows the LIFO principle."),
    ("Merge", "A divide and conquer sorting algorithm that recursively splits a list in half, sorts each half, and then merges the sorted halves back together."),
    ("Quick", "A sorting algorithm that partitions an array around a pivot and recursively sorts the partitions."),
    ("Insertion", "A sorting algorithm that builds a sorted array one element at a time."),
    ("Bubble", "A sorting algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order."),
    ("Object-Oriented", "A paradigm that uses objects and classes with features like inheritance and encapsulation to structure programs."),
    ("Functional", "A paradigm that treats computation as the evaluation of mathematical functions, emphasizing immutability and avoiding state and mutable data"),
    ("Imperative", "A programming paradigm that uses statements to change a program's state, focusing on describing how a program operates."),
    ("Declarative", "A paradigm where the code describes what to do, rather than how to do it, focusing on the logic of computation without explicit control flow."),
    ("SQL", "Structured Query Language, a domain-specific language used in programming and designed for managing data held in a relational database management system (RDBMS)."),
    ("Android", "A mobile operating system developed by Google, primarily designed for touchscreen mobile devices such as smartphones and tablets."),
    ("SSD", "Solid State Drive, a storage device that uses integrated circuit assemblies to store data persistently."),
    ("Motherboard", "The main printed circuit board in a computer, which contains the CPU, memory, connectors for peripherals, and other essential components."),
    ("HTTP", "Hypertext Transfer Protocol, an application protocol for distributed, collaborative, hypermedia information systems."),
    ("Windows", "A series of operating systems developed by Microsoft, known for its graphical user interface."),
    ("macOS", "The operating system developed by Apple Inc. for its Macintosh line of computers."),
    ("GPU", "Graphics Processing Unit, a specialized electronic circuit designed to rapidly manipulate and alter memory to accelerate the creation of images in a frame buffer."),
    ("Redis", "An open-source, in-memory data structure store used as a database, cache, and message broker."),
    ("TCP", "Transmission Control Protocol, one of the main protocols of the Internet protocol suite. It provides reliable, ordered, and error-checked delivery of bytes between applications running on hosts."),
    ("Linux", "A family of open-source Unix-like operating systems based on the Linux kernel."),
    ("SMTP", "Simple Mail Transfer Protocol, a communication protocol for electronic mail transmission."),
    ("CPU", "Central Processing Unit, the electronic circuitry within a computer that carries out the instructions of a computer program by performing basic arithmetic, logic, control, and input/output operations."),
    ("NoSQL", "A type of database that provides a mechanism for storage and retrieval of data that is modeled in means other than the tabular relations used in relational databases."),
    ("MongoDB", "A cross-platform document-oriented database program."),
    ("FTP", "File Transfer Protocol, a standard network protocol used to transfer computer files between a client and server on a computer network."),
    ("JavaScript", "A programming language that is commonly used to create interactive effects within web browsers."),
    ("Neural-Network", "A computer system modeled on the human brain's network of neurons and synapses, used to recognize patterns."),
    ("Waterfall", "A sequential (non-iterative) design process, often used in software development processes, in which progress is seen as flowing steadily downwards (like a waterfall) through several phases."),
    ("Encryption", "The process of encoding information in such a way that only authorized parties can access it."),
    ("Firewall", "A network security system that monitors and controls incoming and outgoing network traffic based on predetermined security rules."),
    ("CSS", "Cascading Style Sheets, a style sheet language used for describing the presentation of a document written in a markup language like HTML."),
    ("Malware", "Malicious software designed to disrupt, damage, or gain unauthorized access to a computer system."),
    ("Blockchain", "A decentralized, distributed ledger technology that records transactions across multiple computers in a way that is secure, transparent, and resistant to tampering."),
    ("Machine-Learning", "A field of artificial intelligence that uses statistical techniques to give computer systems the ability to 'learn' with data, without being explicitly programmed."),
    ("DevOps", "A set of practices that combines software development (Dev) and IT operations (Ops), aiming to shorten the systems development life cycle and provide continuous delivery with high software quality."),
    ("Deep-Learning", "A subset of machine learning that utilizes artificial neural networks with many layers (deep architectures) to model and understand complex data."),
    ("React", "A JavaScript library for building user interfaces, developed by Facebook."),
    ("HTML", "Hypertext Markup Language, the standard markup language for documents designed to be displayed in a web browser."),
    ("Scrum", "An agile framework for managing knowledge work, with an emphasis on software development, that promotes iterative and incremental delivery of products."),
    ("Natural-Language-Processing", "A field of artificial intelligence that focuses on the interaction between computers and humans using natural language. It enables computers to understand, interpret, and generate human language in a useful way.")
  ]

-- Insert key-value pairs into a Map<String, String>
-- source: https://www.tutorialspoint.com/haskell-program-to-convert-list-to-a-map
listToMap :: (Foldable t) => Map.Map [Char] a -> t ([Char], a) -> Map.Map [Char] a
listToMap m pairs = foldl (\acc (k, v) -> Map.insert (map toLower k) v acc) m pairs

-- Create an empty Map and insert key-value pairs
dictionary :: Map.Map [Char] String
dictionary = listToMap Map.empty definitions

define :: [Char] -> Maybe String
define word = Map.lookup (map toLower word) dictionary

-- Print a Maybe String
-- source: https://stackoverflow.com/questions/18864080/haskell-use-maybe-but-print-an-actual-number-rather-than-just
printMaybeString :: Maybe String -> IO ()
printMaybeString maybeStr =
  case maybeStr of
    Just str -> putStrLn str
    Nothing -> putStrLn "Word not found"

-- all guess words are in remaining words.
isValidGuess :: [Word] -> [Word] -> Bool
isValidGuess [] _ = True
isValidGuess (h1 : t1) remainingWords = h1 `caseInsensitiveElem` remainingWords && isValidGuess t1 (filter (\e -> e /= h1) remainingWords)

caseInsensitiveElem :: Word -> [String] -> Bool
caseInsensitiveElem word low = map toLower word `elem` map (map toLower) low
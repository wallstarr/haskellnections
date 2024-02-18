# play IO function

pulls random set of words from hard-coded collection 
(pull ALL definitions at start or only pull specific definitions when prompted? which one easier in Haskell)
pull correct groups 

calls func to initiate game




# initiate game function 
print list of words to IO (if possible do a 4x4 grid with some nice formatting)
print current groups 
print number of lives 
print time remaining (constantly being updated)

prompt user with:
  - (1) - Guess a group
  - (2) - Request a definition for a word 

if input is invalid (not 1 or 2 or exit):
  - input validation
if input is 1:
  - Call word guess function 
if input is 2:
  - Call request definition function

  
# request definition function
prompt user for word definition 

if word is not in current collection:
  - Input validation
if word is valid:
  - Print definition
  - # NOTE: Either retrieve from previously collected list of ALL word definitions from beginning or retrieve specific def from json file



# word guess function 
if input is invalid: 
  - Need input validation -- if input is invalid, tell user how to properly input/which word is misspelled
if input is correct:
  - print "Group discovered!"
  - eliminate the words from the collection and add words to new group + explanation of shared property
if input is incorrect: 
  - print "Incorrect group!"
  - If one away, print "One away!"
  - Decrement # of lives
  - if # of lives == 0:
    - call game over function 


# word dictionary
word dictionary: read from text file that has definitions for every word. 
If the user chooses the def
"api" -> should output
"a set of functions and procedures allowing the creation of applications that access the features or data of an operating system, application, or other service"



# TODO List:
ability to read from words.json given input 
abiilty to read from connections.json
format connections into 4x4 grid in console
input validation (depending on what is being asked for)
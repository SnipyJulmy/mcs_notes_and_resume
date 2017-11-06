module S06_Ex3 where

{-
Module     : S06_Ex3
Description : Series 06 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

import Data.Char

-- Tests import
import qualified Test.HUnit as T
import Text.Show.Functions -- to show <function>
import Text.Format

-- type declaration
type State = Int
type Code = String
type Transition = (State,Char -> Bool,State)
data StateMachine = StateMachine State [State] [Transition] deriving (Show)
data Token = Token StateMachine Code deriving (Show)

-- Tokens definition
t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16 :: Token
t1 = Token (StateMachine 0 [1] [(0,\c -> c == '{',1)]) "begin_block"
t2 = Token (StateMachine 0 [1] [(0,\c -> c == '}',1)]) "end_block"
t3 = Token (StateMachine 0 [1] [(0,\c -> c == '(',1)]) "begin_par"
t4 = Token (StateMachine 0 [1] [(0,\c -> c == ')',1)]) "end_par"
t5 = Token (StateMachine 0 [1] [(0,\c -> c == ';',1)]) "semicolon"
t6 = Token (StateMachine 0 [2] [
               (0,\c -> c == '=',1),
               (1,\c -> c == '=',2)])
     "op_eg"
t7 = Token  (StateMachine 0 [1] [(0,\c -> c == '=',1)]) "op_affect"
t8 = Token  (StateMachine 0 [1] [(0,\c -> c == '+',1)]) "op_add"
t9 = Token  (StateMachine 0 [1] [(0,\c -> c == '-',1)]) "op_minus"
t10 = Token (StateMachine 0 [1] [(0,\c -> c == '*',1)]) "op_mult"
t11 = Token (StateMachine 0 [1] [(0,\c -> c == '/',1)]) "op_div"
t12 = Token ( StateMachine 0 [3] [
     (0,\c -> c == 'i',1),
     (1,\c -> c == 'n',2),
     (2,\c -> c == 't',3)])
      "type_int"
t13 = Token ( StateMachine 0 [2] [
     (0,\c -> c == 'i',1),
     (1,\c -> c == 'f',2)])
      "cond"
t14 = Token ( StateMachine 0 [5] [
     (0,\c -> c == 'w',1),
     (1,\c -> c == 'h',2),
     (2,\c -> c == 'i',3),
     (3,\c -> c == 'l',4),
     (4,\c -> c == 'e',5)])
      "loop"
t15 = Token ( StateMachine 0 [1] [
                (0,isDigit,1),
                (1,isDigit,1)])
      "value_int"
t16 = Token ( StateMachine 0 [1] [
                (0,\c -> isIdentHead c, 1),
                (1,\c -> isIdentBody c,1)])
              "ident" where
  isIdentHead c = (elem c az) || (elem c (map toUpper az)) || c == '_'
  isIdentBody c = isIdentHead c || (isDigit c)
  az = "abcdefghijklmnopqrstuvwxyz"
tokens = [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16]

-- Ex3.2
recognizedFromState :: String -> Token -> (Code,String,String)
recognizedFromState str tk = recognizedFromState' 0 str "" tk

recognizedFromState' :: State -> String -> String -> Token -> (Code,String,String)
recognizedFromState' _ [] acc (Token _ code) = (code,acc,"")
recognizedFromState' crtState crtString@(c:cs) acc tk@(Token stateMachine@(StateMachine _ _ transitions) code)
  | ns == -1 = if isFinalState crtState stateMachine
    then (code,acc,crtString)
    else ("","",crtString)
  | otherwise = recognizedFromState' ns cs (acc ++ [c]) tk where
      ns = nextState crtState c stateMachine

-- Ex3.3
getNextRecognizedToken :: String -> [Token] -> (Code,String,String)
getNextRecognizedToken text [] = ("","",text)
getNextRecognizedToken text tokens = inner text tokens ("","",text) where
  inner :: String -> [Token] -> (Code,String,String) -> (Code,String,String)
  inner _ [] acc = acc
  inner text (tk:tks) acc@(_,crtRecognizedString,_) = case (recognizedFromState text tk) of
    n@(_, txt, _) ->
      if (length txt) > (length crtRecognizedString)
      then inner text tks n
      else inner text tks acc

lexAnalyse :: String -> [Token] -> [Code]
lexAnalyse str tokens = inner (trim str) [] where
  inner :: String -> [Code] -> [Code]
  inner "" acc = acc
  inner crtStr acc = case (getNextRecognizedToken crtStr tokens) of
    (_,"",_) -> acc
    (code,_,rest) -> inner (trim rest) (acc ++ [code])

-- remove the first spaces of a String
trim :: String -> String
trim "" = ""
trim str@(c:cs)
  | isSpace c = trim cs
  | otherwise = str

isFinalState :: Int -> StateMachine -> Bool
isFinalState crtState (StateMachine _ finalStates _) = elem crtState finalStates

nextState :: State -> Char -> StateMachine -> State
nextState crtState c (StateMachine _ _ transitions) = applyTransitions transitions where
  applyTransitions :: [Transition] -> State
  applyTransitions [] = -1
  applyTransitions ((start,predicat,end):xs)
    | start == crtState && predicat c = end
    | otherwise = applyTransitions  xs

-- Test utils

assertLexAnalyse :: String -> [Code] -> T.Assertion
assertLexAnalyse str code = T.assertEqual
  (format "lexAnalyse {str} == {code}")
  (lexAnalyse str tokens)
  (code)

-- Test

test_lexAnalyse = T.TestCase (do
                                 assertLexAnalyse "int a;" ["type_int", "ident", "semicolon"]
                                 assertLexAnalyse "int b;" ["type_int", "ident", "semicolon"]
                                 assertLexAnalyse "intxy = 2;" ["ident","op_affect","value_int","semicolon"]
                                 assertLexAnalyse "toto=3;" ["ident","op_affect","value_int","semicolon"]
                             )

tests = T.TestList [ T.TestLabel "test lexAnalyse" test_lexAnalyse]

main = do T.runTestTT tests

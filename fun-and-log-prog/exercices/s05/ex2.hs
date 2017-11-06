{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module S04_Ex2 where


{-
Module     : S04_Ex2
Description : Series 04 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(a04_Ex1t)unifr.ch
-}

import Data.Char

-- Tests import
import qualified Test.HUnit as T
import Text.Show.Functions
import Text.Format

-- type definition
type State = Int
type Transition = (State,Char -> Bool,State)
type StateMachine = (State,[State],[Transition])
type Code = String
type Token = (StateMachine,Code)

-- Tokens definition
t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16 :: Token
t1 = ((0,[1],[(0,\c -> c == '{',1)]),"begin_block")
t2 = ((0,[1],[(0,\c -> c == '}',1)]),"end_block")
t3 = ((0,[1],[(0,\c -> c == '(',1)]),"begin_par")
t4 = ((0,[1],[(0,\c -> c == ')',1)]),"end_par")
t5 = ((0,[1],[(0,\c -> c == ';',1)]),"semicolon")
t6 = (
  (
    0,
    [2],
    [
      (0,\c -> c == '=',1),
      (1,\c -> c == '=',2)
    ]),
  "op_eg")
t7 = ((0,[1],[(0,\c -> c == '=',1)]),"op_affect")
t8 = ((0,[1],[(0,\c -> c == '+',1)]),"op_add")
t9 = ((0,[1],[(0,\c -> c == '-',1)]),"op_minus")
t10 = ((0,[1],[(0,\c -> c == '*',1)]),"op_mult")
t11 = ((0,[1],[(0,\c -> c == '/',1)]),"op_div")
t12 = (
  (0,
   [3],
   [
     (0,\c -> c == 'i',1),
     (1,\c -> c == 'n',2),
     (2,\c -> c == 't',3)
   ]),
    "type_int")
t13 = (
  (0,
   [2],
   [
     (0,\c -> c == 'i',1),
     (1,\c -> c == 'f',2)
   ]),
    "cond")
t14 = (
  (0,
   [5],
   [
     (0,\c -> c == 'w',1),
     (1,\c -> c == 'h',2),
     (2,\c -> c == 'i',3),
     (3,\c -> c == 'l',4),
     (4,\c -> c == 'e',5)
   ]),
  "loop")
t15 = (
  (0,
   [0],
   [
     (0,isDigit,0)
   ]
  ),"value_int")
t16 = (
  (0,
   [1],
   [
     (0,\c -> isIdentHead c, 1),
     (1,\c -> isIdentBody c,1)
   ]),
    "ident") where
  isIdentHead c = (elem c az) || (elem c (map toUpper az)) || c == '_'
  isIdentBody c = isIdentHead c || (isDigit c)
  az = "abcdefghijklmnopqrstuvwxyz"
tokens = [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16]

-- Utility function

getToken :: String -> [Token] -> Code
getToken str [] = error ("no recognize token : " ++ str)
getToken str ((automata,code):tks) = if isToken str automata
  then code
  else getToken str tks

isToken :: String -> StateMachine -> Bool
isToken str automata@(initState,_,_) = reconizedFromState initState str automata

reconizedFromState :: State -> String -> StateMachine -> Bool
reconizedFromState crtState "" automata = isFinalState crtState automata
reconizedFromState crtState (c:str) automata = if nextState' == -1
  then False
  else reconizedFromState nextState' str automata where
  nextState' = nextState crtState c automata

isFinalState :: Int -> StateMachine -> Bool
isFinalState crtState (_,finalStates,_) = elem crtState finalStates

nextState :: State -> Char -> StateMachine -> State
nextState crtState c (_,_,transitions) = applyTransitions transitions where
  applyTransitions :: [Transition] -> State
  applyTransitions [] = -1
  applyTransitions ((start,predicat,end):xs)
    | start == crtState && predicat c = end
    | otherwise = applyTransitions  xs

lexAnalyse :: String -> [Code]
lexAnalyse str = inner (words str) where
  inner :: [String] -> [Code]
  inner [] = []
  inner (str:strs) = (getToken str tokens) : inner strs

-- Tests utils

code :: Token -> Code
code (_,c) = c

assertGetToken :: String -> Token -> Bool -> T.Assertion
assertGetToken str tk isAccepted = T.assertEqual
  (format "{str} correspond to token {tk}")
  ((getToken str tokens) == (code tk))
  isAccepted

assertLexAnalyse :: String -> [Code] -> T.Assertion
assertLexAnalyse str codes = T.assertEqual
  (format "ad")
  (lexAnalyse str)
  codes

-- Tests

test1 :: T.Test
test1 = T.TestCase (do assertGetToken "{" t1 True
                       assertGetToken "}" t2 True
                       assertGetToken "(" t3 True
                       assertGetToken "(" t4 False
                       assertGetToken ")" t4 True
                       assertGetToken ";" t5 True
                       assertGetToken "==" t6 True
                       assertGetToken "=" t7 True
                       assertGetToken "+" t8 True
                       assertGetToken "-" t9 True
                       assertGetToken "*" t10 True
                       assertGetToken "/" t11 True
                       assertGetToken "int" t12 True
                       assertGetToken "if" t13 True
                       assertGetToken "while" t14 True
                       assertGetToken "9921" t15 True
                       assertGetToken "9921" t16 False
                       assertGetToken "toto" t16 True)

test2 = T.TestCase (do assertLexAnalyse "int a ;" [code t12, code t16, code t5]
                       assertLexAnalyse "int b ;" [code t12, code t16, code t5])

tests = T.TestList [
  T.TestLabel "testGetToken" test1,
  T.TestLabel "testLexAnalyse" test2
  ]

main = do T.runTestTT tests

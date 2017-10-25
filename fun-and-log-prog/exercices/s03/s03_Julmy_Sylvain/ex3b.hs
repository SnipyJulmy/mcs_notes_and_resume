module EX03B where

{-
Module : EX03B
Description : Series 03 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

import qualified Test.HUnit as T
import Text.Format

-- Ex3.b
type State = Int
type Transition = (State,Char,State)
type Automata = (State,[State],[Transition])


isToken :: String -> Automata -> Bool
isToken str automata@(initState,_,_) = reconizedFromState initState str automata

reconizedFromState :: State -> String -> Automata -> Bool
reconizedFromState crtState "" automata = isFinalState crtState automata
reconizedFromState crtState (c:str) automata = if nextState' == -1
  then False
  else reconizedFromState nextState' str automata where
  nextState' = nextState crtState c automata

isFinalState :: Int -> Automata -> Bool
isFinalState crtState (_,finalStates,_) = elem crtState finalStates

nextState :: State -> Char -> Automata -> State
nextState crtState c (_,_,transitions) = applyTransitions transitions where
  applyTransitions :: [Transition] -> State
  applyTransitions [] = -1
  applyTransitions ((start,char,end):xs)
    | start == crtState && char == c = end
    | otherwise = applyTransitions  xs

-- Tests
-- use T.runTestTT tests in ghci after loading this file to it

myAutomata :: Automata
myAutomata = (0,[4],[(0,'a',1), (1,'b',2),(1,'a',3), (2,'a',4),(2,'b',2), (3,'b',4), (4,'a',1)])

testStrFormat :: State -> Char -> State -> String
testStrFormat startState symbol endState = "() + '' = ()"

nextStateAssert startState symbol endState = T.assertEqual
  (format "({}) + '{}' = ({})" [show startState,show symbol, show endState])
  (nextState startState symbol myAutomata)
  endState

reconizedFromStateAssert startState str isAccepted = T.assertEqual
  (format "() + \"{}\" => {}" [show startState,show str, show isAccepted])
  (reconizedFromState startState str myAutomata)
  isAccepted

isTokenAssert str isAccepted = T.assertEqual
  (format "{} is a token : {}" [show str, show isAccepted])
  (isToken str myAutomata)
  isAccepted

t1 = T.TestCase (do nextStateAssert 0 'a' 1
                    nextStateAssert 1 'a' 3
                    nextStateAssert 1 'b' 2
                    nextStateAssert 2 'b' 2
                    nextStateAssert 2 'a' 4
                    nextStateAssert 3 'b' 4
                    nextStateAssert 4 'a' 1)

t2 = T.TestCase (do reconizedFromStateAssert 2 "bba" True
                    reconizedFromStateAssert 1 "aba" False
                    reconizedFromStateAssert 2 "aaba" True
                    reconizedFromStateAssert 3 "b" True
                    reconizedFromStateAssert 3 "baabaab" True
                    reconizedFromStateAssert 4 "" True
                    reconizedFromStateAssert 4 "aba" True
                    reconizedFromStateAssert 4 "abbbbbbbbbbbba" True
                    reconizedFromStateAssert 4 "abbbbbbbbbbbbbbbbbbba" True
                    reconizedFromStateAssert 1 "ab" True
                    reconizedFromStateAssert 1 "bbbbbbbb" False
                    reconizedFromStateAssert 2 "bbbbbbbb" False
                    reconizedFromStateAssert 3 "bbbbbbbb" False
                    reconizedFromStateAssert 4 "bbbbbbbb" False
                    reconizedFromStateAssert 2 "bbbbbbbb" False
                    reconizedFromStateAssert 3 "aaa" False
                    reconizedFromStateAssert 4 "a" False)

t3 = T.TestCase (do T.assertEqual "4 is a final state" (isFinalState 4 myAutomata) True
                    T.assertEqual "3 is not final state" (isFinalState 3 myAutomata) False
                    T.assertEqual "2 is not final state" (isFinalState 2 myAutomata) False)

t4 = T.TestCase (do isTokenAssert "aababba" True
                    isTokenAssert "aababbbbbbbbba" True
                    isTokenAssert "aab" True
                    isTokenAssert "b" False
                    isTokenAssert "bb" False
                    isTokenAssert "bbb" False
                    isTokenAssert "aabaabaabaab" True
                    isTokenAssert "" False
                    isTokenAssert "a" False
                    isTokenAssert "ab" False)

tests = T.TestList [T.TestLabel "test nextState" t1,
                    T.TestLabel "test reconizedFromState" t2,
                    T.TestLabel "test isFinalState" t3,
                    T.TestLabel "test isToken" t4]

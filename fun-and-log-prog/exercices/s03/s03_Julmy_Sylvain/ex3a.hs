module EX03A where

{-
Module : EX03A
Description : Series 03 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

import qualified Test.HUnit as T
import Text.Format

isFinalState :: Int -> Bool
isFinalState n
  | n == 4 = True
  | otherwise = False

firstState :: Int
firstState = 0

transition :: Int -> Char -> Int
transition 0 'a' = 1
transition 1 'a' = 3
transition 1 'b' = 2
transition 2 'a' = 4
transition 2 'b' = 2
transition 3 'b' = 4
transition 4 'a' = 1
transition _ _ = -1


isToken :: String -> Bool
isToken str = reconizedFromState firstState str

{- Or by hand...
isToken "" = False
isToken str = iter firstState str where
  iter crtState [] = isFinalState crtState
  iter crtState (c:str) = if newState == -1
    then False
    else iter newState str where
    newState = transition crtState c
-}

reconizedFromState :: Int -> String -> Bool
reconizedFromState (-1) _ = False
reconizedFromState crtState "" = isFinalState crtState
reconizedFromState crtState (c:str) = reconizedFromState (transition crtState c) str

-- Tests

-- utility function
testStrFormat :: Int -> Char -> Int -> String
testStrFormat startState symbol endState = "() + '' = ()"

reconizedFromStateAssert startState str isAccepted = T.assertEqual
  (format "() + \"{}\" => {}" [show startState,show str, show isAccepted])
  (reconizedFromState startState str)
  isAccepted

isTokenAssert str isAccepted = T.assertEqual
  (format "{} is a token : {}" [show str, show isAccepted])
  (isToken str)
  isAccepted

t1 = T.TestCase (do reconizedFromStateAssert 2 "bba" True
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

t2 = T.TestCase (do T.assertEqual "4 is a final state" (isFinalState 4 ) True
                    T.assertEqual "3 is not final state" (isFinalState 3 ) False
                    T.assertEqual "2 is not final state" (isFinalState 2 ) False)

t3 = T.TestCase (do isTokenAssert "aababba" True
                    isTokenAssert "aababbbbbbbbba" True
                    isTokenAssert "aab" True
                    isTokenAssert "b" False
                    isTokenAssert "bb" False
                    isTokenAssert "bbb" False
                    isTokenAssert "aabaabaabaab" True
                    isTokenAssert "" False
                    isTokenAssert "a" False
                    isTokenAssert "ab" False)

tests = T.TestList [T.TestLabel "test reconizedFromState" t1,
                    T.TestLabel "test isFinalState" t2,
                    T.TestLabel "test isToken" t3]

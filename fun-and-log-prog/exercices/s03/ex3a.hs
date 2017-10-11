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


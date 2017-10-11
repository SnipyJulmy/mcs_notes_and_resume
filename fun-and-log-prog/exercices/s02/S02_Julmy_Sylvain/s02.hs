module S02 where

import Data.Char
import Test.QuickCheck

{-
Module : S02
Description : Series 02 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

-- Ex1.a
-- f1 l : return the first 3 element of the list l, return the entire list if (length l < 3)
f1 :: [a] -> [a]
f1 [] = []
f1 [a] = [a]
f1 [a,b] = [a,b]
f1 [a,b,c] = [a,b,c]
f1 (a:b:c:xs) = [a,b,c]

f1' :: [a] -> [a]
f1' xs = inner xs 3 where
  inner [] n = []
  inner _ 0 = []
  inner (x:xs) n = x : inner xs (n-1)

-- Ex1.b
-- fibonacci n : return the n-th number of fibonacci
fib :: Int -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

-- using memoization, which is obviusly much more quicker
memfib :: Int -> Integer
memfib = (map fib' [0..] !!) where
  fib' 0 = 0
  fib' 1 = 1
  fib' n = memfib (n-1) + memfib (n-2)

-- Ex2
-- last' l : return the last element of the list l
-- PRE : (null l) == false
last' :: [a] -> a
last' (x:[]) = x
last' (x:xs) = last' xs

-- Ex2.b
-- delete' e l : return l without the first occurence of e
delete',delete'' :: Eq a => a -> [a] -> [a]
delete' _ [] = []
delete' (e) (x:xs) = if e == x then xs else x:(delete' e xs)
  
-- using guards
delete'' e l
  | l == [] = []
  | e == (head l) = tail l
  | otherwise = (head l) : (delete'' e (tail l))

-- Ex2.c
-- maximum' l : return the greatest element of l
-- PRE : (null l) == false
maximum' :: Ord a => [a] -> a
maximum' (x:xs) = max x xs where
  max acc [] = acc
  max acc (x:xs) = max (if x > acc then x else acc) xs

-- Ex2.d
-- scalarProduct x y : return the scalar product of x and y
scalarProduct :: Num a => [a] -> [a] -> [a]
scalarProduct [] _ = []
scalarProduct _ [] = []
scalarProduct (x:xs) (y:ys) = (x * y) : scalarProduct xs ys

-- Ex3.a
-- length' l : return the length of the list l
length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + (length' xs)

-- Ex3.b
-- deleteAll' e l : return the list l without all the occurence of e
deleteAll' :: Eq a => a -> [a] -> [a]
deleteAll' _ [] = []
deleteAll' e (x:xs)
  | e == x = deleteAll' e xs
  | otherwise = x : (deleteAll' e xs)

-- Ex3.c
-- toUpperString ch : return the String (or list of char) ch in uppercase
toUpperString :: [Char] -> [Char]
toUpperString [] = []
toUpperString (x:xs) = (toUpper x):(toUpperString xs)

-- Ex4.a
-- countVowel ch : return the number of vowel present in ch
countVowel :: [Char] -> Int
countVowel [] = 0
countVowel (x:xs)
  | elem x vowel = 1 + countVowel xs
  | otherwise = countVowel xs
  where
    vowel = "aeiouy"

-- Ex4.b
-- analyseString lch : return the number of char in each string of the list lch
analyseString :: [[Char]] -> [([Char],Int)]
analyseString [] = []
analyseString (x:xs) = (x,length' x) : analyseString xs

-- Ex4.c
-- analyseString2 lch : return the number of char and the number of vowel in each string of the list lch
analyseString2 :: [[Char]] -> [([Char],Int,Int)]
analyseString2 [] = []
analyseString2 (x:xs) = (x,length' x, countVowel x) : analyseString2 xs


{-
   Test, checking some property of the
   developed function...
-}

-- f1
prop_f1 x = (f1 x) == (take 3 x)
prop_f1' x = (f1' x) == (take 3 x)

-- fib is not really testable...

-- last'
prop_last' xs = (last' xs) == (last xs)

-- delete'
-- at least if we haven't the same error it is a good try
prop_delete' e l = (delete' e l) == (delete'' e l)

-- maximum'
prop_maximum' l = (maximum' l) == (maximum l)

-- scalarProduct
prop_scalarProduct :: [Int] -> [Int] -> Bool
prop_scalarProduct xs ys = (map (\(x,y) -> x * y) (zip xs ys)) == scalarProduct xs ys

-- length'
prop_length' :: [a] -> Bool
prop_length' xs = (length' xs) == (length xs)

-- deleteAll'
prop_deleteAll' :: Eq a => a -> [a] -> Bool
prop_deleteAll' e l = (deleteAll' e l) == (filter (\x -> x /= e) l)

-- toUpperString
prop_toUpperString :: [Char] -> Bool
prop_toUpperString xs = (toUpperString xs) == (map toUpper xs)

-- countVowel , analyseString  and analyseString2 aren't really verifiable by property...

-- utils

nonEmptyString :: Gen String
nonEmptyString = listOf1 arbitrary

main = do
  quickCheck (prop_f1 :: [Int] -> Bool)
  quickCheck (prop_f1' :: [Int] -> Bool)
  quickCheck $ forAll nonEmptyString $ (prop_last' :: String -> Bool)
  quickCheck (prop_delete' :: Int -> [Int] -> Bool)
  quickCheck prop_scalarProduct
  quickCheck (prop_length' :: [Int] -> Bool)
  quickCheck (prop_deleteAll' :: Int -> [Int] -> Bool)
  quickCheck prop_toUpperString

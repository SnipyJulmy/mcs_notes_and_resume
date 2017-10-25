module S03 where

{-# LANGUAGE FlexibleInstances #-}

{-
Module : S04
Description : Series 04 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

-- import for the tests
import Test.QuickCheck
import Data.List
import qualified Data.Set as S
import Text.Show.Functions

-- Ex1

insert' :: Ord a => a -> [a] -> [a]
insert' elt [] = [elt]
insert' elt (x:xs)
  | elt <= x = (elt:x:xs)
  | otherwise = x : (insert' elt xs)

insertionSort :: Ord a => [a] -> [a]
insertionSort [] = []
insertionSort (x:xs) = insert' x (insertionSort xs)

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' predicat (x:xs)
  | predicat x = x : (takeWhile' predicat xs)
  | otherwise = []

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)

intersect',intersect'',intersect''2,intersect''' :: Eq a => [a] -> [a] -> [a]
intersect' _ [] = []
intersect' [] _ = []
intersect' (x:xs) ys
  | elem x ys = x : intersect' xs ys
  | otherwise = intersect' xs ys

intersect'' xs ys = inner elem xs ys where
  inner :: (a -> [a] -> Bool) -> [a] -> [a] -> [a]
  inner _ _ [] = []
  inner _ [] _ = []
  inner f (x:xs) ys = if (f x ys)
    then x : (inner f xs ys)
    else (inner f xs ys)

intersect''2 xs ys = filter (\x -> elem x ys) xs

intersect''' xs ys = [x | x <- xs, y <- ys, x == y]

divisorList,divisorList',divisorList''  :: Int -> [intero generate tInt]

divisorList v
  | v < 1 = []
  | otherwise = inner 1 where
      inner :: Int -> [Int]
      inner n
        | n == v = []
        | otherwise = if v `rem` n == 0
          then n : (inner (n+1))
          else inner (n+1)

divisorList' v
  | v < 1 = []
  | otherwise = filter (\x -> v `rem` x == 0) [1..(v-1)]

divisorList'' v
  | v < 1 = []
  | otherwise = inner v where
      inner :: Int -> [Int]
      inner v = [ n | n <- [1..(v-1)], v `mod` n == 0]

perfectNumber :: Int -> Bool
perfectNumber n = sum (divisorList n) == n

perfectNumbers :: Int -> [Int]
perfectNumbers n = take n perfectNumbersList where
  perfectNumbersList = filter perfectNumber [1..]

-- Ex2

type Polynom = [(Double,Int)]

-- PRE : polynom is not empty
calculatePolynomial,calculatePolynomial',calculatePolynomial''  :: Polynom -> Double -> Double

calculatePolynomial ((c,d):[]) x = computeCD c d x
calculatePolynomial ((c,d):cds) x = (computeCD c d x) + calculatePolynomial cds x

computeCD :: Double -> Int -> Double -> Double
computeCD c d x = c * (x ^ d)

calculatePolynomial' poly x = sum (map (\(c,d) -> c * (x ^ d) ) poly)

calculatePolynomial'' poly x = sum [v | (c,d) <- poly, let v = c * (x ^ d)]

-- Function Properties

prop_insert :: Ord a => a -> [a] -> Bool
prop_insert elt list = (insert' elt list) == (insert elt list)

prop_insertionSort :: Ord a => [a] -> Bool
prop_insertionSort xs = (insertionSort xs) == (sort xs)

prop_takeWhile :: (a -> Bool) -> [a] -> Bool
prop_takeWhile pred xs = True

prop_zipWith :: Eq c => (a -> b -> c) -> [a] -> [b] -> Bool
prop_zipWith f xs ys = (zipWith' f xs ys) == (zipWith f xs ys)

prop_intersect :: (Eq a, Ord a) => [a] -> [a] -> Bool
prop_intersect xs ys = (S.fromList (intersect' xs ys)) == (S.fromList (intersect xs ys))

prop_divisorList :: Int -> Bool
prop_divisorList n = foldl (\acc -> \x -> acc && (n `rem` x == 0)) True (divisorList n)

--Launch the test with the main function

main = do
  quickCheck (prop_insert :: Int -> [Int] -> Bool)
  quickCheck (prop_insertionSort :: [Int] -> Bool)
  quickCheck (prop_takeWhile :: (Int -> Bool) -> [Int] -> Bool)
  quickCheck (prop_zipWith :: (Int -> Int -> Int) -> [Int] -> [Int] -> Bool)
  quickCheck (prop_intersect :: [Int] -> [Int] -> Bool)
  quickCheck (prop_divisorList)

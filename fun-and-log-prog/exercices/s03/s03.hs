module S03 where

{-
Module : S03
Description : Series 03 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

import Data.Char

-- Import for the test
import Test.QuickCheck
import Control.Monad
import qualified Data.List as L
import qualified Data.Set as S

-- Ex1.a
flatten :: [[a]] -> [a]
flatten [] = []
flatten (x:xs) = x ++ (flatten xs)

-- Ex1.b
partitions :: [a] -> [[a]]
partitions [] = [[]]
partitions (x:xs) = [x:parts | parts <- partitions xs] ++ -- first case, x belongs to the set
                    [parts | parts <- partitions xs]      -- second case, x does not belongs to the set

-- Ex1.c
permutations :: Eq a => [a] -> [[a]]
permutations [] = [[]]
permutations xs = [x:ys | x <- xs, ys <- permutations (delete' x xs)] where
  delete' :: Eq a => a -> [a] -> [a]
  delete' _ [] = []
  delete' (e) (x:xs) = if e == x then xs else x:(delete' e xs)


-- Ex2.a
-- why using a comprehension ?
length' :: [a] -> Int
length' l = sum [1 | _ <- l]

-- Ex2.b
deleteAll' :: Eq a => a -> [a] -> [a]
deleteAll' e l = [x | x <- l, x /= e]

-- Ex2.c
toUpperString :: String -> String
toUpperString s = [toUpper c | c <- s]

-- Tests

-- toUpperString
prop_toUpperString :: [Char] -> Bool
prop_toUpperString xs = (toUpperString xs) == (map toUpper xs)

-- flatten
prop_flatten :: Eq a => [[a]] -> Bool
prop_flatten xss = (flatten xss) == (join xss)

-- permutations
prop_permutations :: (Eq a, Ord a) => [[a]] -> Bool
prop_permutations xss = (S.fromList (permutations xss)) == (S.fromList (L.permutations xss))

-- length
prop_length :: [a] -> Bool
prop_length xs = (length' xs) == (length xs)

-- deleteAll
prop_deleteAll' :: Eq a => a -> [a] -> Bool
prop_deleteAll' e l = (deleteAll' e l) == (filter (\x -> x /= e) l)

-- Running the tests with the main programm
main = do
  quickCheck prop_toUpperString
  quickCheck (prop_flatten :: [[Int]] -> Bool)
  quickCheck (prop_permutations :: [[Int]] -> Bool)
  quickCheck (prop_length :: [Int] -> Bool)
  quickCheck (prop_deleteAll' :: Int -> [Int] -> Bool)

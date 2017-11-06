module S06_Ex1 where

{-
Module     : S06_Ex1
Description : Series 06 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

-- imports for tests
import Test.QuickCheck
import Control.Monad
import qualified Data.List as L
import qualified Data.Set as S

-- Ex1.a
product' :: Num a => [a] -> a
product' [] = 1
product' (x:xs) = foldr (*) x xs

-- Ex1.b
flatten' :: [[a]] -> [a]
flatten' [] = []
flatten' xss = foldr (++) [] xss

-- Ex1.c
deleteAll :: Eq a => a -> [a] -> [a]
deleteAll elt xs = foldr (\v -> \acc -> if v == elt then acc else v:acc) [] xs

-- Ex1.d
allDifferent,allDifferent',allDifferent'',allDifferent''' :: Eq a => [a] -> Bool

allDifferent [] = True
allDifferent (x:xs) = if elem x xs then False else allDifferent xs

allDifferent' [] = True
allDifferent' (x:xs) = inner [x] xs where
  inner :: Eq a => [a] -> [a] -> Bool
  inner _ [] = True
  inner presentValues (x:xs)
    | elem x presentValues = False
    | otherwise = inner (x:presentValues) xs


allDifferent'' xs = inner xs (\x -> x) where
  inner :: Eq a => [a] -> (Bool -> Bool) -> Bool
  inner [] cont = cont True
  inner (x:xs) cont = inner xs (\n -> cont(n && (not (elem x xs))))

allDifferent''' xs = fst (foldr (
                             \v ->
                               \(b,ys) -> if b
                               then if elem v ys
                                 then (False,[])
                                 else (True,v:ys)
                               else (False,[])
                             )(True,[]) xs)

---------------
---- Tests ----
---------------

-- Function properties

prop_product :: (Num a, Eq a) => [a] -> Bool
prop_product xs = (product' xs) == (product xs)

prop_flatten :: Eq a => [[a]] -> Bool
prop_flatten xss = (flatten' xss) == (join xss)

prop_deleteAll :: Eq a => a -> [a] -> Bool
prop_deleteAll n xs = (deleteAll n xs) == (filter (\x -> x /= n) xs)

prop_allDifferent :: Eq a => [a] -> Bool
prop_allDifferent xs = do
  let referenceValue = (L.nub xs) == xs
  referenceValue == (allDifferent xs)
    && referenceValue == (allDifferent' xs)
    && referenceValue == (allDifferent'' xs)
    && referenceValue == (allDifferent''' xs)

-- run the tests using main
main = do
  quickCheck (prop_product :: [Int] -> Bool)
  quickCheck (prop_flatten :: [[Int]] -> Bool)
  quickCheck (prop_flatten :: [[Char]] -> Bool)
  quickCheck (prop_flatten :: [[String]] -> Bool)
  quickCheck (prop_deleteAll :: Int -> [Int] -> Bool)
  quickCheck (prop_deleteAll :: Char -> [Char] -> Bool)
  quickCheck (prop_deleteAll :: String -> [String] -> Bool)
  quickCheck (prop_allDifferent :: [Int] -> Bool)
  quickCheck (prop_allDifferent :: [Char] -> Bool)
  quickCheck (prop_allDifferent :: [String] -> Bool)

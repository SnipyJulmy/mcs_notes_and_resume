module S04_Ex1 where

{-
Module     : S04_Ex1
Description : Series 04 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

-- imports for tests
import Test.QuickCheck
import Control.Monad
import qualified Data.List as L
import qualified Data.Set as S

-- Ex1.a
fibonacci,fibonacci'  :: Int -> Int
fibonacci n = inner n 0 1 where
  inner :: Int -> Int -> Int -> Int
  inner 0 acc1 _ = acc1
  inner n acc1 acc2 = inner (n-1) acc2 $! (acc1 + acc2)

fibonacci' 0 = 0
fibonacci' n = inner n (\x -> x) where
  inner :: Int -> (Int -> Int) -> Int
  inner 0 cont = cont 0
  inner 1 cont = cont 1
  inner n cont = inner (n-1) (\x -> inner (n-2) (\y -> cont x + y))

-- Ex1.b
-- PRE : (null []) == false
product',product'' :: Num a => [a] -> a
product' xs = inner xs 1 where
  inner [] acc = acc
  inner (x:xs) acc = inner xs $! (acc * x)

product'' xs = inner xs (\x -> x) where
  inner :: Num a => [a] -> (a -> a) -> a
  inner [] cont = cont 1
  inner (x:xs) cont = inner xs (\n -> cont (n * x))

-- Ex1.c
flatten',flatten'' :: [[a]] -> [a]
flatten' xss = inner xss [] where
  inner [] acc = acc
  inner ((ys):xs) acc = inner xs $! (acc ++ ys)

flatten'' xss = inner xss (\x -> x) where
  inner :: [[a]] -> ([a] -> [a]) -> [a]
  inner [] cont = cont []
  inner (x:xs) cont = inner xs (\n -> cont (x ++ n))

-- Ex1.d
deleteAll,deleteAll' :: Eq a => a -> [a] -> [a]
deleteAll elt xs = inner (reverse' xs) [] where
  inner [] acc = acc
  inner (x:xs) acc
    | x == elt = inner xs acc
    | otherwise = inner xs $! (x:acc)

deleteAll' elt xs = inner xs (\x -> x) where
  inner [] cont = cont []
  inner (x:xs) cont
    | x == elt = inner xs (\ns -> cont ns)
    | otherwise = inner xs (\ns -> cont (x : ns))

-- Ex1.e
insert',insert'' :: Ord a => a -> [a] -> [a]
insert' elt xs = inner xs [] where
  inner [] acc = reverse' (elt:acc)
  inner l@(x:xs) acc
    | elt <= x = (reverse' acc) ++ (elt:l)
    | otherwise = inner xs $! (x:acc)

insert'' elt xs = inner xs (\x -> x) where
  inner [] cont = cont (elt : [])
  inner (x:xs) cont
    | elt <= x = cont (elt : x : xs)
    | otherwise = inner xs (\ns -> cont (x : ns))

-- Utility function

-- reverse a list, used to reverse a list after or before tail recursion,
-- when we don't want the inversion of the list during the algorithm
reverse' :: [a] -> [a]
reverse' xs = inner xs [] where
  inner [] acc = acc
  inner (x:xs) acc = inner xs $! (x:acc)


---------------
---- Tests ----
---------------

-- Function properties

prop_product :: (Num a, Eq a) => [a] -> Bool
prop_product xs = (product' xs) == (product xs) &&
                  (product'' xs) == (product xs)

prop_flatten :: Eq a => [[a]] -> Bool
prop_flatten xss = (flatten' xss) == (join xss) &&
                   (flatten'' xss) == (join xss)

prop_deleteAll :: Eq a => a -> [a] -> Bool
prop_deleteAll n xs = (deleteAll n xs) == (filter (\x -> x /= n) xs) &&
                      (deleteAll' n xs) == (filter (\x -> x /= n) xs)

prop_insert :: Ord a => a -> [a] -> Bool
prop_insert n xs = (insert' n xs) == (L.insert n xs) &&
                   (insert'' n xs) == (L.insert n xs)

-- run the tests using main
main = do
  quickCheck (prop_product :: [Int] -> Bool)
  quickCheck (prop_flatten :: [[Int]] -> Bool)
  quickCheck (prop_flatten :: [[Char]] -> Bool)
  quickCheck (prop_flatten :: [[String]] -> Bool)
  quickCheck (prop_deleteAll :: Int -> [Int] -> Bool)
  quickCheck (prop_deleteAll :: Char -> [Char] -> Bool)
  quickCheck (prop_deleteAll :: String -> [String] -> Bool)
  quickCheck (prop_insert :: Int -> [Int] -> Bool)
  quickCheck (prop_insert :: Char -> [Char] -> Bool)
  quickCheck (prop_insert :: String -> [String] -> Bool)

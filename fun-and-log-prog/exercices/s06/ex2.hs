module S06_Ex2 where

{-
Module     : S06_Ex2
Description : Series 06 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

-- imports for tests
import Test.QuickCheck
import Control.Monad
import qualified Data.List as L
import qualified Data.Set as S

-- type declaration
data BinaryTree a = EmptyTree | Node a (BinaryTree a) (BinaryTree a) deriving (Show,Eq,Ord)

-- Ex1.a
insertInTree :: (Eq a, Ord a) => a -> BinaryTree a -> BinaryTree a
insertInTree elt EmptyTree = Node elt EmptyTree EmptyTree
insertInTree elt (Node e left right)
  | elt >= e = Node e (insertInTree elt left) right
  | otherwise = Node e left (insertInTree elt right)

-- Ex1.b
searchInTree :: (Eq a , Ord a) => a -> BinaryTree a -> Bool
searchInTree _ EmptyTree = False
searchInTree elt (Node e left right)
  | elt == e = True
  | elt > e = searchInTree elt left
  | otherwise = searchInTree elt right

-- Ex1.c
sortTree :: BinaryTree a -> [a]
sortTree EmptyTree = []
sortTree (Node e left right) = (sortTree right) ++ [e] ++ (sortTree left)

main = do
  let t1 = insertInTree 8 EmptyTree
  let t2 = insertInTree 6 t1
  let t3 = insertInTree 3 t2
  let t4 = insertInTree 2 t3
  let t5 = insertInTree 1 t4
  let t6 = insertInTree 9 t5
  let t7 = insertInTree 12 t6
  let t8 = insertInTree (-12) t7
  print (sortTree t8)

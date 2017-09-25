module S01 where

{-
Module     : S01
Description : Series 01 of the Functionnal and Logic Programming course at UniFR
Author : Sylvain Julmy
Email : sylvain.julmy(at)unifr.ch
-}

-- 3.a
-- Could also replace Int by Integer
sum4 :: Int -> Int -> Int -> Int -> Int
sum4 a b c d = a + b + c + d

-- 3.b
-- Could also replace Int by Integer
max3 :: Int -> Int -> Int -> Int
max3' :: Int -> Int -> Int -> Int
max3'' :: Int -> Int -> Int -> Int
max3''' :: Int -> Int -> Int -> Int
max3'''' :: Int -> Int -> Int -> Int
max3''''' :: Int -> Int -> Int -> Int

-- 3.b.1
max3 a b c =
  if a > b then
    if a > c then
      a
    else
      c
  else if b > c then
      b
  else c

-- 3.b.2
max3' a b c = case (a,b,c) of
  (x,y,z) | x >= y && x >= z -> x
  (x,y,z) | y >= x && y >= z -> y
  (_,_,z) -> c

-- 3.b.3
max3'' a b c
  | a >= b && a >= c = a
  | b >= a && b >= c = b
  | otherwise = c

-- 3.b.4
max3''' a b c = max' (max' a b) c where
  max' x y = if x > y then x else y

-- 3.b.5
max3'''' a b c = foldl (\x -> \y -> max x y) a [b,c]

-- 3.b.6
max3''''' a b c = m (m a b) c where
  m = \x -> \y -> max x y

-- 3.c
signe :: (Num a,Ord a, Eq a) => a -> String
signe' :: (Num a,Ord a, Eq a) => a -> String
signe'' :: (Num a,Ord a, Eq a) => a -> String
signe''' :: (Num a,Ord a, Eq a) => a -> String

thisNumberIs :: String -> String
thisNumberIs str = "Ce nombre est " ++ str
pos = thisNumberIs "positif"
nul = thisNumberIs "nulle"
neg = thisNumberIs "negatif"

-- 3.c.1
signe n | n < 0 = "Ce nombre est negatif"
        | n == 0 = "Ce nombre est nulle"
        | n > 0 = "Ce nombre est positif"

-- 3.c.2
signe' n =
  if n < 0 then
    neg
  else if n == 0 then
    nul
  else
    pos

-- 3.c.3
signe'' n = case n of
  x | x < 0 -> neg
  x | x > 0 -> pos
  x | x == 0 -> nul

-- 3.c.4
signe''' 0 = nul
signe''' x | x > 0 = pos
signe''' x | x < 0 = neg



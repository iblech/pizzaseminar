{-# LANGUAGE RankNTypes #-}
module Main where

data D a = D a a
    deriving (Show,Eq)

instance (Num a) => Num (D a) where
    D x a + D y b = D (x + y) (a + b)
    D x a * D y b = D (x * y) (x*b + a*y)
    abs (D x a) = D (abs x) (a * signum x)
    signum (D x a) = D (signum x) 0
    fromInteger = fromConstant . fromInteger
    negate (D x a) = D (negate x) (negate a)

instance (Fractional a) => Fractional (D a) where
    fromRational = fromConstant . fromRational
    recip (D x a) = D (recip x) (-a / x^2)

instance (Floating a) => Floating (D a) where
    sin (D x a) = D (sin x) (a * cos x)

fromConstant :: (Num a) => a -> D a
fromConstant x = D x 0

deriv :: (Floating a) => (forall b. (Floating b) => b -> b) -> (a -> a)
deriv f x = let D _ a = f (D x 1) in a

deriv' :: (Num a) => (D a -> D a) -> (a -> a)
deriv' f x = let D _ a = f (D x 1) in a

newton :: (Floating a) => Int -> (forall b. (Num b) => b -> b) -> a -> a
newton n f x0 = iterate (\x -> x - f x / deriv f x) x0 !! n

newton' :: (Fractional a) => Int -> (D a -> D a) -> a -> a
newton' n f x0 = iterate (\x -> let D y y' = f (D x 1) in x - y / y') x0 !! n

demo1 :: (Floating a) => a -> a
demo1 = deriv (\a -> a^2)

demo2 :: (Floating a, Show a) => (forall b. (Floating b) => b -> b) -> [a] -> a -> String
demo2 f xs h = flip concatMap xs $ \x ->
    show x ++ "\t" ++ show (deriv f x) ++ "\t" ++ show ((f (x + h) - f x) / h) ++ "\n"

demo3 :: (Floating a) => a -> a
demo3 y = deriv' g y - 1/(2*sqrt y)
    where g u = newton' 10 (\x -> x^2 - fromConstant u) 1

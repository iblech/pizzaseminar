module Main where

import Control.Monad
import Control.Monad.ST
import Data.STRef
import System.Random.MWC
import Data.Random.Normal

type Density a = a -> Double
type I = Double

uniformSampler :: Gen s -> ST s I
uniformSampler = uniform

metropolisSampler
    :: Density a
    -> a
    -> ST s I
    -> Density (a,a)
    -> (a -> ST s a)
    -> ST s (ST s a)
metropolisSampler f x0 unif q draw = do
    xRef <- newSTRef x0
    return $ do
        u <- unif
        x <- readSTRef xRef
        x' <- draw x
        if u < min 1 ((f x' * q (x,x')) / (f x * q (x',x)))
            then writeSTRef xRef x' >> return x'
            else return x

customSampler :: [a] -> ST s (ST s a)
customSampler xs = do
    vRef <- newSTRef xs
    return $ do
        v:vs <- readSTRef vRef
        writeSTRef vRef vs
        return v

{-
normalSampler :: ST s I -> ST s (ST s Double)
normalSampler unif = metropolisSampler
    (\x -> 1 / sqrt(2*pi) * exp (-x^2/2))
    0
    unif
    (\(x,y) -> if abs x <= 1 && abs y <= 1 then 1 else 0)
    (\_ -> liftM (\x -> 2*x - 1) unif)
-}

main = do
    putStrLn "x"
    normals <- normalsIO :: IO [Double]
    mapM_ print =<< withSystemRandom (demo3 normals)

demo1 gen = uniformSampler gen

demo2 normals gen = do
    normalSampler <- customSampler normals
    replicateM 10000 normalSampler

demo3 normals gen = do
    normalSampler <- customSampler normals
    fooSampler <- metropolisSampler
        (\x -> exp (-x^2/2) + exp (-(x-3)^2/2) + exp (-(x+8)^2/2))
        0
        (uniformSampler gen)
        (\(x,y) -> 1 / sqrt (2*pi) * exp (-(x-y)^2/2))
        (\y -> liftM (y +) normalSampler)
    replicateM 100000 fooSampler

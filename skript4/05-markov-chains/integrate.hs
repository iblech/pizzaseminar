module Main where

import Data.Random
import Control.Monad
import Control.Monad.Trans
import Data.IORef
import Data.Random.Distribution.Bernoulli
import System.Environment

type Density a = a -> Double

type I = Double

uniformDensity :: Density I
uniformDensity theta = log $ if 0 <= theta && theta <= 1 then 1 else 0

normalDensity :: Double -> Double -> Density Double
normalDensity mu sigma x = log $ 1 / (sigma * sqrt (2*pi)) * exp (-(x-mu)^2/(2*sigma^2))

metropolisSampler
    :: Density a
    -> a
    -> Density (a,a)
    -> (a -> RVarT IO a)
    -> IO (RVarT IO a)
metropolisSampler f x0 q draw = do
    xRef <- newIORef x0
    return $ do
        u <- stdUniformT
        x <- lift $ readIORef xRef
        x' <- draw x
        if log u < min 0 ((f x' + q (x,x')) - (f x + q (x',x)))
            then lift (writeIORef xRef x') >> return x'
            else return x

fooSampler
    :: Density Double
    -> Double
    -> IO (RVarT IO Double)
fooSampler f x0 = do
    metropolisSampler
        f
        x0
        (\(x,y) -> normalDensity y 0.5 x)
        (\y -> normalT y 0.5)

churn :: Int -> Int -> [a] -> [a]
churn burnin n = go 0 . drop burnin
    where
    go 0 (x:xs) = x : go n xs
    go m []     = []
    go m (x:xs) = go (m-1) xs

main = do
    let a = id
    let f x = log $ sum $ map exp
          [ normalDensity (-3) 1 x
          , normalDensity 5 2 x
          , normalDensity (-2) 0.5 x
          ]

    sampler <- fooSampler f 1
    --let sampler = normalT 0 1 :: RVarT IO Double
    sample (replicateM_ 1000 sampler)

    [skipNum] <- getArgs

    let go ys = do
        x <- sample sampler
        let ys' = a x : ys
        print $ avg ys'
        sample (replicateM_ (read skipNum) sampler)
        go ys'

    go []

avg xs = sum xs / fromIntegral (length xs)

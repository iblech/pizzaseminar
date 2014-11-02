module Main where

import Data.Random
import Control.Monad
import Control.Monad.Trans
import Data.IORef
import Text.Printf
import Data.Random.Distribution.Bernoulli

type Density a = a -> Double

type I = Double

uniformDensity :: Density I
uniformDensity theta = log $ if 0 <= theta && theta <= 1 then 1 else 0

posterior :: Density I -> [Bool] -> Density I
posterior prior xs theta = prior theta + sum (map (\x -> if x then log theta else log (1-theta)) xs)

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

churn :: (Monad m) => Int -> Int -> m a -> m (m a)
churn burnin n m = do
    replicateM_ burnin m
    return (replicateM_ n m >> m)

churn' :: Int -> Int -> [a] -> [a]
churn' burnin n = go 0 . drop burnin
    where
    go 0 (x:xs) = x : go n xs
    go m []     = []
    go m (x:xs) = go (m-1) xs

normalDensity mu sigma x = log $ 1 / (sigma * sqrt (2*pi)) * exp (-(x-mu)^2/(2*sigma^2))

main = do
    xs <- sample (replicateM 10 $ boolBernoulli (0.6::Double) :: RVarT IO [Bool])
    let f = posterior uniformDensity xs
    sampler <- fooSampler f 0.5
    ys <- sample (replicateM 10000 sampler)
    --mapM_ (\t -> printf "%f\t%f\n" t (exp $ f t)) [0,0.01..1]
    mapM_ print $ churn' 1000 30 ys

demo :: RVarT IO Double
demo = stdUniformT

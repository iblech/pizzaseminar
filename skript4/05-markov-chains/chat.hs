module Main where

import qualified Data.Text as T
import qualified Data.Text.IO as T.IO
import qualified Data.Map as M
import Control.Monad
import Control.Monad.Random
import Data.Maybe
import Data.List
import System.Environment

tokenize :: T.Text -> [[T.Text]]
tokenize =
    map (++ [T.empty]) . filter (not . null) . map (filter (not . T.null) .
    T.split (`elem` " ,")) . T.split (`elem` ".;:")

blocks :: Int -> [a] -> [[a]]
blocks n xs
    | length xs >= n
    = take n xs : blocks n (tail xs)
    | otherwise
    = []

parse :: Int -> T.Text -> M.Map [T.Text] [[T.Text]]
parse n = chain' . map (blocks n) . tokenize

parse2 :: Int -> T.Text -> (M.Map [T.Text] [[T.Text]], M.Map [T.Text] [[T.Text]])
parse2 n txt = (chain' xs, chain' xs')
    where
    xs  = map (blocks n) . tokenize $ txt
    xs' = map reverse . map (blocks n) . map ((T.pack "") :) . tokenize $ txt

chain :: (Ord a) => [a] -> M.Map a [a]
chain = M.fromListWith (++) . map (\(x,y) -> (x,[y])) . pairs

chain' :: (Ord a) => [[a]] -> M.Map a [a]
chain' = M.unionsWith (++) . map chain

draw :: (MonadRandom m, Ord a) => M.Map a [a] -> m [a]
draw v = getRandomKey v >>= go
    where
    go k = liftM (k:) $ do
        let ks = M.lookup k v
        if isNothing ks || null (fromJust ks)
            then return []
            else getRandomElem (fromJust ks) >>= go

draw2 :: (MonadRandom m, Ord a) => M.Map a [a] -> M.Map a [a] -> a -> m [a]
draw2 v w x = go1 x []
    where
    go1 k acc = do
        let ks = M.lookup k w
        if isNothing ks || null (fromJust ks)
            then go2 (k:acc)
            else do
                k' <- getRandomElem (fromJust ks)
                go1 k' (k:acc)
    go2 prev = liftM (init prev ++) $ go3 (last prev)
    go3 k = liftM (k:) $ do
        let ks = M.lookup k v
        if isNothing ks || null (fromJust ks)
            then return []
            else getRandomElem (fromJust ks) >>= go3

draw2' :: (MonadRandom m, Ord a) => M.Map a [a] -> M.Map a [a] -> m [a]
draw2' v w = do
    k <- getRandomKey v
    draw2 v w k

drawText :: (MonadRandom m) => M.Map [T.Text] [[T.Text]] -> m T.Text
drawText = liftM (T.concat . intersperse (T.pack " ") . map head) . draw

drawText2 :: (MonadRandom m) => M.Map [T.Text] [[T.Text]] -> M.Map [T.Text] [[T.Text]] -> m T.Text
drawText2 v w = liftM (T.concat . intersperse (T.pack " ") . map head) $ draw2' v w

getRandomKey :: (MonadRandom m) => M.Map a b -> m a
getRandomKey xs = liftM (fst . flip M.elemAt xs) $ getRandomR (0, M.size xs - 1)

getRandomElem :: (MonadRandom m) => [a] -> m a
getRandomElem xs = liftM (xs !!) $ getRandomR (0, length xs - 1)

pairs :: [a] -> [(a,a)]
pairs [] = []
pairs (x:[]) = []
pairs (x:y:xs) = (x,y) : pairs (y:xs)

main = do
    [n] <- getArgs
    txt <- T.IO.getContents
    let (v,w) = parse2 (read n) txt
    join $ liftM (mapM_ (\x -> T.IO.putStrLn x >> putStrLn "===")) $ evalRandIO $ replicateM 1000 $ drawText2 v w

repeatM :: (Monad m) => m a -> m [a]
repeatM m = let n = m >>= \x -> liftM (x:) n in n

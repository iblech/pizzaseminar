module Main where

import qualified Data.Text as T
import qualified Data.Text.IO as T.IO
import qualified Data.Map as M
import Control.Monad
import Control.Monad.Random
import Data.Maybe
import Data.List
import System.Environment
import Data.Binary
import Data.Text.Binary

tokenize :: T.Text -> [[T.Text]]
tokenize =
    map (++ [T.empty]) . filter (not . null) . map (filter (not . T.null) .
    T.split (`elem` " ")) . T.split (`elem` ".;:")

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

parse3 :: Int -> T.Text -> (M.Map [T.Text] [[T.Text]], M.Map [T.Text] [[T.Text]], M.Map T.Text [[T.Text]])
parse3 n txt = (v, w, z)
    where
    (v,w) = parse2 n txt
    z = M.fromListWith (++) . map (\x -> (head x, [x])) $ M.keys v
    -- FIXME: The resulting map z is incomplete.

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
            then go2 acc
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
drawText = liftM prettyifyText . draw

prettyifyText = T.concat . intersperse (T.pack " ") . heads
    where heads xs = map head (init xs) ++ init (last xs)

drawText2 :: (MonadRandom m) => M.Map [T.Text] [[T.Text]] -> M.Map [T.Text] [[T.Text]] -> m T.Text
drawText2 v w = liftM prettyifyText $ draw2' v w

drawText3
    :: (MonadRandom m)
    => M.Map [T.Text] [[T.Text]]
    -> M.Map [T.Text] [[T.Text]]
    -> M.Map T.Text [[T.Text]]
    -> T.Text
    -> m (Maybe T.Text)
drawText3 v w z a =
    case M.lookup a z of
        Just ks -> do
            k <- getRandomElem ks
            liftM (Just . prettyifyText) $ draw2 v w k
        Nothing -> return Nothing

getRandomKey :: (MonadRandom m) => M.Map a b -> m a
getRandomKey xs = liftM (fst . flip M.elemAt xs) $ getRandomR (0, M.size xs - 1)

getRandomElem :: (MonadRandom m) => [a] -> m a
getRandomElem xs = liftM (xs !!) $ getRandomR (0, length xs - 1)

pairs :: [a] -> [(a,a)]
pairs [] = []
pairs (x:[]) = []
pairs (x:y:xs) = (x,y) : pairs (y:xs)

main = do
    args <- getArgs
    case args of
        [n, txt, dat] -> prepareCorpus (read n) txt dat
        [dat] -> do
            (v,w,z) <- decodeFile dat
            putStrLn "Ready."
            forever $ do
                a <- getLine
                x <- evalRandIO $ if null a
                    then drawText2 v w
                    else liftM (fromMaybe $ T.pack "...") $ drawText3 v w z (T.pack a)
                T.IO.putStr x
                putStrLn ".\n=====\n"

prepareCorpus :: Int -> FilePath -> FilePath -> IO ()
prepareCorpus n txt dat = encodeFile dat =<< liftM (parse3 n) (T.IO.readFile txt)

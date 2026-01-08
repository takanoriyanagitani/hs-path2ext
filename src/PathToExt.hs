module PathToExt (
    stdin2path2ext2stdout,
    run,
    IsEof,
    isEof,
) where

import System.FilePath (takeExtension)

import System.IO (isEOF)

newtype IsEof = IsEof {isEof :: Bool}

stdin2path2ext2stdout :: IsEof -> IO ()
stdin2path2ext2stdout (IsEof True) = return ()
stdin2path2ext2stdout (IsEof False) = do
    path :: String <- getLine
    let ext :: String = takeExtension path
    putStrLn ext
    eof :: Bool <- isEOF
    stdin2path2ext2stdout (IsEof eof)

run :: IO ()
run = do
    eof :: Bool <- isEOF
    stdin2path2ext2stdout (IsEof eof)

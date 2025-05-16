module Types.Types where

-- | Système de types

data Type = TInt | TBool | TString
    deriving (Show, Eq)

type Env = [(String, Type)]
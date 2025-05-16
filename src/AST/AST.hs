module AST.AST where

-- | Définition du type d'arbre syntaxique abstrait

data Expr = ExprNode String [Expr]
    deriving (Show, Eq)
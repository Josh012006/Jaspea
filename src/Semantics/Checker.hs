module Semantics.Checker where

import AST.AST (Expr)
import Types.Types (Type, Env)

check :: Env -> Expr -> Either String Type
check env expr = undefined
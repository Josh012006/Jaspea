module Parser.Parser where

import Lexer.Lexer (Token)
import AST.AST (Expr)

parser :: [Token] -> Expr
parser = undefined
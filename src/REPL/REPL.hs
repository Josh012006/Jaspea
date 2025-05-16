module REPL.REPL where

import Simulator.Simulator (simulate)
import Parser.Parser (parser)
import Lexer.Lexer (lexer)

-- | Read-Eval-Print Loop
repl :: IO ()
repl = undefined
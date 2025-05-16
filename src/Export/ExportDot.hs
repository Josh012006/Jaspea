module Export.ExportDot where

import AST.AST (Expr)

exportDot :: Expr -> FilePath -> IO ()
exportDot expr path = undefined
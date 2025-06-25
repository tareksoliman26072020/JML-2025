{-# Language MultiParamTypeClasses #-}
module SymbolTable.API where

import Parser.Types

class Visitor inn out where
  visit :: inn -> out


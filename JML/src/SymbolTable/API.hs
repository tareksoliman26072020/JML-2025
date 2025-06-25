{-# Language MultiParamTypeClasses #-}
module SymbolTable.API where

import Parser.Types

class Visitor v where
  visitMethod :: Method -> v
  visitStatement :: Statement -> v


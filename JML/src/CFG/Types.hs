module CFG.Types where

import qualified Parser.Types as AST(Statement,Expression)

type NodeID = Int

data Node = Entry {id :: NodeID} | End {id :: NodeID} | Node {
  id :: NodeID,
  contents :: NodeData
} deriving Show

data CFG = CFG {
  nodes :: [Node],
  edges :: [(NodeID,[NodeID])]
} deriving Show

data NodeData = Statement AST.Statement | BooleanExpression Kind AST.Expression | Meet Kind
              deriving Show

data Kind = If | While
          deriving Show

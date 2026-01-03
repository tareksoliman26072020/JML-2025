{-# Language LambdaCase #-}
module Parser.Types where

import qualified Control.Exception as E
import Text.Printf (printf)
import Data.List (intercalate)

data BinOp = Plus | Mult | Minus | Div | Mod | Less | LessEq | Greater | GreaterEq | Eq | Neq | And | Or deriving Eq
instance Show BinOp where
  show Plus      = "+"
  show Mult      = "*"
  show Minus     = "-"
  show Div       = "/"
  show Mod       = "%"
  show Less      = "<"
  show LessEq    = "<="
  show Greater   = ">"
  show GreaterEq = ">="
  show Eq        = "=="
  show Neq       = "!="
  show And       = "&&"
  show Or        = "||"

-- | precedence of binary operators in proper order
data Prec = PMul | PAdd | PCmp | PAnd | POr deriving (Enum, Eq, Ord, Show)

prec :: BinOp -> Prec
prec = \case
  Plus -> PAdd
  Mult -> PMul
  Minus -> PAdd
  Div -> PMul
  Mod -> PMul
  And -> PAnd
  Or -> POr
  _ -> PCmp

-- | associativity of binary operators
data Assoc = ALeft | ARight | ANon deriving (Eq, Show)

-- | compute associativity from precedence rather than from operators directly
assoc :: Prec -> Assoc
assoc = \case
  PMul -> ALeft
  PAdd -> ALeft
  PCmp -> ANon
  _ -> ARight

data UnOp = NotOp deriving Eq
instance Show UnOp where
  show NotOp = "!"

data Expression
  = NumberLiteral Float
  | BoolLiteral Bool
  | CharLiteral Char
  | StringLiteral String
  | Null
  | VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
  | ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
  | ArrayInstantiationExpr {arrType :: Maybe (Type Types), arrSize :: Maybe Expression, arrElems :: [Expression]}
  | BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
  | UnOpExpr {unOp :: UnOp, expr :: Expression}
  | FunCallExpr {funName :: Expression, funArgs :: [Expression]}
  | CondExpr {eiff :: Expression, ethenn :: Expression, eelsee :: Expression}
  | AssignExpr {assEleft :: Expression, assEright :: Expression}
  | ExcpExpr {excpName :: Exception, excpmsg :: Maybe String}
  | ReturnExpr {returnE :: Maybe Expression}
  deriving (Eq, Show)

isLiteral :: Expression -> Bool
isLiteral (NumberLiteral _) = True
isLiteral (BoolLiteral _) = True
isLiteral (CharLiteral _) = True
isLiteral (StringLiteral _) = True
isLiteral _ = False

fromBoolLiteral :: Expression -> Bool
fromBoolLiteral (BoolLiteral bool) = bool
fromBoolLiteral _ = undefined

data Statement
  = CompStmt {statements :: [Statement]}
  | VarStmt {var :: Expression}
  | AssignStmt {varModifier :: [Modifier], assign :: Expression}
  | CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
  | ForStmt {mAcc :: Maybe Statement, mCond :: Maybe Expression, mStep :: Maybe Statement, forBody :: Statement}
  | WhileStmt {mCondition :: Maybe Expression, whileBody :: Statement}
  | FunCallStmt {funCall :: Expression}
  | TryCatchStmt {tryBody :: Statement,
                  catchExcp :: Type Exception, catchBody :: Statement,
                  finallyBody :: Statement}
  | ReturnStmt {returnS :: Maybe Expression}
  deriving (Eq, Show)

data Method = FunDef {funModifier :: [Modifier],
                      isPureFlag :: Bool,
                      funDecl :: Statement,
                      throws :: Maybe Exception,
                      funBody :: Statement} deriving(Eq,Show)

-- public int boo30(int z) ==> (Just BuiltInType Int, "boo30")
getMethodDecl :: Method -> (Maybe (Type Types), String)
getMethodDecl method = case funDecl method of
  FunCallStmt s -> case s of
    FunCallExpr n _ -> case n of
      --VarExpr {varType = Just (BuiltInType Void), varObj = [], varName = "boo36"}
      VarExpr mt _ mn -> (mt,mn)
      _               -> error "won't happen"
    _               -> error "won't happen"
  _               -> error "won't happen"

getMethodFormalParams :: Method -> [Expression]
getMethodFormalParams method = case funDecl method of
  FunCallStmt s -> case s of
    FunCallExpr _ args -> args
    _                  -> error "won't happen"
  _ -> error "won't happen"

getFunCallName :: Statement -> String
getFunCallName (FunCallStmt s) = case s of
  FunCallExpr n _ -> case n of
    --VarExpr {varType = Just (BuiltInType Void), varObj = [], varName = "boo36"}
    VarExpr _ _ mn -> mn
    _              -> error "won't happen"
  _               -> error "won't happen"
getFunCallName _ = error "won't happen"

-- VarExpr {varType = Nothing, varObj = [], varName = "i"}
getVarName :: Expression -> String
getVarName expr@VarExpr{} = varName expr
getVarName expr = error $ "won't happen: " ++ show expr

getActualParmName :: Expression -> String
getActualParmName = \case
  --VarExpr {varType = Nothing, varObj = [], varName = "i"}
  expr@VarExpr{} -> varName expr
  --BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
  expr@BinOpExpr{} ->
    printf "%s%s%s" (getActualParmName $ expr1 expr) (show $ binOp expr) (getActualParmName $ expr2 expr)
  NumberLiteral num -> show num
  ArrayInstantiationExpr _ _ arrElems -> printf "{%s}"
    $ intercalate ", " $ map getActualParmName arrElems
  expr -> error $ "TODO: getActualParmName: " ++ show expr

data Type a
  = BuiltInType a
  | AnyType {typee :: String, generic :: Maybe (Type a)}
  | ArrayType {baseType :: Type a}
  deriving (Eq, Show)

data Types
  = Int
  | Void
  | Char
  | String
  | Boolean
  | Double
  | Short
  | Float
  | Long
  | Byte

--  | Exception Exception
  deriving(Eq,Show)

data Modifier
  = Static
  | Public
  | Private
  | Protected
  | Final
  | Abstract
  deriving (Eq, Show)

-- | https://www.geeksforgeeks.org/types-of-exception-in-java-with-examples/
newtype Exception = Exception String deriving Eq
instance Show Exception where
  show (Exception str) = str

newtype NotatedException = NoteExcp String

instance Show NotatedException where
  show (NoteExcp str) = str

instance E.Exception NotatedException

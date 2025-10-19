{-# Language LambdaCase #-}
module SymbolicExecution.Log where

import Text.Printf (printf)
import Data.List (foldl', intercalate)
-- "\ESC[1;31mTarek\ESC[m"
data Log = Expression_2_Handle String String
         | MethodStart String String
         | MethodEnd String
         | Void String
         | ReturnStatement String String
         | Edge_2_Handle String String
         | Meow String String
         | Node_2_Handle String String
         | HorizontalLine String
         | MethodStatement String
         | AssignStatement String String
         | NewVariable String String String
         | UpdateVariable String String
         | LookUpEnvTable String String String
         | NextNode String
         | MethodFormalParams String String
         | NextMethodCallSymExpr String String
         | Affected String [String]
         | ModifyState String (String,String)
         | Return String String

-- Look up the usage of the function `tell` in SymbolicExecution
-- to best relate to `Log`
instance Show Log where
  show = \case
    MethodEnd loc           -> printf "(%s): %s" (cyan loc) (yellow "Method End")
    Void loc                -> printf "(%s): %s" (cyan loc) (yellow "Void")
    MethodStart str loc     -> printf "(%s): %s: %s" (cyan loc) (yellow "Method Start") str
    MethodStatement loc     -> printf "(%s): %s" (cyan loc) (yellow "Method Statement")
    Expression_2_Handle
      str loc               -> printf "(%s): %s: %s" (cyan loc) (yellow "handling expression") str
    ReturnStatement str loc -> printf "(%s): %s: %s" (cyan loc) (yellow "handling return expression") str
    AssignStatement str loc -> printf "(%s): %s: %s" (cyan loc) (yellow "handling assign statement") str
    Edge_2_Handle str loc   -> printf "(%s): %s: %s" (cyan loc) (yellow "running CFG") str
    Meow str1 str2          -> printf "Meow: %s %s" str1 str2
    HorizontalLine str      -> printf ">>>>>>>>>> %s <<<<<<<<<<" (yellow str)
    NewVariable tn vn loc   -> printf "(%s): %s %s %s" (cyan loc) (yellow "New Variable") tn vn
    UpdateVariable vn loc   -> printf "(%s): %s %s" (cyan loc) (yellow "Update Variable") vn
    LookUpEnvTable
      key val loc           -> printf "(%s): %s: (%s ~~> %s) " (cyan loc) (yellow "Look up in environmane table") key val
    MethodFormalParams
      args loc              -> printf "(%s): %s: %s" (cyan loc) (yellow "Visiting formal parameters") args
    NextNode nodeStr        -> printf "%s: %s" (yellow "Next Node") nodeStr
    NextMethodCallSymExpr
      symExpr methodCall    -> printf "%s (%s) in Method Call: %s" (yellow "Next symExpr") symExpr methodCall
    Affected loc exprs      -> printf "(%s): %s: %s" (cyan loc) (yellow "Affected") (intercalate ", " exprs)
    ModifyState loc (k,v)   -> printf "(%s): %s: (%s,%s)" loc (yellow "Modifying State") (cyan k) (cyan v)
    Return loc val          -> printf "(%s): %s: %s" (cyan loc) (yellow "Returning") val

cyan :: String -> String
cyan = printf "\ESC[1;36m%s\ESC[m"

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

ppLogs :: [Log] -> [String]
ppLogs = snd . foldl' enumerated (1,[])
  where
  enumerated :: (Int,[String]) -> Log -> (Int,[String])     
  enumerated (num,res) log@(HorizontalLine _) = (num,res ++ [show log])
  enumerated (num,res) x = (num+1,res ++ [printf "%d) %s" num (show x)])

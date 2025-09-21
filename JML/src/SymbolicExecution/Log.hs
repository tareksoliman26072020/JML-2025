{-# Language LambdaCase #-}
module SymbolicExecution.Log where

import Text.Printf (printf)
import Data.List (foldl')

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
         | Assign String String String
         | LookUpEnvTable String String String
         | NextNode String

instance Show Log where
  show = \case
    MethodEnd loc               -> printf "(%s): Method End" loc
    Void loc                    -> printf "(%s): Void" loc
    MethodStart str loc         -> printf "(%s): Method Start: %s" loc str
    MethodStatement str         -> printf "(%s): Method Statement" str
    Expression_2_Handle str loc -> printf "(%s): handling expression: %s" loc str
    ReturnStatement str loc     -> printf "(%s): handling return expression: %s" loc str
    AssignStatement str loc     -> printf "(%s): handling assign statement: %s" loc str
    Edge_2_Handle str loc       -> printf "(%s): running CFG: %s" loc str
    Meow str1 str2              -> printf "Meow: %s %s" str1 str2
    HorizontalLine str          -> printf ">>>>>>>>>> %s <<<<<<<<<<" str
    NewVariable tn vn loc       -> printf "(%s): %s %s" loc tn vn
    UpdateVariable vn loc       -> printf "(%s): %s" loc vn
    Assign left right loc       -> printf "(%s): Assigning %s = %s" loc left right
    LookUpEnvTable key val loc  -> printf "(%s): Look up in environmane table (%s ~~> %s) " loc key val
    NextNode nodeStr            -> "Next Node: " ++ nodeStr

ppLogs :: [Log] -> [String]
ppLogs = snd . foldl' enumerated (1,[])
  where
  enumerated :: (Int,[String]) -> Log -> (Int,[String])     
  enumerated (num,res) log@(HorizontalLine _) = (num,res ++ [show log])
  enumerated (num,res) x = (num+1,res ++ [printf "%d) %s" num (show x)])

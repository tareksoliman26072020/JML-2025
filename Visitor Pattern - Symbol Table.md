Is it possible to use visitor patterns to build symbol table and to update it when visiting nodes?

If yes, explain using the method sqrt2 using visitor patterns (in Haskell).

---

Yes, absolutely. Using the Visitor pattern to build and update a symbol table is one of its primary and most powerful applications in compilers and static analysis tools.

The core idea is that the "visitor" carries the state of the symbol table with it as it traverses the Abstract Syntax Tree (AST). When the visitor enters a new scope (like a method or a loop), it updates the symbol table to reflect this. When it finds a variable declaration, it adds the symbol to the table.

In Haskell, this is handled elegantly by using the **State Monad**. The visitor's logic will be a computation that implicitly threads the symbol table state through the AST traversal.

Let's walk through it with the `sqrt2` method.

### 1. Defining the Symbol Table Structure

First, we need data structures for our symbol table. A symbol table must handle nested scopes. A list of Maps is a perfect fit, where the head of the list is the current, innermost scope.

```haskell
import qualified Data.Map as Map
import Control.Monad.State

-- The type of the variable (simplified for this example)
data SymbolType = JInt | JException deriving (Show, Eq)

-- A single scope is a map from variable name to its type
type Scope = Map.Map String SymbolType

-- The SymbolTable is a stack (list) of scopes
type SymbolTable = [Scope]

-- Helper function to create an empty symbol table (just the global scope)
initialSymbolTable :: SymbolTable
initialSymbolTable = [Map.empty]
```

### 2. A Monadic Visitor Type Class

We'll redefine our `AstVisitor` type class to work within a monad that can manage our `SymbolTable` state.

```haskell
-- AST definitions from the previous example (Method, Statement, etc.) remain the same.

-- The new type class is constrained to monads that can manage SymbolTable state.
class (MonadState SymbolTable m) => AstVisitor m where
  visitMethod     :: Method -> m ()
  visitStatement  :: Statement -> m ()
  -- We don't need to visit expressions for this example

-- Helper functions to manipulate the symbol table within our monad
enterScope :: (MonadState SymbolTable m) => m ()
enterScope = modify (Map.empty :) -- Push a new, empty scope onto the stack

exitScope :: (MonadState SymbolTable m) => m ()
exitScope = modify tail -- Pop the current scope off the stack

addSymbol :: (MonadState SymbolTable m) => String -> SymbolType -> m ()
addSymbol name symType = modify $ \(currentScope:outerScopes) ->
  (Map.insert name symType currentScope) : outerScopes
```

### 3. Implementing the Visitor Logic

Now, we create an instance of our `AstVisitor` for the `State` monad. The logic for handling scopes and declarations is placed in the corresponding functions.

```haskell
-- We make the 'State SymbolTable' monad an instance of our visitor.
instance AstVisitor (State SymbolTable) where
  visitMethod (MethodDeclaration _ body) = do
    enterScope
    -- Add method parameters to the new scope
    addSymbol "y" JInt
    -- Recursively visit the statements in the method body
    mapM_ visitStatement body
    exitScope

  visitStatement stmt = case stmt of
    -- A 'for' loop creates its own new scope in Java/C
    ForStatement initS _ _ body -> do
      enterScope
      visitStatement initS -- The initializer is inside the new scope
      mapM_ visitStatement body
      exitScope

    -- This is where we add a symbol to the table!
    VarDecl name _ -> do
      -- A real tool would analyze the expression to get the type.
      -- We'll just hardcode it to JInt for this example.
      addSymbol name JInt

    -- For an 'if', just visit the children blocks. Scopes are not created by the 'if' itself.
    IfStatement _ thenS elseS -> do
      visitStatement thenS
      visitStatement elseS

    Block stmts -> mapM_ visitStatement stmts

    -- Other statements don't affect the symbol table in this example
    _ -> return ()
```

### 4. Tracing the `sqrt2` Analysis Step-by-Step

Let's trace how the `SymbolTable` state changes as the visitor traverses the `sqrt2` AST. We'll use the `execState` function, which runs the stateful computation and returns the final state.

```haskell
-- The AST for the sqrt2 method (slightly simplified for clarity)
sqrt2Ast :: Method
sqrt2Ast = MethodDeclaration "sqrt2"
  [ ForStatement
      (VarDecl "i" (Val 0))
      (BinOp "<=" (Var "i") (Var "y"))
      (UnaryOp "++" (Var "i"))
      [ VarDecl "j" (BinOp "*" (Var "i") (Var "i"))
      , IfStatement (BinOp "==" (Var "j") (Var "y"))
          (ReturnStatement (Var "i"))
          (Block [ IfStatement (BinOp "==" (Var "i") (Var "y")) (ThrowStatement "not found") EmptyStatement ])
      ]
  ]

-- Function to run the analysis
buildSymbolTable :: Method -> SymbolTable
buildSymbolTable method = execState (visitMethod method) initialSymbolTable
```

Here is the evolution of the `SymbolTable` during the call to `buildSymbolTable sqrt2Ast`:

| Action                             | SymbolTable State                           | Explanation                                                   |
| ---------------------------------- | ------------------------------------------- | ------------------------------------------------------------- |
| Start visitMethod                  | [ {} ]                                      | Initial global scope.                                         |
| enterScope                         | [ {}, {} ]                                  | Enter sqrt2 scope. The head is the current scope.             |
| addSymbol "y" JInt                 | [ {"y": JInt}, {} ]                         | Add the parameter y to the method's scope.                    |
| Start visitStatement(ForStatement) | [ {"y": JInt}, {} ]                         |                                                               |
| enterScope                         | [ {}, {"y": JInt}, {}]                      | Enter the for loop's scope.                                   |
| Visit VarDecl "i"                  | [ {}, {"y": JInt}, {}]                      |                                                               |
| addSymbol "i" JInt                 | [ {"i": JInt}, {"y": JInt}, {} ]            | Add i to the loop's scope.                                    |
| Visit VarDecl "j"                  | [ {"i": JInt}, {"y": JInt}, {} ]            |                                                               |
| addSymbol "j" JInt                 | [ {"i": JInt, "j": JInt}, {"y": JInt}, {} ] | Add j to the loop's scope.                                    |
| Finish visiting ForStatement body  | [ {"i": JInt, "j": JInt}, {"y": JInt}, {} ] | The loop scope is still active.                               |
| exitScope                          | [ {"y": JInt}, {} ]                         | Exit the for loop. The loop's scope, with i and j, is popped. |
| Finish visiting Method body        | [ {"y": JInt}, {} ]                         |                                                               |
| exitScope                          | [ {} ]                                      | Exit the sqrt2 method. The method's scope is popped.          |
| End of Execution                   | [ {} ]                                      | The final state is the global scope.                          |

This trace clearly shows how the visitor pattern, combined with a `State` monad, correctly models the nested scoping rules of the language. At any point during the traversal, you could add a `lookupSymbol` function that checks for a symbol's existence by searching from the head of the list outwards, perfectly simulating how a compiler resolves variable names.

Your existing `SymbolTable.Types.Entry` is serving a completely different purpose than the `SymExpr` AST we’re introducing for symbolic execution. In short:

1. **Symbol Table (`Entry`)**
   
   - Holds *static* metadata about each identifier: its declared type, scope, maybe whether it’s a field vs. local, constant‐initializer info, etc.
   
   - You build it once when you parse/resolve the program, and it never changes during symbolic execution.

2. **Symbolic Expressions (`SymExpr`)**
   
   - Are a *dynamic* representation of the *value* of each variable as you “run” the program symbolically.
   
   - Form an AST for arithmetic (`x + 1`), Boolean tests (`y > 0`), conditionals (`ite b e1 e2`), and so on. You need that AST to
     
     - accumulate *path conditions* (`pc :: [SymExpr]`)
     
     - track each variable’s *symbolic* value in `env :: Map String SymExpr`
     
     - hand off to an SMT solver or to generate JML assertions.

---

### Why You Can’t Just Reuse `Entry`

- **`Entry` ≠ “expression”**  
  Your `Entry` type probably looks something like:
  
  ```hs
  data Entry = Entry
    { entryName :: String
    , entryType :: Type
    , entryInit :: Maybe Constant
    , … }
  ```
  
  It doesn’t let you build up the *shape* of a computation like “`x + 1`” or “`y * 2`.” That’s exactly what `SymExpr` is for.

- **Static vs. Dynamic**
  
  - The symbol table is initialized once and then only read from when you need, say, the declared type of `x`.
  
  - The `env` in your `SymState` is written to on *every* assignment during symbolic execution:
    
    ```hs
    execStmt (AssignStmt x e) = do
      se ← evalExpr e                     -- e.g. builds a `SymExpr`
      modify (λ s → s { env = Map.insert x se (env s) })
    ```
    
    Here you need a place to store a *Symbolic Expression*, not a static `Entry`.

- **Path Conditions & Solver Interaction**  
  You accumulate constraints in `pc :: [SymExpr]`, you call:
  
  ```hs
  checkSat :: [SymExpr] → IO Bool
  ```
  
  Neither your `Entry` type nor your symbol table has anything like a recursive AST or Boolean operators. A solver‐ready AST *is* `SymExpr`.

---

### How They Work Together

1. **Parse → SymbolTable**  
   Populate `Map String Entry` so you know each variable’s declared type, etc.

2. **Build CFG**  
   Use the symbol table to check that every identifier is declared, to get its type for arithmetic vs. Boolean context, etc.

3. **Symbolic Execution**
   
   - **`SymState`**
     
     ```hs
     data SymState = SymState
      { env :: Map String SymExpr  -- ← dynamic mapping to symbolic values
      , pc  :: [SymExpr]           -- ← path conditions
      }
     ```
   
   - **`Config`**  
     Holds your solver settings, loop‐unroll limits, logging flags, etc.

4. **From `Entry` to `SymExpr`**  
   When you see a variable use in the CFG, you look up its `Entry` *only* to check types or scopes, then you *read* its current `SymExpr` from `env` (defaulting to `SVar name` if not yet bound).

5. **Generating JML**  
   Once you’ve finished symbolic execution, you’ll have one or more `(SymState)`s representing feasible end‐states. You convert each `SymExpr` in the final `env` into a JML expression, and you conjoin the `pc` list into a `requires` clause.

---

**In short:**

- Keep your **static** symbol‐table (`Entry`) around for type‐checks, scopes, and initializers.

- Use a **separate** `SymExpr` AST to model the *values* of variables *as they change* during symbolic execution.

They’re orthogonal layers of your architecture, and both are indispensable.

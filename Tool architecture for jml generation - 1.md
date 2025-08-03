Here’s a high-level architecture and roadmap for moving from parser/CFG/symbol-table to full JML-generation, along with concrete next steps you can start implementing today.

---

## 1. Overall Pipeline & Module Breakdown

1. **AST & CFG**  
   You’ve already got
   
   - **Parser** → `Parser.Types`
   
   - **SymbolTable** → `SymbolTable.Creator`
   
   - **CFG** → (your own module)

2. **Symbolic Execution Engine**
   
   - **Symbolic State**: an environment mapping each variable (or SSA name) to a symbolic expression, plus a *path condition* (a conjunction of boolean constraints).
   
   - **Monadic Interpreter**: traverse the CFG, updating the symbolic state in each basic block, forking the state on branches.

3. **Constraint Solver / Invariant Generator**
   
   - Integrate an SMT backend (e.g. SBV/Z3 via `sbv` or `language-smt2`)
   
   - Use it to:
     
     - Check feasibility of each path (prune infeasible branches)
     
     - Propose loop‐invariants (via template‐based or abstract‐interpretation domains, e.g. intervals)

4. **JML AST & Pretty-Printer**
   
   - Define a small ADT for JML clauses:
     
     ```hs
     data JMLExpr    = JVar String | JNum Int | JBin Op JMLExpr JMLExpr | …
     data JMLClause  = Requires JMLExpr
                    | Ensures  JMLExpr
                    | Signals  String JMLExpr   -- exception + condition
                    | Assignable [String]
                    | LoopInvariant JMLExpr
     data JMLMethod  = JMLMethod
      { jmName       :: String
      , jmParams     :: [(String,Type)]
      , jmClauses    :: [JMLClause]
      , jmBody       :: Maybe String   -- stub or inline
      }
     ```
   
   - Write a pretty‐printer that emits:
     
     ```java
     /*@ requires 0 <= x && x <= 10;
        ensures  \result >= x;
        signals (Exception e) i != 0;
        assignable \nothing;
     @*/
     public int foo(int x) { … }
     ```

5. **Test Harness & Regression**
   
   - Leverage your `Testing.txt` examples as regression tests: feed methods through the pipeline and assert the generated JML matches expected.

---

## 2. Detailed Next Steps

1. **Design the Symbolic‐State Monad**
   
   - Use a transformer stack, e.g.:
     
     ```hs
     type SymExec a =
      ReaderT  Config                 -- solver endpoints, thresholds…
     ( StateT   SymState               -- env :: Map Var SymExpr; pc :: [SymExpr]
     ( LogicT   IO                ))  -- non-det forks for branches
     ```
   
   - **`SymState`** holds:
     
     ```hs
     data SymState = SymState
      { env :: Map String SymExpr
      , pc  :: [SymExpr]
      }
     ```

2. **Implement CFG Traversal & Statement Handlers**
   
   - For each basic block, write handlers:
     
     ```hs
     execStmt :: Statement -> SymExec ()
     execStmt (AssignStmt x e) = do
      se <- evalExpr e
      modify (\s -> s { env = Map.insert x se (env s) })
     execStmt (CondStmt c t e) = fork
      [ do assume c  >>= execBlock t
      , do assume (¬c) >>= execBlock e ]
     ```
   
   - **`fork`** runs each branch in its own `LogicT` branch; collect resulting `SymState`s.

3. **Hook Up an SMT Solver**
   
   - Start with a stub that always returns “satisfiable.” Later replace with calls to SBV:
     
     ```hs
     checkSat :: [SymExpr] -> IO Bool
     ```
   
   - Use it inside your interpreter to prune infeasible paths.

4. **Loop Invariant Extraction**
   
   - **Simplest approach**: record all path‐conditions at loop head over several unrollings (e.g. 1–2 iterations), then compute their conjunction/disjunction.
   
   - **Better**: plug in an abstract‐interpretation library (e.g. [AERN2 intervals](https://hackage.haskell.org/package/AERN2)) to compute invariants automatically.

5. **JML AST & Generator**
   
   - Define your JML ADT (above) in e.g. `JML.Types`.
   
   - Write a module `JML.Pretty` that converts your `JMLMethod` to a String.

6. **End-to-End Smoke Test**
   
   - Wire everything in a driver:
     
     ```hs
     analyzeMethod :: AST.Method -> IO JMLMethod
     analyzeMethod m = do
      let cfg = buildCFG m
      stPaths <- runSymbolic cfg initialState
      contracts <- inferContracts stPaths
      pure $ toJML m contracts
     ```
   
   - Print out the resulting JML to the console for your `boo21`, `boo22_2`, etc.

---

## 3. Haskell-Service Conventions

- **Use ADTs & Typeclasses** extensively:
  
  - `ASTVisitor` → extend to `SymbolicVisitor`
  
  - `Pretty` typeclass for JML printing

- **Leverage Recursion-Schemes** (`cata`, `para`) to traverse both AST and CFG uniformly.

- **Modularize** by capability:
  
  - `Parser.*`
  
  - `SymbolTable.*`
  
  - `CFG.*`
  
  - `SymExec.*`
  
  - `JML.*`

- **Testing** with `hspec` or `tasty`, using your existing `Testing.txt` cases as golden files.

---

### Immediate “What to Code Tomorrow”

1. **Create `SymExpr` & `SymState`** in a new module `SymExec.Types`.

2. **Stub out** the monadic stack in `SymExec.Monad`, with no-op handlers.

3. **Write a test** that runs a single assignment through `execStmt` and checks that `env` is updated.

4. **Wire `CFG`-to-`SymExec`**: build a tiny function that folds `execStmt` over one basic block.

Once that’s in place, you’ll have the skeleton on which to build path‐splitting, solver calls, and—ultimately—the JML inference.

```haskell
data JMLExpr    = JVar String | JNum Int | JBin Op JMLExpr JMLExpr
                deriving Show
data JMLClause  = Requires JMLExpr
                | Ensures  JMLExpr
                | Signals  String JMLExpr   -- exception + condition
                | Assignable [String]
                | LoopInvariant JMLExpr
                deriving Show
data JMLMethod  = JMLMethod
  { jmName       :: String
  , jmParams     :: [(String,Type)]
  , jmClauses    :: [JMLClause]
  , jmBody       :: Maybe String   -- stub or inline
  }
```

---

### Question: Give me examples of this ADT for the method:

```java
public int boo35(int a, int b) {
  int x=a+b;
  int y=a*b;
  while (y>a+b) {
    a=a+1;
    x=a+b;
  }
  return x;
}
```

---

Here’s an example of how you might represent the full JML‐AST for `boo35` in Haskell, using the ADTs we sketched:

```hs
-- | A tiny enum for binary operators in JML
data JOp = JAdd | JSub | JMul | JDiv | JGt | JGe | JLt | JLe | JEq | JNe
  deriving (Eq,Show)

-- | JML expressions
data JMLExpr
  = JVar String
  | JNum Int
  | JBin JOp JMLExpr JMLExpr
  | JOld JMLExpr
  deriving (Eq,Show)

-- | JML clauses
data JMLClause
  = Requires     JMLExpr
  | Ensures      JMLExpr
  | LoopInvariant JMLExpr
  | Assignable   [String]
  deriving (Eq,Show)

-- | A JML‐annotated method
data JMLMethod = JMLMethod
  { jmName    :: String
  , jmParams  :: [(String,String)]    -- name and its Java type
  , jmClauses :: [JMLClause]
  , jmBody    :: Maybe String         -- you can keep a stub or omit
  }
  deriving (Eq,Show)


-- | The JML‐AST for boo35:
boo35JML :: JMLMethod
boo35JML = JMLMethod
  { jmName   = "boo35"
  , jmParams = [("a","int"), ("b","int")]
  , jmClauses =
      [ -- 1) Precondition: we need y = a*b > a+b before entering the loop
        Requires
          ( JBin JGt
              (JBin JMul (JVar "a") (JVar "b"))
              (JBin JAdd (JVar "a") (JVar "b"))
          )

        -- 2) Loop invariant: at every iteration, y > a + b
      , LoopInvariant
          ( JBin JGt
              (JVar "y")
              (JBin JAdd (JVar "a") (JVar "b"))
          )

        -- 3) Postcondition: result equals final x
      , Ensures
          ( JBin JEq
              (JVar "\\result")
              (JVar "x")
          )

        -- 4) Frame: this method only assigns to locals a, x, y
      , Assignable ["a","x","y"]
      ]
  , jmBody   = Nothing
  }
```

**Breakdown of the clauses:**

- **`Requires (a*b > a+b)`** captures the fact that before the first loop‐check we’ve already executed
  
  ```java
  int y = a*b;
  ```
  
  so the loop guard `y > a+b` becomes your precondition.

- **`LoopInvariant (y > a+b)`** expresses exactly the same relation at the head of *every* iteration.

- **`Ensures (\result == x)`** states that whatever `x` ends up being (after the final iteration) is the method’s return value.

- **`Assignable ["a","x","y"]`** says these are the only variables that the method writes to.

You’d feed this `JMLMethod` into your pretty‐printer to get:

```java
/*@ 
  requires a * b > a + b;
  loop_invariant y > a + b;
  ensures \result == x;
  assignable a, x, y;
@*/
public int boo35(int a, int b) { … }
```

---

### Question: What is the point of `jmBody`?

The `jmBody :: Maybe String` field is simply there to let you attach the actual Java source (or a stub) to your JML-annotated AST if you want to generate a complete file, rather than just a stand-alone contract. In practice you have two common uses:

1. **`Nothing`**  
   You’re only interested in emitting the JML spec (e.g. for documentation, verification inputs, or to insert into existing code manually). Your pretty-printer will then spit out just the `/*@ … @*/` block and signature, omitting the body entirely.

2. **`Just bodySrc`**  
   You supply the original method body (or a simplified stub) as a `String`. When you pretty-print your `JMLMethod`, it can tuck that source back into the generated `.java` file:
   
   ```java
   /*@ requires …; ensures …; @*/
   public int foo(int a) {
    // original or transformed body…
   }
   ```

Having `jmBody` as a `Maybe` gives you the flexibility to generate either:

- **Pure spec files**, or

- **Full code** with inline specs

without changing your AST or printer logic.

---

### Question: What would jmBody be for boo35?

For `boo35`, you can tuck the original method body (everything between the `{ … }`) into `jmBody`. For example:

```hs
boo35JML :: JMLMethod
boo35JML = JMLMethod
  { jmName    = "boo35"
  , jmParams  = [("a","int"),("b","int")]
  , jmClauses = [ … your clauses … ]
  , jmBody    = Just $ unlines
      [ "int x = a + b;"
      , "int y = a * b;"
      , "while (y > a + b) {"
      , "  a = a + 1;"
      , "  x = a + b;"
      , "}"
      , "return x;"
      ]
  }
```

Here, `jmBody` carries precisely the lines

```java
int x = a + b;
int y = a * b;
while (y > a + b) {
  a = a + 1;
  x = a + b;
}
return x;
```

so that your pretty-printer can emit a complete, JML-annotated method with its original implementation inline.

---

### Question: Show me ADT of this following method:

```java
public static int sqrt(int y) throws Exception{
  for(int i=0; i<=y; i=i+1){
    int j = i*i;
    if(j==y){
      return i;
    }
    else{
      if(i==y){
    throw new Exception("not found");
      }
      else{}
    }
  }
}
```

```haskell
-- Assuming your ADTs are defined as:
-- data JOp       = JAdd|JSub|JMul|JDiv|JGt|JGe|JLt|JLe|JEq|JNe
-- data JMLExpr   = JVar String | JNum Int | JBin JOp JMLExpr JMLExpr | JNot JMLExpr | JOld JMLExpr
-- data JMLClause = Requires JMLExpr
--                | Ensures JMLExpr
--                | LoopInvariant JMLExpr
--                | Signals String JMLExpr
--                | Assignable [String]
-- data JMLMethod = JMLMethod
--                { jmName    :: String
--                , jmParams  :: [(String,String)]
--                , jmClauses :: [JMLClause]
--                , jmBody    :: Maybe String
--                }

sqrtJML :: JMLMethod
sqrtJML = JMLMethod
  { jmName   = "sqrt"
  , jmParams = [("y","int")]
  , jmClauses =
      [ -- precondition: input must be non-negative
        Requires
          ( JBin JGe (JVar "y") (JNum 0) )

        -- loop invariant: at each iteration, i*i ≤ y
      , LoopInvariant
          ( JBin JLe
              (JBin JMul (JVar "i") (JVar "i"))
              (JVar "y")
          )

        -- normal postcondition: result^2 == y
      , Ensures
          ( JBin JEq
              (JBin JMul (JVar "\\result") (JVar "\\result"))
              (JVar "y")
          )

        -- exception clause: if no i satisfies i*i == y, we throw
      , Signals
          "Exception"
          ( JNot
              ( JBin JEq
                  (JBin JMul (JVar "i") (JVar "i"))
                  (JVar "y")
              )
          )

        -- no heap writes (only locals)
      , Assignable []
      ]
  , jmBody = Just $ unlines
      [ "for (int i = 0; i <= y; i = i + 1) {"
      , "  int j = i * i;"
      , "  if (j == y) {"
      , "    return i;"
      , "  } else {"
      , "    if (i == y) {"
      , "      throw new Exception(\"not found\");"
      , "    } else { }"
      , "  }"
      , "}"
      ]
  }
```

---

### Question: Explain every operator:

```haskell
data JOp = JAdd | JSub | JMul | JDiv | JGt | JGe | JLt | JLe | JEq | JNe
```

Each constructor of the `JOp` type corresponds to one of Java’s (and JML’s) binary arithmetic or relational operators. Here’s what each one means:

- **`JAdd`**  
  Represents the infix **`+`** operator.
  
  ```haskell
  JBin JAdd e1 e2  ≡  e1 + e2
  ```
  
  Used for integer (or real) addition.

- **`JSub`**  
  Represents the infix **`-`** operator.
  
  ```haskell
  JBin JSub e1 e2  ≡  e1 - e2
  ```
  
  Subtraction.

- **`JMul`**  
  Represents the infix **`*`** operator.
  
  ```haskell
  JBin JMul e1 e2  ≡  e1 * e2
  ```
  
  Multiplication.

- **`JDiv`**  
  Represents the infix **`/`** operator.
  
  ```haskell
  JBin JDiv e1 e2  ≡  e1 / e2
  ```
  
  Integer (or real) division.

---

- **`JGt`**  
  Represents the relational **`>`** operator.
  
  ```haskell
  JBin JGt  e1 e2  ≡  e1 > e2
  ```
  
  True when the left operand is strictly greater than the right.

- **`JGe`**  
  Represents the relational **`>=`** operator.
  
  ```haskell
  JBin JGe  e1 e2  ≡  e1 >= e2
  ```
  
  True when the left operand is greater than or equal to the right.

- **`JLt`**  
  Represents the relational **`<`** operator.
  
  ```haskell
  JBin JLt  e1 e2  ≡  e1 < e2
  ```
  
  True when the left operand is strictly less than the right.

- **`JLe`**  
  Represents the relational **`<=`** operator.
  
  ```haskell
  JBin JLe  e1 e2  ≡  e1 <= e2
  ```
  
  True when the left operand is less than or equal to the right.

---

- **`JEq`**  
  Represents the equality test **`==`**.
  
  ```haskell
  JBin JEq  e1 e2  ≡  e1 == e2
  ```
  
  True when both sides are equal.

- **`JNe`**  
  Represents the inequality test **`!=`**.
  
  ```haskell
  JBin JNe  e1 e2  ≡  e1 != e2
  ```
  
  True when the two sides are not equal.

---

#### How they’re used in your `JMLExpr` AST

```hs
data JMLExpr
  = JVar String
  | JNum Int
  | JBin JOp JMLExpr JMLExpr
  | JNot JMLExpr
  | JOld JMLExpr
  …
```

So for example:

- `JBin JAdd (JVar "x") (JNum 1)` ↦ the expression `x + 1`

- `JBin JGt (JVar "y") (JBin JAdd (JVar "a") (JVar "b"))` ↦ `y > a + b`

- `JBin JEq (JVar "\\result") (JNum 0)` ↦ `\result == 0`

Each `JOp` is just a tag that your pretty‐printer will render back into the corresponding Java/JML operator.

---

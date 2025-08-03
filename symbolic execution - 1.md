On entry to `boo35`, we have two parameters in scope:

```java
public int boo35(int a, int b) {
  int x = a + b;
  int y = a * b;
  while (y > a + b) {
    a = a + 1;
    x = a + b;
  }
  return x;
}
```

---

### 1. Method entry: initial bindings

```haskell
env₀ =
 { "a" ↦ SVar "a₀"
 , "b" ↦ SVar "b₀"
 }
```

---

### 2. First assignments (`x = a + b`, `y = a * b`)

We evaluate `a + b` and `a * b` in the current state:

```haskell
-- after x = a + b
let e₁ = SBin Add (SVar "a₀") (SVar "b₀")
env₁ = env₀ ∪ { "x" ↦ e₁ }

-- after y = a * b
let e₂ = SBin Mul (SVar "a₀") (SVar "b₀")
env₂ = env₁ ∪ { "y" ↦ e₂ }
```

No new lexical scopes here, just two new locals added to the same method‐level `env`.

---

### 3. Entering the `while` loop

When we see `while (y > a + b)`, we:

1. **Compute the loop‐condition**:
   
   ```haskell
   cond = SBin Gt (SVar "y") (SBin Add (SVar "a₀") (SVar "b₀"))
   ```

2. **Fork** on `cond` vs. `¬cond`, but let’s follow the **true** branch. We record the path‐condition:
   
   ```haskell
   pc₁ = [cond]
   ```

`env₂` remains as before when entering the body.

---

### 4. Body of the loop: updating `a` and `x`

Inside the loop body we see two assignments:

1. **`a = a + 1`**  
   We take the *current* `SymExpr` for `"a"` (initially `SVar "a₀"`), add 1, and **re‐bind** `"a"` to a *fresh* symbol or direct expression:
   
   ```haskell
   -- old a₀
   let a₁ = SBin Add (SVar "a₀") (SInt 1)
   env₃ = env₂ ⊕ { "a" ↦ a₁ }  -- shadow the old a₀ binding
   ```

2. **`x = a + b`** (now using the *updated* `a`):
   
   ```haskell
   let e₃ = SBin Add a₁ (SVar "b₀")
   env₄ = env₃ ⊕ { "x" ↦ e₃ }
   ```

Because we generate fresh SSA names (`a₁`) or at least fresh `SymExpr` values, there’s no confusion between the old and new “`a`.” If we had used *lexical* shadowing (e.g. a new block that declared `int a;`), we’d simply push a new `"a"` binding on entry and pop it on exit, restoring the outer one.

---

### 5. Loop exit and return

When the loop condition finally fails, we drop out with some final `env` and `pc`:

```haskell
-- say after n iterations:
env_final =
  { "a" ↦ aₙ              -- the n-th symbolic a
  , "b" ↦ SVar "b₀"
  , "x" ↦ SBin Add aₙ (SVar "b₀")
  , "y" ↦ SBin Mul (SVar "a₀") (SVar "b₀")
  }

pc_final = [cond₀, cond₁, …, condₙ₋₁]
```

and then `return x` simply picks `env_final !"x"` as the post‐state symbolic result.

---

### Key takeaways

- **One single `env :: Map String SymExpr`** carries the *current* symbolic value for each name in scope.

- **Entering a new block** (or encountering a shadowing declaration) means pushing a new binding; **exiting** means popping it.

- **Every assignment** (including to parameters like `a`) updates the same map, but because we build fresh `SymExpr`s (or SSA names) we never confuse old vs. new values.

- **Path‐conditions (`pc`)** accumulate the conditions under which each execution state is feasible.

By managing your environment this way, `SymExpr` cleanly handles arbitrary nesting, shadowing, and parameter rebinding, with no separate “scope” mechanism needed beyond simple map‐push/pop semantics.

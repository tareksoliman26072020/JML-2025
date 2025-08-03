What is the type variable `a` for? It is not used withing SymExec

The extra type parameter `a` in

```hs
type SymExec a =
     ReaderT Config
   ( StateT  SymState
   ( LogicT  IO     ))
   a
```

is simply the *return type* of your monadic computation. Think of it this way:

- `ReaderT r m a` is a function `r -> m a`

- `StateT s m a` is a function `s -> m (a, s)`

- `LogicT m a` is a nondeterministic computation producing values of type `a`

When you stack them together, you get a monad in which every action ultimately produces an `a`. Even if today all of your `SymExec` actions return `()`, you still need that `a` there so that the underlying transformers know what they’re returning.

In practice:

```hs
-- If you only ever care about effects and don’t need to return anything, your
-- stmt‐executor can have type:
execStmt :: Statement -> SymExec ()
```

but the monad itself remains `SymExec a`, so you can later write things like:

```hs
-- maybe you want to return the final symbolic expression of a return-stmt:
execStmt (ReturnStmt e) :: SymExec SymExpr
```

If you really want to hide that parameter, you could define

```hs
type SymExec_   = SymExec ()
```

and use `SymExec_` for all your unit‐returning pieces—but under the hood the `a` is just the usual “what does this action yield” type of any monad.

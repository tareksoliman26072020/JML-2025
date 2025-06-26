```java
int example2(int a, int b) {
  // d1:
  int x=a+b;
  // d2:
  int y=a*b;
  // N3: the test
  while (y>a+b) {
    // d3:
    a=a+1;
    // d4:
    x=a+b;
  }
  return x;
}
```

## 1. Labelled definitions

- **d1**: `x = a + b` (at N1)

- **d2**: `y = a * b` (at N2)

- **d3**: `a = a + 1` (at N4)

- **d4**: `x = a + b` (at N5)

(Return has no definitions.)

## 2. CFG (one node per statement)

```yaml
    Entry
      │
      ▼
   N1: d1: x = a + b
      │
      ▼
   N2: d2: y = a * b
      │
      ▼
   N3: while (y > a + b)? ──┬──true──▶ N4
      │                     │          d3: a = a + 1
      │                     │          │
      │                     │          ▼
      └─────false───────────┘          N5
              │                        d4: x = a + b
              ▼                         │
         N6: return x                   └───┐
                                            ▼
                                          N3 (back)
```

## 3. GEN / KILL sets

For each node Nᵢ:

| Node | Stmt                    | GEN  | KILL |
| ---- | ----------------------- | ---- | ---- |
| N1   | `x = a + b`             | {d1} | {d4} |
| N2   | `y = a * b`             | {d2} | ∅    |
| N3   | `while (y > a + b)`     | ∅    | ∅    |
| N4   | `a = a + 1`             | {d3} | ∅¹   |
| N5   | `x = a + b` (loop body) | {d4} | {d1} |
| N6   | `return x`              | ∅    | ∅    |

> ¹ We’re only tracking definitions of local variables `x,y,a`; no earlier `a=` in this method.

## 4. Data‐flow equations

- **IN(N)** = ⋃ OUT(P) for all predecessors P of N

- **OUT(N)** = GEN(N) ∪ (IN(N) – KILL(N))

Initialize **IN(N1)=∅**, then iterate until fixed‐point:

| Node | Preds      | IN(N)                                | OUT(N)                         |
| ---- | ---------- | ------------------------------------ | ------------------------------ |
| N1   | Entry      | ∅                                    | {d1}                           |
| N2   | N1         | {d1}                                 | {d2} ∪ ({d1}–∅) = {d1, d2}     |
| N3   | N2, N5     | {d1,d2} ∪ {d2,d3,d4} = {d1,d2,d3,d4} | ∅ ∪ ({…}–∅) = {d1,d2,d3,d4}    |
| N4   | N3 (true)  | {d1,d2,d3,d4}                        | {d3} ∪ ({…}–∅) = {d1,d2,d3,d4} |
| N5   | N4         | {d1,d2,d3,d4}                        | {d4} ∪ ({…}–{d1}) = {d2,d3,d4} |
| N6   | N3 (false) | {d1,d2,d3,d4}                        | ∅ ∪ ({…}–∅) = {d1,d2,d3,d4}    |

> After one pass of the loop back, IN(N3) stabilizes at `{d1,d2,d3,d4}`, and all OUT sets reach fixed‐point.

## 5. Interpretation

- **At the loop‐test (N3)**, `y` always comes from **d2**, while `a` may be from **d3** (if the loop already ran) or the original parameter (not tracked) for the right‐hand side `a + b`.

- **Inside the loop body**:
  
  - Before `a = a+1` (N4), definitions of `a` reaching in are `{d3}` (after the first iteration) or none (on first iteration), but we conservatively say `{d3}` plus any earlier.
  
  - Before `x = a + b` (N5), both **d1** and **d4** can reach in, but KILL drops **d1**, so OUT(N5) = {d2,d3,d4}.

- **At the return (N6)**, the reaching‐definitions set is `{d1,d2,d3,d4}`:
  
  - For **x**, the only definitions in that set are **d1** (if the loop never ran) and **d4** (if the loop ran at least once).
  
  - So `return x;` may return either the initial `x = a+b` (d1) or the updated `x = a+b` inside the loop (d4).

This completes the reaching‐definitions analysis on the per‐statement CFG of `example2`.

# reaching definitions analysis

```java
void example(int x) {
  // d1:
  int a = 1;
  // d2:
  int b = 2;

  if (x > 0) {
    // d3:
    a = b + x;
  } else {
    // d4:
    b = a - x;
  }

  // d5:
  int c = a + b;
}
```

**1. Labelled definitions**

- **d1:** `a = 1`

- **d2:** `b = 2`

- **d3:** `a = b + x`

- **d4:** `b = a - x`

- **d5:** `c = a + b`

**2. Control-Flow Graph**

```yaml
   N1: d1: a = 1
      │
      ▼
   N2: d2: b = 2
      │
      ▼
   N3: if (x > 0)
     ┌┴─────────┐
    T│          │F
     ▼          ▼
   N4: d3       N5: d4
   a = b + x    b = a - x
     │          │
     └───┬──────┘
         ▼
   N6: d5: c = a + b
```

**3. GEN/KILL sets per node**  
For each node Nᵢ:

- **GEN(Nᵢ)** = the definition generated at that node

- **KILL(Nᵢ)** = all other definitions of the same variable

| Node | Statement    | GEN  | KILL |
| ---- | ------------ | ---- | ---- |
| N1   | `a = 1`      | {d1} | {d3} |
| N2   | `b = 2`      | {d2} | {d4} |
| N3   | `if (x > 0)` | ∅    | ∅    |
| N4   | `a = b + x`  | {d3} | {d1} |
| N5   | `b = a - x`  | {d4} | {d2} |
| N6   | `c = a + b`  | {d5} | ∅    |

**4. Data‐flow equations**

- **OUT(N)** = GEN(N) ∪ (IN(N) – KILL(N))

- **IN(N)** = ⋃ OUT(P) for all predecessors P of N

Start with **IN(N1) = ∅**, then iterate:

| Node | Preds  | IN(N)               | OUT(N)                                               |
| ---- | ------ | ------------------- | ---------------------------------------------------- |
| N1   | —      | ∅                   | {d1}                                                 |
| N2   | N1     | {d1}                | {d2} ∪ ({d1} – {d4}) = {d1, d2}                      |
| N3   | N2     | {d1, d2}            | ∅ ∪ ({d1, d2} – ∅) = {d1, d2}                        |
| N4   | N3 (T) | {d1, d2}            | {d3} ∪ ({d1, d2} – {d1}) = {d2, d3}                  |
| N5   | N3 (F) | {d1, d2}            | {d4} ∪ ({d1, d2} – {d2}) = {d1, d4}                  |
| N6   | N4, N5 | {d2, d3} ∪ {d1, d4} | {d5} ∪ ({d1, d2, d3, d4} – ∅) = {d1, d2, d3, d4, d5} |

**5. Interpretation**

- Just before **N6** (`c = a+b`),
  
  - **IN(N6)** = {d1, d2, d3, d4}.
  
  - So **a** may come from **d1** or **d3**, and **b** from **d2** or **d4**.

- Thus the computation of `c` sees both original and re‐defined values of **a** and **b**.

- After N6, **OUT(N6)** = {d1, d2, d3, d4, d5}, introducing definition **d5** of **c**.

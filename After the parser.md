After the parser:

1. ### **AST Traversal & Symbol Table Construction**
   
   1. **Traverse the AST** to collect declarations (classes, methods, variables).
   
   2. **Build symbol tables** to track scopes and bindings (this enables name resolution and type checking).
      
      1. _Techniques_: **Visitor Pattern**, **Scope Stack**

2. ### **Semantic Analysis**
   
   - **Type Checking** – validate expressions and assignments based on Java types.
   
   - **Name Resolution** – resolve identifiers to their declarations.
   
   - **Detect undeclared or shadowed variables**, wrong method signatures, etc.

3- ### **Control Flow Graph (CFG) Construction**

- **Build CFGs per method** to model the flow of control (branches, loops, exceptions).
  
  - Nodes = statements/expressions; Edges = possible execution paths.

- Required for most deeper analyses like data flow.

   ---

### **4. Data Flow Analysis (DFA)**

   Use the CFG to perform:

- **Reaching Definitions**

- **Live Variable Analysis**

- **Constant Propagation**

- **Null/Uninitialized Variable Analysis**
  
  These are forward or backward analyses on the CFG.

   ---

### **5. Call Graph Construction**

- **Static Call Graph** = who calls whom.

- Build interprocedural understanding of the program.
  
  - Use Class Hierarchy Analysis (CHA), Rapid Type Analysis (RTA), or more precise techniques.

   ---

### **6. Optional: Intermediate Representation (IR)**

- Convert code to IR like **three-address code** or **SSA** for easier analysis (Soot uses Jimple for this).

- Optional if your analysis can work directly on AST/CFG.

   ---

### **7. Advanced Analysis (Optional)**

- **Taint Analysis**

- **Escape Analysis**

- **Points-To Analysis**

- **Alias Analysis**

- **Symbolic Execution** or **Abstract Interpretation**

   ---

### **8. Reporting / Result Generation**

- Design a format (JSON, CLI output, GUI) for reporting:
  
  - Warnings, possible bugs, optimization suggestions, etc.

   ---

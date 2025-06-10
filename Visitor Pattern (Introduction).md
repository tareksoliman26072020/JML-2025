### **Visitor Pattern**:

Instead of adding analysis logic directly into the classes that define the AST nodes (which would clutter them and make them hard to maintain), the Visitor Pattern separates the analysis algorithms from the AST structure itself.

<u>The goal of VIsitor Pattern</u>:

1. The structure of the AST (the nodes) is completely decoupled from the analysis algorithms (the visitors). You can have a stable AST representation and then create numerous different visitors for various analyses (e.g., checking for null pointer exceptions, identifying unused variables, enforcing coding standards).
2. Adding a new type of analysis is as simple as creating a new visitor class. You don't need to modify the existing and potentially complex AST node classes.
3. The logic for a specific analysis is encapsulated within a single visitor class, making it easier to understand, test, and maintain. If you want to know how "if" statements are handled, you just look at the IfCounterVisitor.

**The goal of the accept() methods**:

1. marking nodes as 'visitable'
   * It takes a Visitor object as an argument. When accept() is called on a node, it turns around and calls a corresponding method on the Visitor

**The goal of the visit() methods**:

1. implement the counting logic
2. call accept() methods on the nested blocks & nodes



#### Practical Example

I want to count the number of if statements:

```java
public static int sqrt2(int y) throws Exception{
 for(int i=0; i<=y; i++){
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

The visitor:

```java
class IfCounterVisitor implements Visitor {
    int count = 0;

    // This gets called for IfStatement nodes
    @Override
    public void visit(IfStatementNode node) {
        this.count++; // Increment the counter!
        // Now, continue the traversal to find nested ifs
        node.getThenBlock().accept(this); // Visit the 'then' block
        if (node.getElseBlock() != null) {
            node.getElseBlock().accept(this); // Visit the 'else' block
        }
    }

    // This gets called for ForStatement nodes
    @Override
    public void visit(ForStatementNode node) {
        // We don't count 'for' loops, but we MUST visit its children
        // to find any 'if' statements inside.
        node.getBody().accept(this);
    }

    // This gets called for the top-level method node
    @Override
    public void visit(MethodDeclarationNode node) {
        // Just continue the traversal into the method's body
        node.getBody().accept(this);
    }

    // ... other visit methods for other node types (Return, VariableDeclaration, etc.)
    // These methods would simply call accept() on their children to continue the traversal.
}
```

**The AST Nodes (Visitable):**

Each node in the AST has an `accept` method that looks like this:

```java
// In the IfStatementNode class
public void accept(Visitor visitor) {
    visitor.visit(this); // 'this' is the IfStatementNode object
}

// In the ForStatementNode class
public void accept(Visitor visitor) {
    visitor.visit(this); // 'this' is the ForStatementNode object
}

// And so on for every other node type...
```

### The Recursive Traversal Step-by-Step

Here is how the execution flows when you want to count the `if` statements in the `sqrt2` method:

**Step 1: Start the Process**

You kick off the analysis by creating your visitor and calling `accept()` on the root of the tree, which is the `MethodDeclaration("sqrt2")` node.

```java
MethodDeclarationNode methodNode = ... // Get the root of the AST
IfCounterVisitor counterVisitor = new IfCounterVisitor();
methodNode.accept(counterVisitor); // START HERE
```

**Step 2: Visiting the Method**

1. `methodNode.accept(counterVisitor)` is called.
2. Inside this `accept` method, it immediately calls `counterVisitor.visit(methodNode)`.
3. The `visit(MethodDeclarationNode)` method in our `IfCounterVisitor` is executed. Its only job is to continue the traversal into the method's body. It does this by calling `accept` on its child, the `ForStatement` node.

**Step 3: Visiting the `for` loop**

1. `forStatementNode.accept(counterVisitor)` is called from within the visitor.
2. The `for` loop's `accept` method calls `counterVisitor.visit(forStatementNode)`.
3. The `visit(ForStatementNode)` method in our visitor runs. It doesn't increment the counter, but to find `if` statements *inside* the loop, it must continue the traversal. It does this by calling `accept` on its "body" child, which is a `BlockStatement` containing the loop's code.

**Step 4: Visiting the First `if` Statement**

1. The traversal continues down through the `BlockStatement` and the `VariableDeclaration("j = i*i")`. The visitor's methods for these nodes are called, and they simply pass the `accept` call down to their children.
2. Eventually, `ifStatementNode1.accept(counterVisitor)` is called.
3. The `if` statement's `accept` method calls `counterVisitor.visit(ifStatementNode1)`.
4. **AHA!** The `visit(IfStatementNode)` method in our visitor is executed.
   - **`this.count++` is executed. The counter is now 1.**
   - The `visit` method then recursively calls `accept()` on its children to find any nested `if`s. It would call `accept()` on the `ReturnStatement` (in the "then" block) and on the `BlockStatement` (in the "else" block).

**Step 5: Visiting the Second (Nested) `if` Statement**

1. The call to `accept()` on the "else" `BlockStatement` from the previous step continues the traversal downwards.
2. Eventually, `ifStatementNode2.accept(counterVisitor)` is called.
3. The nested `if` statement's `accept` method calls `counterVisitor.visit(ifStatementNode2)`.
4. **AHA again!** The `visit(IfStatementNode)` method is executed for the second time.
   - **`this.count++` is executed. The counter is now 2.**
   - The `visit` method again continues the traversal, calling `accept()` on its "then" child (`ThrowStatement`) and its "else" child (`EmptyStatement`).

**Step 6: Finishing Up**

The traversal continues until all nodes in the method's AST have been visited. Since there are no more `if` statements, the counter remains at 2. Once the initial `methodNode.accept(counterVisitor)` call returns, you can inspect the visitor's state to get the final result.

```java
// ...after the call returns
System.out.println("Found " + counterVisitor.count + " if statements."); // Prints "Found 2 if statements."

```

### Summary of the Recursion

The recursion is a double-dispatch mechanism:

1. **`node.accept(visitor)`:** The node says, "Hey visitor, I am a `[NodeType]` node. Do your thing with me."
2. **`visitor.visit(node)`:** The visitor's logic for that specific `NodeType` runs. A crucial part of this logic is to **continue the traversal** by calling `child.accept(visitor)` for all relevant children of the current node.

This is how the entire tree is walked. The `accept()` calls pass control to the visitor, and the `visit()` methods implement the actual logic **and** drive the recursion deeper into the tree by making further `accept()` calls.

---

#### Re-writing the visitor in Haskell:

Excellent question. Implementing the Visitor pattern in Haskell is quite different from Java. Haskell's functional nature and powerful type system, particularly type classes, allow for a more idiomatic and often more elegant solution than the classic object-oriented pattern.

You don't typically use an `accept` method. Instead, you define the "visitable" behavior using a **type class**. The core idea of separating the data structure (AST) from the operations (analysis) remains the same.

Let's re-implement the `if`-statement counting example for your `sqrt2` method in Haskell.

1. Define the AST Data Types
   
   First, we need to define the data types that represent our Abstract Syntax Tree. This is analogous to the AST node classes in Java.
   
   ```haskell
   -- Expressions in our simplified language
   data Expression
     = Var String
     | Val Int
     | BinOp String Expression Expression -- e.g., "i*i", "j==y"
     | UnaryOp String Expression       -- e.g., "i++"
     deriving (Show)
   
   -- Statements in our simplified language
   data Statement
     = VarDecl String Expression                 -- e.g., "int j = i*i;"
     | ReturnStatement Expression
     | ThrowStatement String
     | EmptyStatement
     | IfStatement Expression Statement Statement -- The 'if' node with then and else blocks
     | ForStatement Statement Expression Expression [Statement] -- Init, Cond, Update, Body
     | Block [Statement]                         -- A sequence of statements, like in a method body or else block
     deriving (Show)
   
   -- The top-level method declaration
   data Method = MethodDeclaration String [Statement] -- Name and body
     deriving (Show)
   ```

2. Define the Visitor using a Type Class
   
   In Haskell, the "Visitor" itself is best represented as a type class. This defines a contract for what any visitor must be able to do. Each function in the type class corresponds to a `visit` method for a specific AST node.
   
   This approach allows you to define different visitors by creating different instances of this type class.
   
   ```haskell
   {-# LANGUAGE FlexibleInstances #-} -- An extension often useful for this pattern
   
   -- The Visitor type class defines an operation for each AST node type.
   -- The 'v' is the type of our visitor (e.g., our counter state).
   -- We return 'v' to allow the visitor's state to be updated.
   class AstVisitor v where
     visitMethod :: v -> Method -> v
     visitStatement :: v -> Statement -> v
     visitExpression :: v -> Expression -> v
   
   -- Default implementations: most visitors only care about a few node types.
   -- By default, a visitor does nothing but continue the traversal.
   instance AstVisitor v where
     visitMethod v (MethodDeclaration _ body) = visitBlock v body
     visitStatement v stmt = case stmt of
       VarDecl _ expr       -> visitExpression v expr
       ReturnStatement expr -> visitExpression v expr
       ThrowStatement _     -> v -- No children to visit
       EmptyStatement       -> v -- No children to visit
       IfStatement cond thenS elseS ->
         let v'   = visitExpression v cond
             v''  = visitStatement v' thenS
         in visitStatement v'' elseS
       ForStatement initS cond updateS body ->
         let v'   = visitStatement v initS
             v''  = visitExpression v' cond
             v''' = visitExpression v'' updateS
         in visitBlock v''' body
       Block stmts -> visitBlock v stmts
     visitExpression v _ = v -- By default, do nothing for expressions
   
   -- Helper to visit a list of statements (a block)
   visitBlock :: AstVisitor v => v -> [Statement] -> v
   visitBlock = foldl visitStatement
   ```
   
       **Explanation:**
   
   - `AstVisitor v`: This defines a set of operations (`visitMethod`, `visitStatement`, etc.) that can be performed by any type `v` that we decide is a visitor.
   - **Default Instance:** The `instance AstVisitor v where ...` provides a default traversal logic. For any given node, it automatically calls the correct visitor function for its children. This is the magic that replaces the recursive `accept` calls. A specific visitor only needs to override the functions for the nodes it actually cares about.

3. Create a Concrete Visitor (The `If` Counter)
   
   Now we create our specific visitor for counting `if` statements. In Haskell, this will be a new data type to hold the state (the count) and an instance declaration for our `AstVisitor` type class.
   
   ```haskell
   -- Our concrete visitor's state: just an integer for the count.
   newtype IfCounter = IfCounter { getCount :: Int }
   
   -- Make IfCounter an instance of our AstVisitor type class.
   -- We only need to override the behavior for the node we care about: IfStatement.
   instance AstVisitor IfCounter where
     visitStatement counter@(IfCounter n) stmt = case stmt of
       IfStatement cond thenS elseS ->
         let -- 1. Increment the counter for the 'if' statement itself.
             counter' = IfCounter (n + 1)
             -- 2. Continue the default traversal to find nested ifs.
             -- We call the default 'visitStatement' by explicitly typing the
             -- result of the recursive call.
             continue_traversal = visitStatement counter' stmt
         in continue_traversal
       -- For all other statement types, do the default thing (just traverse).
       _ -> visitStatement counter stmt
   ```
   
   **Explanation***:
   
   1. `newtype IfCounter = IfCounter { getCount :: Int }`: This defines our visitor's state. It's a simple wrapper around an `Int`.
   
   2. `instance AstVisitor IfCounter where`: Here, we provide the specific logic for` IfCounter`.
   
   3. `visitStatement counter@(IfCounter n) stmt = case stmt of ...`: We only define a special case for `IfStatement`.
   
   4. `let counter' = IfCounter (n + 1)`: This is our counting logic! We create a new counter with an incremented value.
   
   5. `continue_traversal = visitStatement counter' stmt`: **This is the crucial recursive part.** We call the *default* `visitStatement` function with our *new* counter state. The default function will handle traversing into the `then` and `else` blocks, ensuring that nested `if`s are found and counted.
   
   6. `_ -> visitStatement counter stmt`: For any other type of statement, we do nothing special and just fall back to the default traversal logic.

4. Running the Analysis
   
   Finally, let's create a sample AST for your `sqrt2` method and run our `IfCounter` on it.
   
   ```haskell
   -- A simplified AST for the sqrt2 method
   sqrt2Ast :: Method
   sqrt2Ast = MethodDeclaration "sqrt2"
     [ ForStatement
         (VarDecl "i" (Val 0))
         (BinOp "<=" (Var "i") (Var "y"))
         (UnaryOp "++" (Var "i"))
         [ VarDecl "j" (BinOp "*" (Var "i") (Var "i"))
         , IfStatement (BinOp "==" (Var "j") (Var "y"))
             (ReturnStatement (Var "i"))
             (Block
               [ IfStatement (BinOp "==" (Var "i") (Var "y"))
                   (ThrowStatement "not found")
                   EmptyStatement
               ]
             )
         ]
     ]
   
   -- The main function to run the analysis
   main :: IO ()
   main = do
     let initialVisitor = IfCounter 0
         finalVisitor = visitMethod initialVisitor sqrt2Ast
     putStrLn $ "Found " ++ show (getCount finalVisitor) ++ " if statements."
   
   -- Running 'main' will produce the output:
   -- Found 2 if statements.
   ```

5. asd

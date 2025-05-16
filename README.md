
<img align="center" src="/public/logo.png">

# Jaspea - Joint Architecture for Simulation, Planning, Execution, and Autonomy

**Jaspea** (inspired by the precious stone Jasper) is a domain-specific language (DSL) designed to model, simulate, and visualize robotic systems using graph-based representations. Built with Haskell, Jaspea offers a clear and concise syntax to define components (sensors, actuators, controllers) and their interconnections, while supporting simulation and export to robotic frameworks such as ROS and Gazebo.

---

## 🎯 Goals

* **Model** robotic components (nodes: sensors, actuators, processors) and their communication channels (edges: data flow, control signals).
* **Simulate** message passing and signal propagation through the graph to validate system behavior.
* **Generate** artifacts for robotics frameworks (ROS launch files, Gazebo world configurations).
* **Export** models to industry-standard formats (Graphviz DOT, JSON, YAML).

---

## 🗃 Project Structure

```plaintext
jaspea/
├── app/
│   └── Main.hs            # Entry point: REPL and CLI driver
├── src/
│   ├── Lexer/             # Lexical analysis (alex)
│   │   └── Lexer.hs
│   ├── Parser/            # Syntax parsing (happy)
│   │   └── Parser.hs
│   ├── AST/               # Abstract Syntax Tree definitions
│   │   └── AST.hs
│   ├── Types/             # Static type system and type inference
│   │   └── Types.hs
│   ├── Semantics/         # Semantic analysis and graph consistency checks
│   │   └── Checker.hs
│   ├── Simulator/         # Discrete-event simulation engine
│   │   └── Simulator.hs
│   ├── Export/            # Generators for DOT, ROS, Gazebo
│   │   ├── ExportDot.hs
│   │   ├── ExportROS.hs
│   │   └── ExportGazebo.hs
│   ├── Graph/             # Graph rendering (SVG/PNG)
│   │   └── Render.hs
│   ├── REPL/              # Interactive Read-Eval-Print Loop
│   │   └── REPL.hs
│   └── Utils/             # Helper modules (monads, parsers)
│       └── Utils.hs
├── examples/              # Example Jaspea scripts for robotics
│   └── mobile_robot.jas
├── test/                  # Unit and integration tests
│   ├── LexerTest.hs
│   ├── ParserTest.hs
│   ├── SemanticsTest.hs
│   └── SimulatorTest.hs
├── docs/
│   ├── language_spec.md   # Detailed syntax and semantics specification
│   ├── architecture.md    # Software architecture overview
│   └── tutorial.md        # Quickstart tutorial
├── public/                
│   └── logo.png
├── README.md              # This document
├── LICENSE                # Project license
├── package.yaml                # Informations on the package
└── stack.yaml             # Haskell Stack configuration
```

---

## 📖 Language Specification

### 1. Lexical Elements

* **Keywords**: `node`, `edge`, `property`, `simulate`, `export`, `ros`, `gazebo`, `if`, `else`, `let`, `in`
* **Identifiers**: letters (`A-Za-z`), digits, underscores
* **Literals**: integers (`42`), floats (`3.14`), strings (`"on"`, `"off"`), booleans (`true`, `false`)
* **Operators**: `->` (arrow), `=` (assignment), `:` (type annotation), `,` (separator)
* **Comments**: `// ...` for single-line, `/* ... */` for multi-line

### 2. Grammar (BNF)

```bnf
<program>       ::= { <statement> }
<statement>     ::= <nodeStmt> | <edgeStmt> | <propStmt> | <simulateStmt> | <exportStmt>
<nodeStmt>      ::= "node" <ident> ":" <typeIdent>
<edgeStmt>      ::= "edge" <ident> "->" <ident> ":" <label>
<propStmt>      ::= "property" <ident> ":" <propList>
<propList>      ::= <key> "=" <value> { "," <key> "=" <value> }
<simulateStmt>  ::= "simulate" "for" <number> "steps"
<exportStmt>    ::= "export" <format> <stringLiteral>

<ident>         ::= letter { letter | digit | '_' }
<typeIdent>     ::= ident
<label>         ::= ident
<key>           ::= ident
<value>         ::= integer | float | bool | stringLiteral
<format>        ::= "dot" | "ros" | "gazebo"
```

### 3. Semantics

1. **node**: Declares a typed graph node (e.g., sensor, actuator).
2. **edge**: Defines a directed edge with a label between nodes.
3. **property**: Attaches attributes (key-value pairs) to nodes.
4. **simulate**: Runs a discrete simulation of message propagation for the given number of steps.
5. **export**: Emits the model in the specified format.

**Semantic checks**:

* Every `edge` references existing `node` identifiers.
* Properties match the node type definitions.
* Optional cycle detection for invalid feedback loops.

---

## ⚙️ Compiler Architecture

1. **Lexer** (`alex`): Tokenizes source code into stream of tokens.
2. **Parser** (`happy`): Parses tokens into AST structures.
3. **AST**: Algebraic data types representing the Jaspea language constructs.
4. **Types & Checker**: Performs type inference and static validation.
5. **Simulator**: Implements a discrete-event engine to simulate graph behavior.
6. **Exporters**: Modules to generate Graphviz DOT, ROS launch scripts, and Gazebo world files.
7. **Renderer**: Produces visual diagrams (SVG/PNG) of the graph.
8. **REPL/CLI**: Interactive shell and command-line interface for batch processing.
9. **Tests**: Comprehensive suite using `HUnit` and `QuickCheck`.

**Monadic stack**:

* `Either Text` for lexical, syntactic, and semantic errors.
* `State GraphEnv` for maintaining model state (nodes, edges, properties).
* `Reader Config` for runtime options and paths.

---

## 🚀 Usage and Best Practices

1. **Installation**:

   ```bash
   git clone https://github.com/your-username/Jaspea.git
   cd Jaspea
   stack setup
   stack build
   ```

2. **Start REPL**:

   ```bash
   stack exec jaspea
   #>  
   node A : Sensor
   edge A -> B : Measures
   simulate for 10 steps
   export dot "model.dot"
   ```

3. **Run in batch mode**:

   ```bash
   stack exec jaspea -- run examples/mobile_robot.jas
   ```

4. **Example script** (`examples/mobile_robot.jas`):

   ```jaspea
   node Base : Controller
   node Lidar : Sensor
   node WheelFL : Actuator
   edge Base -> Lidar : RequestScan
   edge Lidar -> Base : ScanData
   edge Base -> WheelFL : DriveCommand
   simulate for 20 steps
   export ros "robot.launch"
   ```

5. **Testing**:

   ```bash
   stack test
   ```

6. **Contributing**:

   * Open issues for bugs and feature requests.
   * Submit pull requests with clear descriptions and tests.

---

**Jaspea** empowers roboticists to model, simulate, and deploy architectures in a unified, declarative framework. Happy graphing!

# Repository instructions for Codex: JML research, exposé, and Master's thesis

## 1. Purpose and scope

This repository supports a Computer Science research project on automated inference of Java Modeling Language (JML) specifications, especially loop invariants, for Java programs. Its scholarly outputs are an **exposé** (the research proposal and foundation) and a **Master's thesis** (the developed, evidence-based research report). The repository may also contain implementation code, test programs, annotated Java, experiment outputs, and notes.

Apply these instructions when working on any of those materials. Identify whether the current task concerns the exposé, thesis, implementation, benchmarks, or several of them; do not assume all are in the same directory or use a particular filename. Follow any more specific `AGENTS.md` instructions in subdirectories if they exist.

**Priority:** soundness and research integrity > demonstrated verifiability > factual precision > clarity and consistency > elegance and brevity. Do not sacrifice correctness to make a result, argument, or narrative look stronger.

## 2. Learn the actual project before editing

1. Inspect the relevant repository tree, current files, instructions, Git status, and existing LaTeX build setup. Determine the real main `.tex` file(s) and their inclusion structure rather than guessing.
2. Read the requested sections and their surrounding context; retain the project's terminology, definitions, notation, and authorial intent. Identify existing research questions, hypotheses, software architecture descriptions, citations, and claimed results.
3. Read `PLAN.md` if it exists in this checkout. It is guidance for JML reasoning, not evidence that an implementation feature works. Do not assume ChatGPT project files or conversations are accessible to Codex unless they have been supplied in this environment.
4. Follow university/supervisor instructions and official thesis templates where supplied. Flag conflicts between those requirements and these general instructions rather than silently overriding them.
5. For nontrivial, multi-file changes, form a short implementation plan; otherwise proceed with the bounded task without unnecessary questions. Do not change unrelated files.

### Evidence and authority

Distinguish among (a) source code and test evidence, (b) checked tool output, (c) reports and design notes, (d) proposals and planned features, and (e) your own inference. Do not upgrade a suggestion, sample annotation, or design report into an implemented or verified fact. When sources disagree, show the disagreement and specify what must be checked.

## 3. Exposé and thesis: one research trajectory, different claims

**Exposé:** A concise, credible proposal explaining the problem, motivation, research questions or objectives, relevant background and related work, intended approach/implementation, planned evaluation or benchmarks, feasibility, anticipated limitations, and provisional chapter structure. Clearly distinguish existing prototype capabilities from planned work. Describe expected results as hypotheses or evaluation goals, not completed findings. Do not manufacture experimental outcomes.

**Thesis:** The finished scholarly argument, built upon and permitted to revise the exposé as the research evolves. Clearly explain the actual problem and contribution, formal background, prior work, architecture and implementation, evaluation methodology, observed results, threats to validity, limitations, and conclusions supported by evidence. Report approaches that failed and negative findings when relevant. Distinguish the author's original contribution from reused code, published methods, tools, and established theory.

Maintain continuity between the exposé and thesis in terminology, research questions, methods, and scope when justified. **Do not mechanically copy proposal language into the thesis**: convert future-tense plans into past- or present-tense claims only after implementation and validation support them. If scope or methods change, document the change and its rationale instead of hiding it.

A plausible organization (not a mandatory template) is: Introduction and Motivation; Foundations/Background; Related Work; Research Approach and Implementation; Evaluation/Benchmark; Discussion and Limitations; Conclusion and Future Work. Use the actual university requirements and existing manuscript structure when present.

## 4. Academic integrity, evidence, and citations

- Never invent papers, authors, publication details, DOIs, quotations, URLs, citation keys, measurements, run logs, proof outcomes, or tool capabilities. Never imply you read a source that you did not access.
- For each nontrivial factual claim, determine whether it is established theory, a source-supported statement, a code observation, an experimental observation, an assumption, or an open question. Provide an appropriate citation or traceable project evidence where needed.
- Verify bibliography metadata against accessible sources when possible. Prefer primary papers, authoritative specifications, official documentation, and original experiment artifacts. A citation must genuinely support the sentence to which it is attached.
- Preserve valid existing citations and `\label`/`\ref` targets. If support is missing, insert an explicit `TODO: source needed` comment or flag it in the report; do not fabricate a `.bib` entry.
- Distinguish verbatim quotations from paraphrase. Avoid plagiarism; paraphrase faithfully and cite appropriately. Do not bulk-copy published text.
- Never fabricate experimental success rates, baselines, performance figures, proof statistics, or comparisons. Illustrative or synthetic examples must be explicitly labeled and kept separate from benchmark results.
- The human author owns the claims and decisions. Follow the university's current rules on AI assistance, attribution, confidentiality, and disclosure; flag an unknown requirement for review. Do not attempt to disguise AI use to evade academic policies.

## 5. Scientific prose: natural, precise, and human-readable

Write in **formal, clear English** suited to a Computer Science Master's thesis. Favor concrete subjects, active verbs where useful, accurate qualifiers, explicit causal relationships, and genuine paragraph-to-paragraph development. Let the technical substance determine sentence length and detail.

- Use a natural scholarly voice, not a formulaic 'AI-written' style. Avoid inflated claims, empty transitions, repetitive summaries, marketing language, generic opening sentences, exaggerated certainty, and filler such as “in today's rapidly evolving world.”
- Vary syntax organically; do not mechanically alternate short and long sentences or insert irrelevant personal opinions to seem human.
- Define terms before relying on them. Maintain consistent use of *contract*, *precondition*, *postcondition*, *frame condition*, *loop invariant*, *inductiveness*, *verification condition*, *symbolic execution*, *soundness*, *completeness*, and *benchmark*.
- Separate background, methodology, observations, interpretation, and limitations. State what was done, why, on which evidence, and what follows from it.
- Prefer appropriately qualified claims over unearned confidence (“on this benchmark,” “under these assumptions,” “in the evaluated version”). Avoid both overstatement and needless hedging.
- Preserve the author's own terminology and emerging voice. Revise for coherence and readability without silently altering technical meaning. The author will review and may rewrite all drafts.

## 6. JML and formal-verification requirements

Treat Java and JML literally. Use OpenJML-oriented JML comments (`//@`, `/*@ ... @*/`) and favor specifications that are **sound, precise, and practical to verify**, not simply impressive-looking.

### Contracts

1. Analyze parameters, return values, assignments, visible state, control flow, helpers, exceptional paths, and termination before proposing contracts.
2. Prefer the **smallest sound code-justified contract** first. Label stronger intent-level contracts as depending on explicit additional assumptions.
3. State real `requires` obligations (nullness, bounds, divisors, arithmetic range, needed structural constraints) but do not incorrectly exclude error cases that code handles.
4. Include precise method-level frames: `assignable \nothing;` for methods that do not mutate pre-existing heap state; otherwise list actual fields/array locations (`a[*]`, appropriate ranges or cells). Do not confuse changes to local variables/formal parameter bindings with heap mutation.
5. Characterize `ensures` using `\result`, `\old`, and bounded quantifiers when justified. Account for aliases, array contents, integer semantics, and well-definedness.
6. Specify exceptions, normal/exceptional behavior cases, `signals_only`, and `signals` where relevant; do not promise normal termination unless established for the case.
7. Use `pure` only when the method is eligible and specification calls are legal. Do not silently assume helper implementations, callee contracts, sortedness, ownership, stability, or representation invariants.


### Class invariants, arrays, and JML syntax discipline

- State class/object invariants only when justified by the code or explicit design assumptions. Verify that constructors establish them and public methods preserve them. Where necessary, handle specification visibility using `spec_public`, model fields, or suitable abstractions rather than assuming private representation is available in public specifications.
- For arrays, capture both changed and unchanged regions, and any justified pre-state/post-state relation. Make fresh allocation versus array reuse explicit when relevant. Do not claim unchanged length/order/multiplicity, sortedness, stability, or non-aliasing without proof or stated assumptions.
- Prefer a single lightweight specification case for simple methods; split normal and exceptional cases only when behavior genuinely differs by input regime. Keep the recommended JML clause order: `requires`, `old` if appropriate, `assignable`, `ensures`, `signals_only`, `signals`; and for loops: `maintaining`, `loop_assigns`, `decreases`.
- Prefer verifier-friendly basic JML over advanced constructs when they do not improve correctness or clarity. When helper specifications, visibility, class context, or arithmetic assumptions are missing, explain the consequent proof limitations instead of claiming verification.

### Loops and proof obligations

For substantive loop specifications, provide meaningful `maintaining`, `loop_assigns`, and `decreases` clauses when possible. Check:

- initialization of each invariant;
- preservation on **every continuing path**, including `continue` and helper-call effects;
- exit usefulness for guard failure, `break`, early `return`, and `throw` as relevant;
- valid array access, nullness, arithmetic definedness, and no unjustified overflow assumptions;
- accurate frame conditions for local variables and heap locations;
- termination from a well-founded, decreasing expression on all continuing paths.

Treat `while (true)` with an internal break, non-unit strides, moving bounds, two-frontier loops, array mutation, helper effects, and exceptional exits as distinct proof situations. Do not use stable-bound counter invariants for a moving bound without proving them. Distinguish Java `int` overflow behavior from unbounded mathematical-integer reasoning. Quantifiers must be bounded where feasible.

When OpenJML verification fails, investigate preconditions, callee specifications, frames, invariants, visibility/purity, arithmetic/nullness, and contradictory spec cases. Do not conceal failed verification by weakening a claim without disclosure or by assuming the desired result.

## 7. Results, experiments, and reproducibility

**Do not conflate any of the following stages:** candidate generation; emitted JML syntax; successful parsing/typechecking; generated verification conditions; successful discharge of all relevant verification conditions; proof of a specified property under documented assumptions; and independent validation against the intended behavior.

Whenever reporting experiments, record or request, as applicable:

- the research question and precise evaluation criteria;
- the benchmark corpus and selection criteria, including exclusions and duplicates;
- the source revision/commit and tool versions (including Java, JML/OpenJML, solver, OS, and relevant settings);
- execution commands, preconditions, timeouts, resource limits, and whether results were repeated;
- ground truth or reference specification and how it was established, if available;
- counts and denominators, with outcome categories such as generated, valid, verified, invalid/unsound, unverified, timeout, unsupported, and tool error;
- false positives, failed proof obligations, representative counterexamples, and limitations;
- reproducible paths to raw logs, output files, and scripts.

Only compute performance metrics when the definitions and denominators are explicit. A timeout or unknown result is not a proof of unsoundness; acceptance by a parser is not proof of correctness; a proof under inconsistent assumptions is not meaningful evidence of the claimed behavior. Distinguish tool failure, unsupported language construct, incomplete specifications, and genuinely incorrect inferred invariants.

If no experiments have been run, propose a protocol or clearly marked reporting template—not fictional findings.

## 8. LaTeX, bibliography, and repository editing

- Respect the existing document class, university template, preamble, bibliography backend, compilation engine, and file layout. Do not introduce or replace packages needlessly.
- Inspect existing build configuration (`latexmkrc`, `Makefile`, `README`, root directives) before choosing a compiler. If appropriate and installed, run `latexmk` with the project's actual engine; do not hardcode pdfLaTeX if the project requires XeLaTeX/LuaLaTeX. Report missing tools instead of claiming success.
- Keep semantic LaTeX markup (`\section`, `\label`, `\ref`, `\cite`, equations, theorem environments) intact. Make every new table and figure meaningful, numbered/captioned/labeled as appropriate, and referred to in the text.
- Render Java/JML examples faithfully. Whenever possible, keep long examples in external files and reference the exact version used. Distinguish code copied from an evaluated program from pedagogical pseudocode or simplified illustrative examples.
- Preserve bibliography keys, cross-references, substantive text, figures, and existing comments unless the task explicitly requires changes. Protect against accidental file deletion, renaming, broad formatting churn, and build-output commits.
- Never overwrite unrelated user changes, use destructive Git operations, commit/push, or modify remote repositories unless expressly requested. Check `git status` before editing and inspect the final diff. Flag sensitive data before publishing.
- Compile after relevant LaTeX changes when the build environment permits. Review and resolve errors you introduced. **A successful PDF build proves only that the document built, not that its claims are scientifically correct.**

## 9. Execution and reporting protocol

For a requested edit:

1. Identify the target artifact(s) and immediate goal; inspect only the relevant context plus dependencies.
2. Separate confirmed facts from inferred ideas and missing information; add clearly marked `TODO` items when necessary rather than inventing facts.
3. Make minimal, coherent changes consistent with the exposé/thesis trajectory and research vocabulary.
4. Run relevant checks (LaTeX build, tests, OpenJML, bibliography checks, or diff review) when available. Do not claim checks ran if they did not.
5. In the final report, state: files changed; substantive changes; commands/tests actually executed and outcomes; unresolved assumptions, claims requiring citations, and proof or benchmark limitations.

If a requested assertion would be unsupported, say so and offer a correctly qualified alternative. The goal is a defendable research document and a trustworthy verification record, not frictionless production of plausible prose.

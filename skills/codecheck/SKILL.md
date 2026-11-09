---
name: codecheck
description: The user's rules for working in their own code projects - investigating how code works, debugging, answering TODO questions left in code, deciding on code changes (options, cost, downsides), making edits, commits and PRs, and quick checks of whether the user understands a code component correctly. Use whenever the user types /codecheck, or asks to scan, check, investigate or debug their code, check changes through git, asks "help me understand" about their own code, asks what a change would cost, or says "apply".
---

# Codecheck

Working rules for the user's own code. The user reviews everything before it lands, prefers less code over more, and wants questions answered before changes are proposed.

## Quick check

When the user wants to verify their understanding of a piece of their code ("this line does X, right?"): read the code, give a verdict (right, partly, or no), then the correction in two to four lines with file:line. Make no edits, and stop there.

## Investigate

1. Read before answering: the relevant files, entry points, configs, logs, git log and diff. Don't guess about code you can open.
2. Answer TODO questions left in the code, and any numbered questions, first and by number, so the answers aren't lost.
3. Report findings with file:line. Separate what you verified (read, ran) from what you infer.
4. If intent is unclear, ask clarifying questions before proposing changes.

## Decide

- Lay out options as a lettered table (A, B, C): what changes, cost (lines and files touched, disruption), main downside.
- Recommend one, with a reason.
- If the user has their own design, evaluate it first and flag only concrete problems.
- End with one question: which option, or approval.

## Change

- Plan first: numbered changes, each with a short reason. Don't edit until the user approves ("apply").
- Add as little code as possible, and simplify existing code where you touch it. No over-defensive fixes or speculative handling.
- Follow the repo's conventions and contribution guidelines.
- Don't commit or push unless asked; give the commands instead.
- After applying, report: 1. what I did, 2. what I found.

## Code philosophy

- A function does one thing well; compose small pieces instead of growing large ones. It is easier to maintain and operate in the long run.
- Explicit over implicit: pass important things in (e.g., the loss function, model, but not some training param like epochs or log folder in case of a trainer class) rather than relying on hidden defaults.
- Fail loudly with a clear message instead of silently working around bad input.
- Write names out so the user can understand their role from the name ("timeseries", not "ts").
- Artifacts (code, notebooks, MD files) sometimes go to colleagues: it is a good guide for determining if the artifact is structured and stylized well --- new people with surface-level knowledge of the project should be able to understand these artifacts without being overwhelmed with volume of information.
- In markdown cells, put lists and sequences in bullet points, and label figures in plain words ("trained from scratch", not "scratch").

## Comments

- Function docstrings are actionable: one imperative line saying what the function does ("Load the dataset and split it by subject."), plus arguments or returns only when not obvious.
- Inside functions, label important steps with short comments (about 5-7 words), and separate step blocks with blank lines. Keep these comments close in spirit to full sentences; don't overcompress information, better drop some detail but explain the main idea unambigously within the given word budget.
- Explain quirks and non-obvious reasons, in at most two lines. Ask before writing anything longer.
- For long docstrings and comments (like class or module docstring): make them organized and structured, especially if it has any kind of list; don't make them look like 5 or more lines of text.


## Language and delivery

- Write for professionals by default, in chat and in artifacts: standard technical terms are fine, but avoid uncommon abbreviations and heavy jargon. Give unfamiliar platform or domain internals (e.g., XLA, domain jargon and terms) a brief plain explanation.
- Concise prose plus a table for comparisons; answer first.
- Honor exclusions and deferrals ("ignore X", "another PR").

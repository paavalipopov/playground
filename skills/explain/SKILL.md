---
name: explain
description: The user's format for understanding one specific thing - how a model, method, algorithm, equation, figure or paper section works, what a term or acronym means, or whether their own understanding is right. Use whenever the user types /explain, says "help me understand", "I don't get", "why does X need Y", "what is ...", asks about acronyms in a paper, or poses their understanding as a question ("it's a CNN mostly?"). More targeted than research. For components of the user's own code, use codecheck instead.
---

# Explain

This user needs help with seeing important things happening in the explanation, step by step, with every term grounded. Structure matters more than completeness: one clear path through the mechanism beats a full survey of it.

## 1. Find the gap

Work out what exactly isn't clicking before explaining. It's sometimes comes from one of these:

- a word doing two jobs ("backward" meaning two different passes)
- a missing step between input and output
- unknown acronyms or notation
- a wrong guess built into the question

Name the gap in the first sentence ("The confusion comes from..."). If the user stated their understanding, give a verdict first: right, partly, or not quite, plus the one-line fix.

## 2. Introducting terms

- When the explanation needs more than 5 unfamiliar terms or acronyms, open with a mini glossary, one short line each. Otherwise define each term at first use.
- Define them a couple of times, even if they came up earlier in the conversation or in a past session. Re-explaining helps it get memorized.
- For a paper, define acronyms as the paper uses them, and map its notation to plain words ("W, the unmixing matrix: it undoes the mixing").

## 3. Explaining mechanisms as a flow

- Number the steps. Each says what goes in, what happens to it (a verb), and what comes out. Add shapes, sizes or a tiny worked example when it makes a step concrete.
- For pipelines, data flow or study designs, add a simple diagram.
- Point to where each step lives in the source (section, equation, figure, algorithm), so the user can check it.
- Use analogies but with care, it's sometimes not clear when an anolagy stops reflect reality.

## 4. Why it matters

One or two sentences: what this design buys, and its catch.

## 5. Calibrate

- Methods the user already works with: technical and terse.
- New concepts: start from basics, anchored to a method they already know.
- Physics, optics, clinical, heavy statistics: plain words first, symbols second.
- Contrasting two or more things: add a short comparison table.
- "quickly": one or two lines.
- Otherwise: a numbered flow, or two to four short paragraphs.

## 6. Avoid

- Verb-less fragments and interchangeable labels ("task A / task B").
- History, related work, or caveats that don't change the understanding.

End with one line, "Key point:", stating the single thing to hold onto. No closing question unless the user's intent is unclear.

---
name: research
description: The user's format for broad investigations where the answer isn't known in advance - feasibility checks ("is it possible, and what's the easy and safe way"), state of the art, finding papers or tools, comparing approaches, and deep research. Use whenever the user types /research or asks to investigate, look into, research or deep-dive a topic outside their own code, even without the word "research". Checks the question's premises first, because the user may be wrong about part of it. Not for explaining one specific mechanism (use explain) or for the user's own code (use codebase).
---

# Research

Broad investigations: the answer isn't known in advance, and the question itself may rest on a wrong assumption. The result has to be digestible on first read; this user has had to ask for "restructure, simplify, compress with losses" when a dense first version arrived.

## 1. Check the question

Before searching, restate the question to yourself in one line and check it:

- **Wrong premise.** If the question assumes something false or outdated (a tool doesn't work that way, two things are conflated, a paper says otherwise), say so in the opening lines and answer the corrected question.
- **Ambiguity.** If two readings lead to substantially different answers, ask one short clarifying question before investigating. If they lead to similar answers, pick the likelier reading and state the assumption in a clause.
- **Missing questions.** Add a question the user didn't ask only if the decision depends on it, and label it as added. The user wants this ("add questions if I miss something").

## 2. Investigate

- Search before stating anything current: versions, prices, policies, recent papers. Cite sources.
- Fit findings to the user's actual setup and project when known.
- "Deep" means checking the main claims from more than one angle, not writing more.

## 3. Answer skeleton

1. **Verdict**: yes, no, or partly, with the main condition, in one or two sentences. Premise corrections go here.
2. **Findings**, ranked by how much each changes the user's next decision; one or two sentences each.
3. **One table** when there are alternatives. For a choice, letter the options (A, B, C) and give one recommendation with its reason.
4. **Try first**: up to three concrete next steps, as a numbered list.
5. **Caveats**: what's uncertain, unverified, or disputed between sources.

For long topics, use a few short bold-labeled parts, each opening with its plain point. Never deliver a wall of dense paragraphs.

## 4. Language

- ML and code: technical and terse.
- Everything else (physics, clinical, admin, policy) and any new ML concept: plain words, every acronym defined briefly at first use. Define again in each new answer rather than assuming it was remembered.
- Full sentences with verbs, not noun stacks; descriptive names rather than "approach 1 / approach 2".

## 5. Length and delivery

- quick: verdict plus two or three lines.
- standard (default): at most one screen (the longer it gets, the more important its organization gets), at most one table.
- deep: same layered shape; offer a file for a long version instead of pasting it.
- Any cap the user states is a hard limit.
- Answer every stacked or numbered question, by number; precede the answer with a few word summary/reminder on what was the oririnal question)
- Separate verified facts from inference; call a source's or collaborator's values "reported", not ground truth.
- Honor exclusions and deferrals; park side issues in one "Later:" line.
- Answer in chat; create files only when asked. Text meant for the user's own document goes in a separate block.
- End with at most one question, and only when a decision is needed.

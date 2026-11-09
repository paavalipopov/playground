---
name: research
description: The user's format for broad investigations where the answer isn't known in advance - feasibility checks ("is it possible, and what's the easy and safe way"), state of the art, finding papers or tools, comparing approaches, and deep research. Use whenever the user types /research or asks to investigate, look into, research or deep-dive a topic outside their own code, even without the word "research". Checks the question's premises first, because the user may be wrong about part of it. Not for explaining one specific mechanism (use explain) or for the user's own code (use codecheck).
---

# Research

Broad investigations: the answer isn't known in advance, and the question itself may rest on a wrong assumption. The result has to be digestible on first read; this user has had to ask for "restructure, simplify, compress with losses" when a dense first version arrived.

## 1. Check the question

Before searching, restate the question to yourself in one line and check it:

- **Wrong premise.** If the question assumes something false or outdated (a tool doesn't work that way, two things are conflated, a paper says otherwise), say so in the opening lines and answer the corrected question.
- **Ambiguity.** If two readings lead to substantially different answers, ask one short clarifying question before investigating. If they lead to similar answers, pick the likelier reading and state the assumption in a clause.
- **Missing questions.** Add a question the user didn't ask only if the decision depends on it, and label it as added. The user wants this ("add questions if I miss something").

## 2. Answer skeleton

Use the parts that apply, in this order:

1. **Verdict**: yes, no, or partly, with the main condition, in one or two sentences. Premise corrections go here.
2. **Findings**, ranked by how much each changes the user's next decision; one or two sentences each.
3. **One table** at most, when there are alternatives. For a choice, letter the options (A, B, C) and give one recommendation with its reason.
4. **Try first**: up to three concrete next steps, as a numbered list.
5. **Caveats**: what's uncertain, unverified, or disputed between sources.

For long topics, use a few short bold-labeled parts, each opening with its plain point. Never deliver a wall of dense paragraphs.

## 3. Language

- ML and code: technical, written for professionals, but without uncommon abbreviations or heavy jargon.
- Everything else (physics, clinical, admin, policy) and any new ML concept: plain words, every acronym defined briefly at first use. Re-define terms now and then, even if they came up before; repetition helps them stick.
- Full sentences with verbs, not noun stacks; descriptive names rather than "approach 1 / approach 2". Within the length budget, drop details rather than compressing the main idea.

## 4. Length and delivery

- quick: verdict plus two or three lines.
- standard (default): at most one screen (the longer it gets, the more important its organization gets).
- deep: check the main claims from more than one angle; that means more checking, not more text. Keep the same layered shape, and offer a file for a long version instead of pasting it.
- Answer every stacked or numbered question, by number; precede each answer with a few-word reminder of the original question.
- Separate verified facts from inference; call a source's or collaborator's values "reported", not ground truth.
- Text meant for the user's own document goes in a separate block.
- End with at most one question, and only when a decision is needed.

---
title: "Before You Build Another Model"
description: "Part 1 of From Answers to Outcomes: when a ready-made model is enough, and when your system needs something more."
author: Abinaya Govindan
categories: [AI Architecture, Agentic AI]
tags: [specialist-ai, enterprise-ai, context, fine-tuning, procedural-memory, build-vs-buy, series]
pin: true
---

> This is Part 1 of [From Answers to Outcomes](/series/), a series on what I've learned building AI systems for enterprise teams. This part is about a question that comes up early in almost every project: when is a ready-made model enough, and when does your system need something more?
{: .prompt-info }

Sooner or later, a lot of the enterprise AI conversations I've been part of land on the same question: do we roll out a ready-made assistant, or build our own?

In practice, that question gets asked twice, and it sounds quite different each time.

Before launch, it's mostly about getting off the ground. What's the cheapest, fastest way to put something useful in front of people? That's a reasonable question, and a ready-made model is often a good answer to it.

Once the system is in production, a different question shows up: why didn't we catch these corner cases, and where are we supposed to handle them? The error code that means something different on one firmware version. The fix that's right for one product and wrong for the next one. The step that has to happen before another step, every time. These rarely show up in a demo. They show up once real people start using the system for real work.

Both questions usually get framed as model questions. Which model is smartest, which is cheapest, whether it's worth fine-tuning, whether a bigger model would have caught those corner cases. I understand why. Models are the visible part, and they change every few months. But the longer I work on these systems, the less useful I find that framing. The question that tends to decide how things turn out is a different one: what does the AI need to know to be useful here, where does that knowledge live, and can the system bring the right pieces together when they matter?

The model matters. But in enterprise AI, I've come to think the bigger question is what sits around it: other models, your data, your organization's knowledge, and the procedures that turn that knowledge into action. That's the thread through this article. It's the first part of a series, so I'll stay closer to the ideas here and leave most of the architecture for later parts.

## Start with what general-purpose AI does well

Build-vs-buy discussions tend to undersell this, so I'll start here.

A good general-purpose assistant is remarkably capable out of the box. It can summarize a long thread, draft a reply, explain a concept, translate, and reason through a problem it has never seen, all in fluent language. For a lot of everyday work that's enough, and building something custom would be a waste of time and money.

What's happened at the model level also changes the build-vs-buy math. In 2023, Bloomberg made a major investment in domain-specific pretraining with BloombergGPT, trained on a mix of its own financial data and general text [^bloomberg]. Within months, a study of financial text tasks found that ChatGPT and GPT-4 outperformed the rest, BloombergGPT included, on almost every dataset tested. The exception was named entity recognition, where fine-tuned models still held their ground [^li]. Around the same time, Google took a different route with Med-PaLM 2, adapting a general model to medicine rather than training one from scratch, and reported 86.5% on the MedQA benchmark [^medpalm].

I read both as the same signal. Knowledge you can learn from large amounts of text about a field is increasingly something a strong general model already has, or can be adapted to without enormous effort. That's good news. It just means that kind of knowledge on its own is not where I'd expect the lasting difference between systems to come from.

The exception in that finance study is worth holding on to, because it matches what I've seen. In the systems I've worked on, fine-tuned smaller models earned their place on narrow, high-volume jobs: pulling structured information out of messy text, cleaning up noisy input, matching domain terminology that a general model kept getting slightly wrong. They were rarely the right tool for open-ended reasoning.

## The student who only studied linear algebra

There's an opposite mistake too, and it's the one I think about when people ask whether they should just train their own model.

Imagine a student who has spent years going deep on linear algebra and nothing else. Ask them about eigenvectors or matrix decompositions and they're brilliant. Ask them a basic physics question, one most people with a general education could answer, and they're stuck. Nothing is wrong with what they learned. The problem is everything they didn't keep up with along the way.

Models can end up in a similar place. Push a model hard toward one narrow body of knowledge and it can lose some of what it knew before. The ML literature calls this catastrophic forgetting, and a 2023 study of continual fine-tuning found it was generally observed across LLMs from 1B to 7B parameters [^luo]. It's also why BloombergGPT's authors didn't train on financial data alone. They deliberately mixed in general-purpose text, and reported strong financial results *without sacrificing performance on general LLM benchmarks* [^bloomberg]. Even a team betting heavily on domain pretraining went out of its way to protect general ability.

In an enterprise, though, the bigger risk isn't really that one model gets narrow. It's what users do about it. If the specialized system can't handle everyday questions, people keep a general assistant open in another tab, plus a search engine, plus the internal wiki, and quietly become the integration layer themselves. At that point you haven't built one useful system. You've built one more place to look.

So the goal I'd aim for isn't "general or specialized." It's one system that uses the right kind of capability for each question, without the user having to know or care which one that was.

## There's more than one way to specialize

When people say "specialized AI," they often mean "a model we fine-tuned." Fine-tuning, which updates a model's weights to adapt it to a specific task or behavior, is one way to specialize. It isn't the only one, and it often isn't the first I'd reach for.

It helps to be precise here, because these are genuinely different levers:

- **Prompting and context.** Giving a general model the right instructions and the right information at the moment it needs them. Anthropic describes good context engineering as finding "the smallest possible set of high-signal tokens that maximize the likelihood of some desired outcome" [^context]. In practice, a surprising amount of specialization lives here.
- **Retrieval.** Pulling the relevant documents, records or history into that context from your own sources, so the model reasons over your information rather than whatever it remembers.
- **Structured data and tools.** Letting the system look things up, or do things, in the systems where the facts actually live, instead of hoping they're in a document somewhere.
- **Fine-tuning.** Training an existing model further on examples of a specific task, so it does that task more reliably or more cheaply.
- **Domain-adaptive pretraining.** Continuing to pretrain a model on a large body of in-domain text before any task-specific training. Gururangan et al. showed this second phase of pretraining helps in both high- and low-resource settings [^dapt]. It's a bigger investment than fine-tuning, and a much smaller one than training from scratch.
- **Smaller specialist models.** Models built to do one narrow job well, often much cheaper and faster than a frontier model for that job.
- **Deterministic code and workflows.** For the parts that shouldn't be left to a model at all.

Put together, a production system rarely has a single model at its center. A general-purpose model might handle reasoning and language, a smaller specialist might extract structured information, an embedding model might power retrieval, and plain code might enforce the steps that have a right answer. A recent NVIDIA position paper makes a similar argument from the cost side: that small language models are sufficient and more economical for many of the calls inside agentic systems, and that systems invoking multiple different models are "the natural choice" where general conversational ability is still needed [^slm].

So the question I'd ask isn't "should we fine-tune?" It's **where should the specialization live?** Sometimes the honest answer is "in the prompt and the retrieval, and nowhere else." Sometimes it's a small fine-tuned model for one high-volume task. Sometimes it's a procedure no model should improvise.

### When you don't have much labelled data

One version of this comes up a lot: you'd like a small specialist model for a narrow task, but you only have a handful of labelled examples.

That isn't necessarily a dead end. A pattern I've seen work: use a strong general model, zero-shot or few-shot, to label or generate more examples, filter them carefully, and train a small model on what survives. The small model then handles the narrow, high-volume job more cheaply than calling the large one every time.

Research supports the idea. In *Distilling Step-by-Step*, a 770M-parameter model trained with rationales from a much larger one outperformed the few-shot prompted 540B PaLM on a benchmark [^distill]. The caveat I'd add is that generated labels inherit the larger model's mistakes, so filtering is part of the design, not an afterthought.

## Public knowledge vs organizational knowledge

So far this has mostly been about domain knowledge. But I've come to think the more important distinction isn't general versus domain. It's **public versus organizational**.

Public knowledge is anything you could, in principle, learn from outside the company: how a technology works, what an engineering term means, why a common failure happens. A strong general model may well know it already, and if it doesn't, you can usually teach it.

Organizational knowledge is different. It's this company's products and versions, its known issues and approved fixes, its warranty rules and contracts, what a particular customer has already tried, and what a particular user is allowed to see and do. Almost none of it is public, it changes all the time, and nobody outside the organization can pretrain it into a model for you.

To make that concrete, here's a made-up example. Picture a company that makes commercial espresso machines, and the kinds of questions its service team might ask.

<figure class="context-venn" style="margin: 1.5rem 0;">
<svg viewBox="0 0 600 500" role="img" aria-labelledby="venn-title venn-desc" style="width:100%;max-width:600px;height:auto;display:block;margin:0 auto;font-family:inherit;">
  <title id="venn-title">Three overlapping kinds of knowledge</title>
  <desc id="venn-desc">Three overlapping circles: a general-purpose LLM, a domain model, and the organization's own context and workflows. Numbered regions correspond to the example questions listed below the diagram.</desc>
  <circle cx="220" cy="175" r="140" fill="#3b82f6" fill-opacity="0.16" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="380" cy="175" r="140" fill="#10b981" fill-opacity="0.16" stroke="#10b981" stroke-width="2"/>
  <circle cx="300" cy="305" r="140" fill="#f59e0b" fill-opacity="0.18" stroke="#f59e0b" stroke-width="2"/>
  <g fill="currentColor" font-size="15" font-weight="600" text-anchor="middle">
    <text x="130" y="28">General-purpose LLM</text>
    <text x="470" y="28">Domain model</text>
    <text x="300" y="478">Your organization's context and workflows</text>
  </g>
  <g font-size="14" font-weight="700" text-anchor="middle" fill="currentColor">
    <circle cx="140" cy="140" r="15" fill="#3b82f6" fill-opacity="0.35"/><text x="140" y="145">1</text>
    <circle cx="300" cy="105" r="15" fill="#64748b" fill-opacity="0.35"/><text x="300" y="110">2</text>
    <circle cx="460" cy="140" r="15" fill="#10b981" fill-opacity="0.35"/><text x="460" y="145">3</text>
    <circle cx="200" cy="285" r="15" fill="#64748b" fill-opacity="0.35"/><text x="200" y="290">4</text>
    <circle cx="400" cy="285" r="15" fill="#64748b" fill-opacity="0.35"/><text x="400" y="290">5</text>
    <circle cx="300" cy="215" r="15" fill="#64748b" fill-opacity="0.35"/><text x="300" y="220">6</text>
    <circle cx="300" cy="390" r="15" fill="#f59e0b" fill-opacity="0.45"/><text x="300" y="395">7</text>
  </g>
  <text x="300" y="425" font-size="13" font-style="italic" text-anchor="middle" fill="currentColor" opacity="0.8">only your organization has this</text>
</svg>
<figcaption style="text-align:center;font-size:.9rem;opacity:.8;">Numbers match the example questions below. Not to scale, and the boundaries move as models improve.</figcaption>
</figure>

1. **"Draft a polite reply to this customer's email."** Open-domain. Any good general assistant handles this.
2. **"Why does hard water damage espresso boilers?"** Domain knowledge, but public. A general model usually knows it, and so does a domain model.
3. **"Pull the part numbers and fault codes out of these messy technician notes."** A narrow, repetitive domain job. This is where a small fine-tuned model tends to earn its place.
4. **"Summarize this customer's service history before my visit."** General skill, applied to the organization's own data. The model is fine; the hard part is getting it the right history.
5. **"What does fault E17 usually mean on our machines?"** Domain understanding plus organizational knowledge: this company's machines, this company's error codes.
6. **"E17 after descaling on firmware 4.2, still under warranty. What's our approved fix?"** All three at once: general reasoning, domain understanding, and the company's own documentation, known issues and warranty rules.
7. **"Walk me through the approved repair and log it for the warranty claim."** Mostly organization-specific: a specific procedure, specific steps in a specific order, and a record at the end.

The first two groups are where ready-made models are strong, and getting stronger. If most of your questions live there, a ready-made assistant is probably the right answer.

The third is where a specialist model makes sense. Useful, but a fairly specific kind of useful.

The orange circle is the one that decides whether the system is actually useful for *your* work. It's also the part nobody outside your company can build for you, because nobody outside your company has it. If there's a lasting advantage anywhere in this picture, I think it's there.

And notice that question 6 isn't really "a harder LLM question." It's a system problem. It needs the right model, the right retrieval, the right version information and the right policy, all at once.

When I look at where wrong answers came from in the systems I've worked on, it was rarely because the model couldn't reason. More often it reasoned well over the wrong context, or incomplete context: the right procedure for a different product version, a document that had been superseded, an answer that ignored what the user had already tried. That's my experience rather than a measured industry finding, but it's consistent enough that it shapes how I build.

It's also not a new problem for me. One of the first things I worked on in NLP was question answering over product manuals, and the paper that came out of that work was about overlaying domain knowledge on top of existing models so answers made sense in context [^qa]. The models were BERT-era then. The shape of the problem was the same.

## From an answer to an outcome

Inside the orange circle there's another distinction that took me a while to put into words. Look at how the E17 example changes as you move through it:

- **Knowing things.** *What is E17?* A reference answer. Documentation, or even a general model, might cover it.
- **Knowing the situation.** *E17 on firmware 4.2, after descaling, on this customer's machine, which is still under warranty.* Now the answer depends on specifics only the organization has.
- **Knowing how things are done here.** *Given that situation, what does our organization require the technician to do?* This is procedure, not information.
- **Doing it.** *Carry out the approved repair and record the warranty claim.* This is action in real systems.

Most of what gets called enterprise AI today lives at the first level, sometimes the second. The value I care about is further down the list. That progression, from an answer to an outcome, is what this series is named after.

The third level deserves special attention, because it's the one most often missing. Documentation captures *knowing things*. *Knowing how things are done here* lives in experienced people's heads, in resolved cases, and in the small rules a team follows without writing them down anywhere official. The kind that starts with "for that model, check this first" or "don't do that step until you've done this one." It's some of the most valuable knowledge an organization has, and the least likely to be in anything an off-the-shelf assistant can index.

The research literature has a name for this. The CoALA paper, which proposes a framework for thinking about language agents, describes procedural memory for language agents as coming in two forms: implicit knowledge in the model's weights, and explicit knowledge written into the agent's code [^coala]. In enterprise systems I'd add a stricter version of the second: procedures the organization itself owns. Explicit, versioned, with someone accountable for them. When a system follows a procedure, you want to know which one it followed, which version, and who approved it. That's hard to get from weights, and awkward to get from code that only engineers can change.

Part of why this matters is repetition. Some work should stay open-ended, and that's where models are at their best. But when the same kind of problem comes up often enough, you eventually want the system to know the reliable way to handle it, rather than working it out from scratch every time and getting a slightly different answer each time. I think this is one of the less talked about reasons enterprise AI can feel unstable to the people using it, and one of the more fixable ones.

I'll go much deeper into procedural memory in Part 4.

## When to follow the procedure, and when to think

Once the organization has procedures of its own, a new question shows up: when should the system follow one exactly, and when should it reason freely?

Anthropic draws a useful line in its guide to building agents. It describes workflows as systems where LLMs and tools are orchestrated through predefined code paths, and agents as systems where the model dynamically directs its own process and tool use. Its advice is that workflows offer predictability and consistency for well-defined tasks, while agents are the better option when flexibility and model-driven decision-making are needed, and that it's usually worth starting with the simplest thing that works [^agents].

I agree, and I'd add that in enterprise work the two rarely stay separate for long. Question 7 is a good example. The repair steps have a right answer and should be followed exactly. But the system still needs to reason about what the technician is seeing, explain each step, and handle whatever doesn't go to plan.

| Leans toward a fixed procedure | Leans toward open reasoning |
|---|---|
| Safety or compliance steps | Diagnosing something unfamiliar |
| Actions that are hard to undo | Explaining why, or comparing options |
| Rules tied to contracts or permissions | Adapting to what the user has already tried |
| Anything an auditor will ask about later | Pulling together evidence from several sources |

## What that adds up to

If I put all of this into one picture, it looks less like "a model" and more like a set of layers, each of which can own part of a problem.

<figure class="system-layers" style="margin: 1.5rem 0;">
<svg viewBox="0 0 640 400" role="img" aria-labelledby="layers-title layers-desc" style="width:100%;max-width:640px;height:auto;display:block;margin:0 auto;font-family:inherit;">
  <title id="layers-title">Layers of an enterprise AI system</title>
  <desc id="layers-desc">Five stacked layers: general-purpose models; specialist models; retrieval and context; procedures; tools and actions. A bracket marks the lower three layers as shaped by the organization.</desc>
  <g font-size="15" fill="currentColor">
    <rect x="20" y="20" width="440" height="60" rx="10" fill="#3b82f6" fill-opacity="0.16" stroke="#3b82f6" stroke-width="2"/>
    <text x="40" y="46" font-weight="700">General-purpose models</text>
    <text x="40" y="67" font-size="13" opacity="0.85">reasoning, language, broad knowledge</text>
    <rect x="20" y="95" width="440" height="60" rx="10" fill="#10b981" fill-opacity="0.16" stroke="#10b981" stroke-width="2"/>
    <text x="40" y="121" font-weight="700">Specialist models</text>
    <text x="40" y="142" font-size="13" opacity="0.85">fine-tuned, domain-adapted, distilled from generated data</text>
    <rect x="20" y="170" width="440" height="60" rx="10" fill="#f59e0b" fill-opacity="0.14" stroke="#f59e0b" stroke-width="2"/>
    <text x="40" y="196" font-weight="700">Retrieval and context</text>
    <text x="40" y="217" font-size="13" opacity="0.85">documents, product and version data, history, permissions</text>
    <rect x="20" y="245" width="440" height="60" rx="10" fill="#f59e0b" fill-opacity="0.22" stroke="#f59e0b" stroke-width="2"/>
    <text x="40" y="271" font-weight="700">Procedures</text>
    <text x="40" y="292" font-size="13" opacity="0.85">approved ways of doing things, versioned and owned</text>
    <rect x="20" y="320" width="440" height="60" rx="10" fill="#f59e0b" fill-opacity="0.30" stroke="#f59e0b" stroke-width="2"/>
    <text x="40" y="346" font-weight="700">Tools and actions</text>
    <text x="40" y="367" font-size="13" opacity="0.85">the systems where the work actually happens</text>
  </g>
  <g fill="none" stroke="currentColor" stroke-opacity="0.55" stroke-width="2">
    <path d="M478 22 h10 v56 h-10"/>
    <path d="M478 97 h10 v56 h-10"/>
    <path d="M478 172 h10 v206 h-10"/>
  </g>
  <g font-size="13" fill="currentColor" opacity="0.85">
    <text x="498" y="55">mostly bought</text>
    <text x="498" y="122">built or bought,</text>
    <text x="498" y="139">depending on the task</text>
    <text x="498" y="268">shaped by your</text>
    <text x="498" y="285">organization</text>
  </g>
</svg>
<figcaption style="text-align:center;font-size:.9rem;opacity:.8;">A single request can touch several layers. Something has to decide which one handles each step.</figcaption>
</figure>

A request like question 6 might use the general model to understand the question, a small specialist model to pull out the product, firmware and error code, retrieval to find the right documentation and the customer's history, a procedure to decide what's allowed under warranty, and a tool to open the repair record. Each layer does the part it's best at.

Which raises the question the next article is about: for any given step, **which part of the system should own the problem?** That's Part 2.

## So, should you build another model?

Sometimes. But more often, the first things I'd build are the ones around the model. My honest answer to the build-vs-buy question is both, in layers.

And I'd think about the second question, the one about corner cases, before go-live rather than after. Most of the layers in this article are really answers to it. It's much easier to leave room for them early than to retrofit them once people are relying on the system.

A ready-made assistant is a good way to start, and I'd rarely argue against starting there. It covers the open-domain and public-knowledge questions well, it gets people using AI on real work quickly, and that usage shows you where the gaps are.

What I'd be careful about is stopping there by default. "Both" in practice means something like: their frontier models for general reasoning and language; your own specialist models where a narrow, high-volume task justifies one; and your data, your retrieval, your procedures, your tools and your evaluation around all of it. The first part you can buy. Most of the rest only exists if someone in your organization builds it.

If I were starting again, this is roughly the order I'd work in:

1. Start with a capable general assistant on your own content, and treat the first few months partly as research.
2. Collect real questions, especially from your most experienced users. They're the ones who'll find the edges first.
3. Sort those questions into the groups above. It tells you quickly how much of your work a ready-made assistant can cover, and how much depends on knowledge only you have.
4. Look closely at the failures and sort them by cause: missing context, wrong context (the wrong product or version), a procedure that should have been followed, an action the system couldn't take. In my experience, a surprising number of them turn out to be context problems rather than model problems.
5. Decide where each kind of specialization should live. Better context and retrieval first; a specialist model only where a narrow task earns it; procedures for the steps that have a right answer.
6. Keep the model swappable. The model you pick today will probably be replaced, maybe more than once. The context, procedures and evaluation you build are the parts that carry over, so it's worth not tying them too tightly to any one model.

None of that requires building everything yourself. It does require deciding which parts you want to own.

## What I'm not saying

A few things I want to be clear about, because this argument is easy to stretch too far.

- I'm not saying general-purpose models are weak. They're very strong, and a good specialist system uses them heavily. There's no point rebuilding something that already works.
- I'm not saying everyone should build their own AI. For a lot of work, a ready-made assistant is the right answer.
- I'm not against fine-tuning. If anything, I think it works best when it's used deliberately, for the specific jobs it's good at, rather than as the default meaning of "specialized."

What I am saying is that as models get better and easier to swap, more of the difference between an AI that's generally helpful and one that's actually useful for your work seems to come from what's around the model. Much of that is knowledge and procedure that only your organization has.

## Next

In Part 2, I'll look at how a system decides what should handle each piece of work: the general model, a smaller specialist, retrieval, or a fixed procedure. I'll also look at what goes wrong when it decides badly.

*If you've been through the build-vs-buy question in your own organization, I'd like to hear where you landed and why. You can find me on [LinkedIn](https://www.linkedin.com/in/abinaya-govindan-59088311a/).*

*Examples in this article are made up on purpose. Nothing here comes from customer or proprietary work.*

---

**References**

[^bloomberg]: Wu, S. et al. (2023). *BloombergGPT: A Large Language Model for Finance.* [arXiv:2303.17564](https://arxiv.org/abs/2303.17564)
[^li]: Li, X. et al. (2023). *Are ChatGPT and GPT-4 General-Purpose Solvers for Financial Text Analytics? A Study on Several Typical Tasks.* [arXiv:2305.05862](https://arxiv.org/abs/2305.05862)
[^medpalm]: Singhal, K. et al. (2023). *Towards Expert-Level Medical Question Answering with Large Language Models.* [arXiv:2305.09617](https://arxiv.org/abs/2305.09617)
[^luo]: Luo, Y. et al. (2023). *An Empirical Study of Catastrophic Forgetting in Large Language Models During Continual Fine-tuning.* [arXiv:2308.08747](https://arxiv.org/abs/2308.08747)
[^context]: Anthropic (2025). *Effective context engineering for AI agents.* [anthropic.com/engineering/effective-context-engineering-for-ai-agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
[^dapt]: Gururangan, S. et al. (2020). *Don't Stop Pretraining: Adapt Language Models to Domains and Tasks.* ACL 2020. [arXiv:2004.10964](https://arxiv.org/abs/2004.10964)
[^slm]: Belcak, P. et al. (2025). *Small Language Models are the Future of Agentic AI.* [arXiv:2506.02153](https://arxiv.org/abs/2506.02153)
[^distill]: Hsieh, C.-Y. et al. (2023). *Distilling Step-by-Step! Outperforming Larger Language Models with Less Training Data and Smaller Model Sizes.* Findings of ACL 2023. [arXiv:2305.02301](https://arxiv.org/abs/2305.02301)
[^qa]: *Intelligent Question Answering Module for Product Manuals*, Computer Science & Information Technology (CS & IT), 2021. See [publications](/publications/).
[^coala]: Sumers, T. R. et al. (2023). *Cognitive Architectures for Language Agents.* [arXiv:2309.02427](https://arxiv.org/abs/2309.02427)
[^agents]: Anthropic (2024). *Building Effective AI Agents.* [anthropic.com/engineering/building-effective-agents](https://www.anthropic.com/engineering/building-effective-agents)

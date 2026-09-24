---
# the default layout is 'page'
icon: fas fa-info-circle
order: 3
---

```console
$ whoami
abinaya  # aka rex8me. builds AI systems, breaks a few along the way.
```

I'm Abinaya.

I build AI systems, and this is where I write about the things I find interesting while doing it.

I don't have a fixed list of topics. AI moves too fast for that, and half the fun is not knowing what I'll be obsessed with next month.

Some weeks it's how an agent should decide what to do next. Some weeks it's why a search system keeps returning the *almost* right document. Sometimes it's how you evaluate a model that quietly changed underneath you. Every now and then it's a plain old classical ML problem that turns out to still be the right answer. And sometimes it's just a paper or an idea I couldn't leave alone.

The common thread is the engineering. What actually happens between the model and the thing we're trying to build? That gap is where most of the interesting problems live. Most of the bugs, too.

### `day job`

I build AI systems for enterprise: agents, retrieval, memory, evaluation, and all the unglamorous engineering it takes to keep them alive in production. It's where most of my opinions come from, usually after something breaks.

### `after hours`

I tinker. Quick POCs, half-finished experiments, the occasional thing that grows into a real project. If it breaks in an interesting way, it'll probably end up here.

### `a bit of history`

I started out staring into Jupyter notebooks for what was probably an unreasonable amount of time, trying to work out why my latest model was taking forever to train.

A lot of those years went into hunting for the golden feature. The one that was surely going to change everything. Occasionally it even did.

For a good while, the answer to most problems seemed to be XGBoost. And when something mysteriously hung, the first suspect was usually also XGBoost, or more accurately some setup detail I'd gotten slightly wrong.

Some of my teammates now call these "retro models". I prefer *historically significant*. 😄

After that came NLP and deep learning: Word2Vec, LSTMs, and BERT back when it felt like magic. Then search and retrieval, and eventually LLMs and agents.

The models changed a lot along the way. The engineering problems didn't disappear, they just moved. I used to stare at a notebook wondering why the model was still running. Now I stare at a distributed system wondering why the agent is still running. I used to hunt for the one feature that might change the model. Now it's the one piece of context that might change the answer.

The part I enjoy hasn't really changed: figuring out why a system isn't doing what I thought it would, and then making it a bit better.

### `currently exploring`

- which model (or which non-model) should handle which step
- procedural memory: getting agents to do things the way experts actually do them
- evaluation that doesn't fall apart the moment you swap the model

A lot of this is going into a series right now, [From Answers to Outcomes]({{ '/series/' | relative_url }}): my notes on what specialist AI needs to be useful for real enterprise work. It's one thread, not the whole site. There'll be others.

### `what you'll find here`

Notes, diagrams, code, trade-offs, and the occasional post-mortem. Not predictions. Not hot takes (okay, maybe a few). Mostly me working things out in public.

Examples are generic on purpose. Nothing here comes from customer or proprietary work.

### `ping`

If something here helped, or you think I got it wrong, tell me. I'd honestly like to know.

[LinkedIn](https://www.linkedin.com/in/abinaya-govindan-59088311a/) · [GitHub](https://github.com/rex8me) · [older research]({{ '/publications/' | relative_url }})

<small>*Views are my own, not my employer's.*</small>

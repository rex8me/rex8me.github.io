---
layout: page
title: "From Answers to Outcomes"
permalink: /series/
---

{% assign series = site.data.series %}
{% assign first = site.posts | where_exp: "p", "p.slug == 'your-ai-or-theirs'" | first %}

<p class="series-hero-tagline">Notes from building agentic AI for the enterprise.</p>

This series is me writing down what I've learned from building agentic AI systems for enterprise teams: what worked, what broke, and what I'd do differently next time.

General-purpose AI gets teams started remarkably quickly, and I don't want to undersell that. It's genuinely useful. But I've seen the same thing happen more than once. As it becomes part of everyday work, people start stretching it into more specific workflows and testing where its limits are. That's usually when the outliers show up, and the hard cases start to depend on things the model doesn't come with: the organization's own products and processes, decisions it has made before, the procedures people are expected to follow, what a particular user is allowed to see and do.

It's rarely a sign that generic AI failed. It's a sign that it isn't the whole answer.

At that point the question I find myself asking changes. It's less "which model should we use?" and more "what does the system around the model need to look like for this to actually work?"

The more I build these systems, the less I think the model itself is the interesting part. Models still matter, a lot. But they keep getting better and easier to swap, and in the systems I've worked on, the harder problems tend to sit around them: the context the system can draw on, how work gets routed, whether retrieval respects the situation it's in, which tools it can use and with what permissions, how it's evaluated, and how feedback finds its way back in.

One thing I keep coming back to is repetition. Some work should stay open-ended, and that's where models are at their best. But when the same kind of problem comes up often enough, whether people are solving it or an agent is, you eventually want the system to know the reliable way to handle it instead of working it out from scratch every time. That's where ideas like procedural memory start to get interesting, and I think they have a lot to do with making enterprise AI more stable and consistent.

My working theory is that more of the industry will move in this direction: general-purpose AI where it's strong, combined with domain-specific, custom-built pieces where the work demands it, all built around the organization's own context. I've been calling that *specialist AI*. It's a working term, not a claim to have found the definitive architecture. These articles are my attempt to explain why I think it matters, and to work out what it actually takes to build in practice.

None of this is a finished framework. It's the current state of my thinking, shaped by experiments, production issues and a fair number of wrong turns, and I expect parts of it to change as the models and tools do.

<p class="series-question">The question I keep coming back to: what does a specialist AI actually need to become useful?</p>

So far, my answer looks roughly like this:

<ol class="series-argument">
{% for part in series.parts %}
  {% assign match = site.posts | where_exp: "p", "p.slug == part.slug" | first %}
  <li>
    <p class="arg-need">{{ part.need }}</p>
    <p class="arg-part">
      <span class="arg-label">{{ part.label }}</span>
      {% if match %}<a href="{{ match.url | relative_url }}">{{ part.title }}</a>{% else %}<span class="arg-title">{{ part.title }}</span> <span class="series-soon">coming soon</span>{% endif %}
    </p>
    <p class="arg-blurb">{{ part.blurb }}</p>
  </li>
{% endfor %}
</ol>

These aren't really steps, though. In practice they keep feeding into each other. What context you have changes how work should be routed, which changes what the system needs to retrieve. Procedures change what actually gets executed. And evaluation is usually what tells me which of the others to go back and fix. What I learn there often sends me back to the first.

Examples throughout are generic on purpose. Nothing here comes from customer or proprietary work.

{% if first %}
<p class="series-cta"><a class="btn btn-primary" href="{{ first.url | relative_url }}">Start with Part 1 →</a></p>
{% endif %}

## Who it's for

If you're building or buying AI for real enterprise work, especially where a plausible answer isn't good enough, I hope some of this saves you time. And if your experience says otherwise, I'd genuinely like to hear it.

## Follow along

New parts are announced on LinkedIn, or you can get them in a feed reader.

<p><a class="btn btn-primary me-2 mb-2" href="https://www.linkedin.com/in/abinaya-govindan-59088311a/" target="_blank" rel="noopener"><i class="fab fa-linkedin"></i>&nbsp; Follow on LinkedIn</a><a class="btn btn-outline-primary mb-2" href="{{ '/subscribe/' | relative_url }}">More ways to subscribe</a></p>

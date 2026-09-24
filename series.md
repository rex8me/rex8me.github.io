---
layout: page
title: "From Answers to Outcomes"
permalink: /series/
---

{% assign series = site.data.series %}
{% assign first = site.posts | where_exp: "p", "p.slug == 'your-ai-or-theirs'" | first %}

<p class="series-hero-tagline">Notes from building agentic AI for the enterprise.</p>

This series is me writing down what I've learned from building agentic AI systems for enterprise teams: what worked, what broke, and what I'd do differently next time.

Over the last few years I've seen the same pattern more than once. A general-purpose assistant gets a team started quickly, and it's genuinely useful. Then, as it becomes part of everyday work, people start stretching it: pushing it into more specific workflows and testing where its limits are.

That's usually when the outliers show up. The hard cases start to depend more and more on the company's own products, processes, customers and context. It's rarely a sign that generic AI failed. It's a sign that it isn't the whole answer. What held up in practice was a layered approach: general-purpose AI where it's strong, combined with domain-specific, custom-built AI where the work demands it, all built around the organization's own context.

My working theory is that more of the industry will move in that direction, toward what I'll call **specialist AI**. These articles are my attempt to explain why, and to work out what it actually takes to build that specialist layer in practice.

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

In practice these don't happen in a neat order. Context only helps if the system knows how to use it, retrieval only matters if it feeds the right decisions, and none of it counts until you can show it still works a few months later. What I learn in that last step usually sends me back to the first.

{% if first %}
<p class="series-cta"><a class="btn btn-primary" href="{{ first.url | relative_url }}">Start with Part 1 →</a></p>
{% endif %}

## Who it's for

If you're building or buying AI for real enterprise work, especially where a plausible answer isn't good enough, I hope some of this saves you time. And if your experience says otherwise, I'd genuinely like to hear it.

## Follow along

New parts are announced on LinkedIn, or you can get them in a feed reader.

<p><a class="btn btn-primary me-2 mb-2" href="https://www.linkedin.com/in/abinaya-govindan-59088311a/" target="_blank" rel="noopener"><i class="fab fa-linkedin"></i>&nbsp; Follow on LinkedIn</a><a class="btn btn-outline-primary mb-2" href="{{ '/subscribe/' | relative_url }}">More ways to subscribe</a></p>

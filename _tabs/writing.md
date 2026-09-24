---
title: Writing
icon: fas fa-pen-nib
order: 1
---

{% assign series = site.data.series %}
<div class="writing-section series-box" id="series">
  <h2>Series: {{ series.name }}</h2>
  <p class="section-desc">{{ series.description }}</p>
  <ol>
  {% for part in series.parts %}
    {% assign match = site.posts | where_exp: "p", "p.slug == part.slug" | first %}
    <li>{% if match %}<a href="{{ match.url | relative_url }}">{{ part.title }}</a>{% else %}{{ part.title }} <small class="writing-empty">· coming soon</small>{% endif %}</li>
  {% endfor %}
  </ol>
</div>

{% assign sections = site.data.sections %}
{% for sec in sections %}
<div class="writing-section" id="{{ sec.slug }}">
  <h2>{{ sec.name }}</h2>
  <p class="section-desc">{{ sec.description }}</p>
  {% assign posts = site.categories[sec.name] %}
  {% if posts and posts.size > 0 %}
  <ul>
    {% for post in posts %}
    <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a> <small class="text-muted">· {{ post.date | date: "%b %-d, %Y" }}</small></li>
    {% endfor %}
  </ul>
  {% else %}
  <p class="writing-empty">Coming soon.</p>
  {% endif %}
</div>
{% endfor %}

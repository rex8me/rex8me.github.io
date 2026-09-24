---
layout: page
title: Subscribe
permalink: /subscribe/
---

Get new articles, including each new part of **[From Answers to Outcomes]({{ '/series/' | relative_url }})**, as soon as they're published.

## Follow on LinkedIn

Every new article is announced on LinkedIn, with a short summary of what it covers.

<p><a class="btn btn-primary" href="https://www.linkedin.com/in/abinaya-govindan-59088311a/" target="_blank" rel="noopener"><i class="fab fa-linkedin"></i>&nbsp; Follow on LinkedIn</a></p>

## Use a feed reader

If you use a feed reader, subscribe in one click:

<p>
  <a class="btn btn-outline-primary me-2 mb-2" href="https://feedly.com/i/subscription/feed/{{ '/feed.xml' | absolute_url | url_encode }}" target="_blank" rel="noopener">Subscribe in Feedly</a>
  <a class="btn btn-outline-primary mb-2" href="https://www.inoreader.com/?add_feed={{ '/feed.xml' | absolute_url | url_encode }}" target="_blank" rel="noopener">Subscribe in Inoreader</a>
</p>

Or copy the feed address into any reader:

<div class="feed-copy">
  <code id="feed-url">{{ '/feed.xml' | absolute_url }}</code>
  <button type="button" class="btn btn-sm btn-outline-secondary" id="feed-copy-btn">Copy</button>
</div>

<script>
  document.getElementById('feed-copy-btn').addEventListener('click', function () {
    var url = document.getElementById('feed-url').textContent;
    var btn = this;
    navigator.clipboard.writeText(url).then(function () {
      btn.textContent = 'Copied';
      setTimeout(function () { btn.textContent = 'Copy'; }, 1500);
    });
  });
</script>

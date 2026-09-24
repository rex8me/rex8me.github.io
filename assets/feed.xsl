<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>RSS feed · <xsl:value-of select="atom:feed/atom:title"/></title>
        <style>
          :root { --bg:#fff; --fg:#1f2328; --muted:#59636e; --line:#d1d9e0; --accent:#0969da; --note:#f6f8fa; }
          @media (prefers-color-scheme: dark) { :root { --bg:#1b1b1e; --fg:#e6e6e6; --muted:#a0a0a8; --line:#3a3a40; --accent:#58a6ff; --note:#26262b; } }
          body { margin:0; background:var(--bg); color:var(--fg); font:16px/1.6 -apple-system, "Segoe UI", sans-serif; }
          main { max-width:720px; margin:0 auto; padding:40px 16px; }
          .note { background:var(--note); border:1px solid var(--line); border-radius:10px; padding:16px 18px; margin-bottom:28px; }
          .note strong { display:block; margin-bottom:4px; }
          a { color:var(--accent); }
          h1 { margin:0 0 4px; font-size:1.8rem; }
          .sub { color:var(--muted); margin:0 0 24px; }
          .entry { padding:14px 0; border-top:1px solid var(--line); }
          .entry a { font-weight:600; text-decoration:none; }
          .date { color:var(--muted); font-size:.85rem; }
          code { background:var(--bg); border:1px solid var(--line); border-radius:6px; padding:2px 6px; font-size:.9rem; word-break:break-all; }
        </style>
      </head>
      <body>
        <main>
          <div class="note">
            <strong>This is an RSS feed.</strong>
            Copy this page's address into a feed reader (like Feedly or Inoreader) to get new posts automatically.
            See <a href="/subscribe/">all the ways to follow along</a>.
          </div>
          <h1><xsl:value-of select="atom:feed/atom:title"/></h1>
          <p class="sub"><xsl:value-of select="atom:feed/atom:subtitle"/></p>
          <xsl:choose>
            <xsl:when test="atom:feed/atom:entry">
              <xsl:for-each select="atom:feed/atom:entry">
                <div class="entry">
                  <a href="{atom:link/@href}"><xsl:value-of select="atom:title"/></a>
                  <div class="date"><xsl:value-of select="substring(atom:published,1,10)"/></div>
                </div>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise><p class="sub">No posts yet. The first one is on its way.</p></xsl:otherwise>
          </xsl:choose>
          <p><a href="/">← Back to the site</a></p>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

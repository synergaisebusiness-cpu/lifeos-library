#!/usr/bin/env python3
"""Render a LifeOS briefing markdown file into a styled, phone-friendly dark HTML
document. Dependency-optional: uses the `markdown` package if installed (prettier),
otherwise falls back to a safe minimal converter. Usage:
    render_briefing.py <in.md> <out.html>
"""
import sys, html, re

CSS = """
:root{--bg:#0e1116;--card:#171b22;--line:#2a303a;--tx:#e6e9ee;--mut:#95a0b0;
--grn:#3fb950;--red:#f85149;--amb:#d29922;--blu:#58a6ff;--accent:#7c9cff;}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--tx);
font:16px/1.6 -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;
-webkit-font-smoothing:antialiased}
.wrap{max-width:720px;margin:0 auto;padding:22px 18px 70px}
h1{font-size:24px;margin:0 0 14px;line-height:1.25}
h2{font-size:16px;margin:30px 0 10px;color:var(--accent);text-transform:uppercase;
letter-spacing:.06em;border-bottom:1px solid var(--line);padding-bottom:6px}
h3{font-size:15px;margin:20px 0 6px;color:var(--tx)}
p{margin:9px 0} ul,ol{margin:9px 0;padding-left:22px} li{margin:5px 0}
a{color:var(--blu);text-decoration:none} a:hover{text-decoration:underline}
code{background:var(--card);padding:1px 5px;border-radius:5px;font-size:13px}
strong{color:#fff}
hr{border:0;border-top:1px solid var(--line);margin:20px 0}
blockquote{margin:10px 0;padding:6px 14px;border-left:3px solid var(--accent);
color:var(--mut);background:var(--card);border-radius:0 8px 8px 0}
.foot{color:var(--mut);font-size:12px;margin-top:30px;border-top:1px solid var(--line);padding-top:14px}
"""

BULLET_RE = re.compile(r'^\s*[-*]\s+')
HEAD_RE = re.compile(r'^(#{1,3})\s+(.*)')
LINK_RE = re.compile(r'\[([^\]]+)\]\((https?://[^\)]+)\)')
BOLD_RE = re.compile(r'\*\*([^*]+)\*\*')
CODE_RE = re.compile(r'`([^`]+)`')


def inline(s):
    s = html.escape(s)
    s = LINK_RE.sub(r'<a href="\2">\1</a>', s)
    s = BOLD_RE.sub(r'<strong>\1</strong>', s)
    s = CODE_RE.sub(r'<code>\1</code>', s)
    return s


def convert(md_text):
    try:
        import markdown  # type: ignore
        return markdown.markdown(md_text, extensions=["extra", "sane_lists", "nl2br"])
    except Exception:
        out, in_ul = [], False
        for raw in md_text.splitlines():
            line = raw.rstrip()
            m = HEAD_RE.match(line)
            if m:
                if in_ul:
                    out.append("</ul>"); in_ul = False
                lvl = len(m.group(1))
                out.append("<h%d>%s</h%d>" % (lvl, inline(m.group(2)), lvl))
            elif BULLET_RE.match(line):
                if not in_ul:
                    out.append("<ul>"); in_ul = True
                item = BULLET_RE.sub('', line)
                out.append("<li>%s</li>" % inline(item))
            elif line.strip() == "":
                if in_ul:
                    out.append("</ul>"); in_ul = False
            else:
                if in_ul:
                    out.append("</ul>"); in_ul = False
                out.append("<p>%s</p>" % inline(line))
        if in_ul:
            out.append("</ul>")
        return "\n".join(out)


def main():
    if len(sys.argv) < 3:
        print("usage: render_briefing.py <in.md> <out.html>", file=sys.stderr)
        sys.exit(2)
    with open(sys.argv[1], encoding="utf-8") as f:
        md_text = f.read()
    body = convert(md_text)
    doc = (
        "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\">"
        "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        "<title>LifeOS Briefing</title><style>" + CSS + "</style></head>"
        "<body><div class=\"wrap\">" + body +
        "<p class=\"foot\">LifeOS market-briefing · informational only, not financial "
        "advice · scoped to your holdings' sectors, no personal figures.</p></div></body></html>"
    )
    with open(sys.argv[2], "w", encoding="utf-8") as f:
        f.write(doc)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Rebuild dashboard.html from register.json + dashboard_template.html.
Usage: python3 build_dashboard.py <company-health-dir>
"""
import sys, os
d = sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(os.path.abspath(__file__)) + "/.."
data = open(os.path.join(d, "register.json")).read()
tpl = open(os.path.join(d, "dashboard_template.html")).read()
assert "__DATA__" in tpl, "template placeholder missing"
open(os.path.join(d, "dashboard.html"), "w").write(tpl.replace("__DATA__", data))
print("dashboard.html rebuilt")

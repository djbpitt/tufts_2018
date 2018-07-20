import sys #i/o
import re
# purpose: parse a meta data file and convert to XML

# Read the file.
file = sys.stdin

text = file.read()
file.close()

lines = text.split("\n")

xmlText = "<?xml version='1.0' encoding='utf-8'?>\n<meta>\n"

for l in lines:
    l = l.strip()
    garbage = re.split("\w", l)[0]
    l = l.replace(garbage, "")
    if l == "" or l == " ":
        continue
    element = l.split("=")[0].strip()
    l = l.replace(element + "=", "")
    element = element.replace(" ", "-")
    element = element.replace("/", "-")
    element = element.replace("(", "")
    element = element.replace(")", "")
    l = l.replace("&", "&amp;")
    l = l.replace("<", "&lt;")
    l = l.replace(">", "&gt;")
    startTag = "<" + element + ">"
    endTag = "</" + element + ">"
    tag = str(startTag + l + endTag).strip() + '\n'
    xmlText += tag

xmlText += "</meta>"

print(xmlText)
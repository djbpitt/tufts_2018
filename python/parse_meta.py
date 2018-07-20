import sys #i/o
# purpose: parse a meta data file and convert to XML

# Read the file.
file = sys.stdin

text = file.read()
file.close()

lines = text.split("\n")

xmlText = "<?xml version='1.0' encoding='utf-8'?> \n <meta>"

for l in lines:
    if l == "" or l == " ":
        continue
    element = l.split("=")[0]
    l = l.replace(element + "=", "")
    startTag = "<" + element + ">"
    endTag = "</" + element + ">"
    tag = str(startTag + l + endTag + '\n')
    xmlText += tag

xmlText += "</meta>"

print(xmlText)
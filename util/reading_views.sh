#!/usr/bin/env bash

for inputDir in sources/*/tt/*; do
  out=$(basename $(dirname $(dirname $inputDir)))
  echo "$out"
  java -jar /opt/saxon/saxon9he.jar -s:$inputDir -xsl:util/tt_to_html.xsl -o:"reading_views/$out"
done

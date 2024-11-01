#!/bin/zsh

echo "Minifying CSS"
for file in $(find $1 -type f -name "*.css")
do
    original_size=$(stat -f%z "$file")

    bunx esbuild $file --minify --outfile=$file --allow-overwrite --log-level=warning

    new_size=$(stat -f%z "$file")
    percent_change=$(( 100 * (original_size - new_size) / original_size ))

    echo " - $file Original: $(numfmt --to=iec-i --suffix=B $original_size), New: $(numfmt --to=iec-i --suffix=B $new_size), % Change: $percent_change%"
done

echo "Minifying JS"
for file in $(find $1 -type f -name "*.js")
do
    original_size=$(stat -f%z "$file")

    bunx esbuild $file --minify --outfile=$file --allow-overwrite --log-level=warning

    new_size=$(stat -f%z "$file")
    percent_change=$(( 100 * (original_size - new_size) / original_size ))

    echo " - $file Original: $(numfmt --to=iec-i --suffix=B $original_size), New: $(numfmt --to=iec-i --suffix=B $new_size), % Change: $percent_change%"
done

# Khan's Blog

This is open source for fun! I won't be accepting PRs or issues on styling, but if you find a typo or a bug please let me know!


### Prism Config:

- https://prismjs.com/download.html#themes=prism&languages=clike+javascript+bash+javadoclike+jsdoc+json+json5+matlab+swift+typescript+yaml&plugins=line-numbers+toolbar+copy-to-clipboard


### Sizes

To find the compressed size of the entire site (only JS, CSS, HTML):
```bash
find .html -type f \( -name "*.html" -o -name "*.js" -o -name "*.css" \) -print0 | xargs -0 -I{} sh -c 'zstd --stdout "{}" | wc -c' | awk '{total+=$1} END {print "Total compressed size:", total, "bytes"}'
```


For the uncompressed size:
```bash
find .html -type f \( -name "*.html" \) -print0 | xargs -0 du -c --si | grep total
```

Grouping and Aggregating
========================================

jq allows to group an array of objects by a key and get aggregated values for the other keys

`group_by(.foo)` takes as input an array, groups the elements having the same `.foo` field into separate arrays, and produces all of these arrays as elements of a larger array, sorted by the value of the `.foo` field.

Any jq expression, not just a field access, may be used in place of .foo.

```
$ cat data/products.json \
      | jq 'group_by(.category)'
```

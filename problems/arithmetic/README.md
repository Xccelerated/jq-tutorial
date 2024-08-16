Arithmethics
========================================

We can also manipulate items in jq by adding or subtracting existing 
objects or values. We could for example add one to each a object:
```bash
$ cat data/add.json |
    | jq 'map({a: (a + 1), b})'
```
Or add a new object to the existing json:
```bash
$ cat data/add.json |
    | jq 'map(. + {c: (.a + 3)})'
```
Or subtract elements from a list:
```bash
echo '["xml", "yaml", "json"]' | jq '. - ["xml", "yaml"]'
```

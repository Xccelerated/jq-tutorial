Adding to objects
========================================

We can also manipulate items in jq by adding or adjusting existing 
objects. We could for example add one to each a object:
```bash
$ cat data/add.json |
    | jq 'map({a: (a + 1), b})'
```
Or add a new object to the existing json:
```bash
$ cat data/add.json |
    | jq 'map(. + {c: (.a + 3)})'
```


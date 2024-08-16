Zipping
========================================

Another operation with could prove useful with json is zipping. An example of 
zipping is the following, let's assume we have data like this:
```json
[
    [
        "id",
        "first_name",
        "last_name"
    ],
    [
        1
        "Matthijs",
        "Brouns"
    ],
    [
        2
        "Gary",
        "Clark"
    ],
]
```

We would like to change this data to this:
```json
[
    {
        "id": 1,
        "first_name": "Matthijs",
        "last_name": "Brouns"
    },
    {
        "id": 2,
        "first_name": "Gary",
        "last_name": "Clark"
    }
]
```
Basically we are zipping up multiple items into new items and in this keys, changing
it into objects rather than arrays.

Tip: [with_entries](https://jqlang.github.io/jq/manual/#to_entries-from_entries-with_entries) might be useful


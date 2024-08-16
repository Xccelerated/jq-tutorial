Functions
========================================

It is also possible to define functions in jq, although this is is a feature whose biggest use is defining jq's standard library (many jq functions such as map and select are in fact written in jq).

For example, you can create a custom function to calculate the average price of products


```bash
def avg_price: 
  reduce .[] as $p (0; . + $p.price) / length; 
  avg_price 
```

note that you will have to pass functions in a single line in this interactive environment:

```bash
def avg_price: reduce .[] as $p (0; . + $p.price) / length; avg_price
```

We can also pass arguments to functions:
```bash
def my_func(arg): arg as $arg | other stuf...
```

# Exercise

_Swap argument names_

```
function F1($arg1, $arg2, $arg3) {
  return 1
}
```

Notes:

- arguments 1 and 2 can be easily swapped by navigating to start of first argument and typing `dWWP`.
- the last argument requires another approach:
  - fg
  - diw
  - fg
  - viwp
  - F,
  - P

_Swap function content_

```

function F1() {
  return 1
}

function F2() {
  return 2
}

```

Notes:

- Cut line in one smooth roll from right hand to left hand (r-shift, v, x)
- Replace and cut line in one smooth roll (r-shift, v, p)

_Swap function location_

```

function F1() {
  return 1
}

function F2() {
  return 2
}

```

Notes:

- from top to bottom
  - dap
  - }P
- from bottom to top
  - dap
  - {{P

_Delete all 'bar's_

```
foo bar foo foo bar bar foo foo bar foo
```

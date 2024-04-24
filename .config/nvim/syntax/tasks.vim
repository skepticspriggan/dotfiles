if exists("b:current_syntax")
    finish
endif

syntax match TodoDone '^x\s.\+$'
syntax match TodoPriorityA '^(A)\s.\+$'
syntax match TodoPriorityB '^(B)\s.\+$'
syntax match TodoPriorityC '^(C)\s.\+$'
syntax match TodoProject '\(^\|\W\)+[^[:blank:]]\+'
syntax match TodoContext '\(^\|\W\)@[^[:blank:]]\+'

highlight default link TodoDone Comment
highlight default link TodoPriorityA Identifier
highlight default link TodoPriorityB statement
highlight default link TodoPriorityC type
highlight default link TodoProject Special
highlight default link TodoContext Constant

let b:current_syntax = "tasks"

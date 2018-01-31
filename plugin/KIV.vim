scriptencoding utf-8

if exists('g:loaded_KIV')
    finish
endif
let g:loaded_KIV = 1

call KIV#KIV#KIVboot()
command KIV :call KIV#KIV#KIVboot()

finish

"#! -- Copyright (c) 2016-2018 ooblog --
"#! License: MIT　https://github.com/ooblog/TSF3KEV/blob/master/LICENSE

set encoding=utf-8
scriptencoding utf-8
let s:KIV_scriptdir = expand('<sfile>:p:h')

if !exists('g:loaded_KIV')
    finish
endif
let g:loaded_KIV = 1

"「KanjiInputVim」の起動。
function! KIV#KIV#KIVboot()
    call KIVsetup('[を',']ん','-〜','-ー')
"call KIVsetup('[を',']ん','-〜','-ー') "JIS
"call KIVsetup('[、',']。','-〜','-ー') "US
endfunction

"「KanjiInputVim」の初期化。KIVmap読込。
function! KIVsetup(inputkey,findkey,hiraganakey,katakanakey)
    let s:KIV_inputESCs = {"\t":"<Tab>",' ':"<Space>",'<':"<lt>",'\':"<Bslash>",'|':"<Bar>",'-':"<Minus>",'.':"<Point>"}
    let s:KIV_menuESCs = "\t\\:|< >.-"
    let s:KIV_findESCs = ".*[]^%/\?~$"
    let s:KIV_inputkeys = ['1','2','3','4','5','6','7','8','9','0','-','q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','[',']','z','x','c','v','b','n','m',',','.','/']
    let s:KIV_findkeys = ['!','"','#','$','%','&',"'",'(',')','~','=','Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','{','}','Z','X','C','V','B','N','M','<','>','?']
    let s:KIV_kanmapkeysX = ["1あ","2い","3う","4え","5お","6か","7き","8く","9け","0こ","-〜","qさ","wし","eす","rせ","tそ","yた","uち","iつ","oて","pと","aな","sに","dぬ","fね","gの","hや","jゆ","kよ","lわ","[を","]ん","zま","xみ","cむ","vめ","bも","nら","mり",",る",".れ","/ろ"]
    let s:KIV_kanmapkeysL = len(s:KIV_kanmapkeysX)
    let s:KIV_kanmapkeysY = s:KIV_kanmapkeysX[:]
    let s:KIV_kanmapkeysY += ["1ぁ","2ぃ","3ぅ","4ぇ","5ぉ","6が","7ぎ","8ぐ","9げ","0ご","-ゔ","qざ","wじ","eず","rぜ","tぞ","yだ","uじ","iづ","oで","pど","aは","sひ","dふ","fへ","gほ","hゃ","jゅ","kょ","lっ","[、","]。","zば","xび","cぶ","vべ","bぼ","nぱ","mぴ",",ぷ",".ぺ","/ぽ"]
    let s:KIV_kanmapkeysY += ["1ア","2イ","3ウ","4エ","5オ","6カ","7キ","8ク","9ケ","0コ","-ー","qサ","wシ","eス","rセ","tソ","yタ","uチ","iツ","oテ","pト","aナ","sニ","dヌ","fネ","gノ","hヤ","jユ","kヨ","lワ","[ヲ","]ン","zマ","xミ","cム","vメ","bモ","nラ","mリ",",ル",".レ","/ロ"]
    let s:KIV_kanmapkeysY += ["1ァ","2ィ","3ゥ","4ェ","5ォ","6ガ","7ギ","8グ","9ゲ","0ゴ","-ヴ","qザ","wジ","eズ","fゼ","tゾ","yダ","uヂ","iヅ","oデ","pド","aハ","sヒ","dフ","fヘ","gホ","hャ","jュ","kョ","lッ","[「","]」","zバ","xビ","cブ","vベ","bボ","nパ","mピ",",プ",".ペ","/ポ"]
    let s:KIV_inputkey = count(s:KIV_kanmapkeysY,a:inputkey) ? a:inputkey : '[を'
    let s:KIV_findkey = count(s:KIV_kanmapkeysY,a:findkey) ? a:findkey : ']ん'
    let s:KIV_hiraganakey = count(s:KIV_kanmapkeysY,a:hiraganakey) ? a:hiraganakey : '-〜'
    let s:KIV_katakanakey = count(s:KIV_kanmapkeysY,a:katakanakey) ? a:katakanakey : '-ー'
    let s:KIV_mapkey = s:KIV_hiraganakey
    let s:KIV_mapkeyid = index(s:KIV_kanmapkeysY,s:KIV_mapkey)
    let s:KIV_mapkeyidbuf = s:KIV_mapkeyid
    let s:KIV_dickeydefset = ['英','名','異','簡','繁','越','地','逆','非','代','俗','顔','照','送','音','訓','活','漫','筆','幅']
    let s:KIV_dickeydef = '＊'
    let s:KIV_dickey = s:KIV_dickeydef
    let s:KIV_kanmap = {}
    :for s:kanmapkey in s:KIV_kanmapkeysY
        let s:KIV_kanmap[s:kanmapkey] = s:KIV_inputkeys
    :endfor
    let s:KIV_kanmap[s:KIV_inputkey] = s:KIV_inputkeys
    let s:KIV_kanmap[s:KIV_findkey] = s:KIV_findkeys
    let s:KIV_kanmap[s:KIV_hiraganakey] = s:KIV_kanmapkeysY[len(s:KIV_kanmapkeysX)*0:len(s:KIV_kanmapkeysX)*1]
    let s:KIV_kanmap[s:KIV_katakanakey] = s:KIV_kanmapkeysY[len(s:KIV_kanmapkeysX)*2:len(s:KIV_kanmapkeysX)*3]
    let s:KIV_kanmapfilepath = s:KIV_scriptdir . "/KIVmap.tsf"
    :if filereadable(s:KIV_kanmapfilepath)
        :for s:kanmapfileline in readfile(s:KIV_kanmapfilepath)
            let s:kanmaplinelist = (stridx(s:kanmapfileline,"\t") >= 0) ? split(s:kanmapfileline,"\t") : [kanmapfileline]
            :if count(s:KIV_kanmapkeysY,s:kanmaplinelist[0])
                let s:KIV_kanmap[s:kanmaplinelist[0]] = s:kanmaplinelist[1:]
                :if len(s:kanmaplinelist) < len(s:KIV_kanmapkeysX)
                    let s:KIV_kanmap[s:kanmaplinelist[0]] += s:KIV_inputkey[(len(s:KIV_kanmapkeysX)-len(s:kanmaplinelist)):(len(s:KIV_kanmapkeysX))]
                :endif
                :if s:kanmaplinelist[0] == s:KIV_inputkey
                    let s:KIV_inputkeys = s:KIV_kanmap[s:kanmaplinelist[0]]
                :endif
                :if s:kanmaplinelist[0] == s:KIV_findkey
                    let s:KIV_findkeys = s:KIV_kanmap[s:kanmaplinelist[0]]
                :endif
            :endif
        :endfor
    :endif
    let s:KIV_kandic = {}
    let s:KIV_kandicfilepath = s:KIV_scriptdir . "/KIVdic.tsf"
    :if filereadable(s:KIV_kandicfilepath)
        :for s:kandicfileline in readfile(s:KIV_kandicfilepath)
            :if stridx(s:kandicfileline,"\t") >= 0
                let s:kandiclinelist = split(s:kandicfileline,"\t")
                let s:KIV_kandic[s:kandiclinelist[0]] = join(s:kandiclinelist,"\t")
            :endif
        :endfor
    :endif
    map <silent> <Space><Space> a
    vmap <silent> <Space><Space> <Esc>
    imap <silent> <Space><Space> <Esc>
    imap <silent> <Space><Enter> <C-V><Space>
    imap <silent> <S-Space> <C-o>?<Enter>
    execute "imap <silent> <Space><Tab> <C-o><Plug>(KIVmap" . s:KIV_hiraganakey . ")"
    execute "imap <silent> <Space><S-Tab> <C-o><Plug>(KIVmap" . s:KIV_katakanakey . ")"
    execute "imap <silent> <Space><S-Space> <C-o><Plug>(KIVdic" . s:KIV_dickeydef . ")"
    execute "noremap <Plug>(KIVdic" . s:KIV_dickeydef . ") :call KIVdic('" . s:KIV_dickeydef . "')<Enter>"
    :for s:inputkey in range(len(s:KIV_kanmapkeysX))
        execute "imap <silent> <Space>" . s:KIV_findkeys[s:inputkey] . " <C-o><Plug>(KIVdic" . s:KIV_kanmapkeysX[s:inputkey] . ")"
        execute "noremap <Plug>(KIVdic" . s:KIV_kanmapkeysX[s:inputkey] . ") :call KIVdic('" . s:KIV_kanmapkeysX[s:inputkey] . "')<Enter>"
    :endfor
    :for s:inputkey in range(len(s:KIV_kanmapkeysY))
        execute "noremap <Plug>(KIVmap" . s:KIV_kanmapkeysY[s:inputkey] . ") :call KIVmap('" . s:KIV_kanmapkeysY[s:inputkey] . "')<Enter>"
    :endfor
    execute "noremap <Plug>(KIVchar) :call KIVhelp('KIVdic.tsf')<Enter>"
    call KIVpullmenu(1)
    let s:KIV_menuid = 10000
    let s:KIV_menumap = "【&Kanji" . "(&K)"
    let s:KIV_menumapid = s:KIV_menuid+0
    let s:KIV_menudic = "&Input" . "(&I)"
    let s:KIV_menudicid = s:KIV_menuid+1
    let s:KIV_menuhelp = "KIV(&V)】"
    let s:KIV_menuhelpid = s:KIV_menuid+2
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".51 " . s:KIV_menuhelp . ".取説「KIVreadme\\.md」を開く(&M) <Plug>(KIVreadme)"
    execute "noremap <Plug>(KIVreadme) :call KIVhelp('KIVreadme.md')<Enter>"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".60 " . s:KIV_menuhelp . ".-sep_find- :"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".61 " . s:KIV_menuhelp . ".ファイル履歴を開く(&H) <Plug>(KIVfiler)"
    execute "noremap <Plug>(KIVfiler) :call KIVfiler()<Enter>"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".70 " . s:KIV_menuhelp . ".-sep_dicfle- :"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".71 " . s:KIV_menuhelp . ".漢直鍵盤「KIVmap\\.tsf」を開く(&M) <Plug>(KIVkanmap)"
    execute "noremap <Plug>(KIVkanmap) :call KIVhelp('KIVmap.tsf')<Enter>"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".72 " . s:KIV_menuhelp . ".単漢字辞書「KIVdic\\.tsf」を開く(&T) <Plug>(KIVchar)"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".75 " . s:KIV_menuhelp . ".KanjiInputVim本体「KIV\\.vim」を開く(&V) <Plug>(KIVsource)"
    execute "noremap <Plug>(KIVsource) :call KIVhelp('KIV.tsf')<Enter>"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".80 " . s:KIV_menuhelp . ".-sep_dic- :"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . "." . (89) . " " . s:KIV_menuhelp . ".字引項目を「" . escape(s:KIV_dickeydef,s:KIV_menuESCs) . "」へ解除(&Z) :call KIVdic('" . s:KIV_dickeydef . "')<Enter>"
    :for s:defset in range(len(s:KIV_dickeydefset))
        execute "amenu  <silent> " . (s:KIV_menuhelpid) . "." . (90+s:defset) . " " . s:KIV_menuhelp . ".字引項目を「" . escape(s:KIV_dickeydefset[s:defset],s:KIV_menuESCs) . "」に設定" . (s:defset<16?printf("(&%X)",s:defset):"") . " :call KIVdic('" . s:KIV_dickeydefset[s:defset] . "')<Enter>"
    :endfor
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".110 " . s:KIV_menuhelp . ".-sep_filer- :"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".111 " . s:KIV_menuhelp . ".JISキーボード" . ((s:KIV_inputkey=='[を')&&(s:KIV_findkey==']ん')?"✓":"で再開") . "(&J) <Plug>(KIVsetupUS)"
    execute "noremap <Plug>(KIVsetupUS) :call KIVsetup('[を',']ん','-〜','-ー')<Enter>"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".112 " . s:KIV_menuhelp . ".USキーボード" . ((s:KIV_inputkey=='[、')&&(s:KIV_findkey==']。')?"✓":"で再開") . "(&U) <Plug>(KIVsetupJIS)"
    execute "noremap <Plug>(KIVsetupJIS) :call KIVsetup('[、',']。','-〜','-ー')<Enter>"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".115 " . s:KIV_menuhelp . ".-sep_quit- :"
    execute "amenu  <silent> " . (s:KIV_menuhelpid) . ".118 " . s:KIV_menuhelp . ".KIV終了(&Q) <Plug>(KIVexit)"
    execute "noremap <Plug>(KIVexit) :call KIVexit()<Enter>"
    call KIVpushmenu()
endfunction

"メニューなどの構築。
function! KIVpushmenu()
    let s:KIV_menumap = escape("【" . s:KIV_mapkey . "(&K)",s:KIV_menuESCs)
    let s:KIV_menudic = escape(";" . s:KIV_dickey . "(&I)",s:KIV_menuESCs)
    let s:KIV_mapkeyid = index(s:KIV_kanmapkeysY,s:KIV_mapkey)
    :for s:inputkey in range(len(s:KIV_kanmapkeysX))
        let s:dicchar = KIVpeek(s:KIV_kanmap[s:KIV_mapkey][s:inputkey],s:KIV_dickey)
        let s:dicVchar = " "
        :for s:Vchar in split(s:dicchar, '\zs')
            let s:dicVchar = s:dicVchar . printf("<C-V>U%08x",char2nr(s:Vchar))
        :endfor
        let s:mapKchar = s:KIV_kanmapkeysY[s:KIV_mapkeyid/s:KIV_kanmapkeysL*len(s:KIV_kanmapkeysX)+s:inputkey]
        :if s:KIV_mapkeyid%s:KIV_kanmapkeysL == s:inputkey
            let s:mapkeyiddaku = s:KIV_mapkeyid/s:KIV_kanmapkeysL
            let s:mapkeyidkata = (s:mapkeyiddaku/2*2+(s:mapkeyiddaku+1)%2)*s:KIV_kanmapkeysL+s:inputkey
            :if s:KIV_mapkeyid%s:KIV_kanmapkeysL == s:KIV_mapkeyidbuf%s:KIV_kanmapkeysL
                let s:mapkeyidkata = ((s:mapkeyiddaku+1)%4)*s:KIV_kanmapkeysL+s:inputkey
            :endif
            let s:mapKchar = s:KIV_kanmapkeysY[s:mapkeyidkata]
        :endif
        execute "amenu  <silent> " . s:KIV_menumapid . "." . (s:inputkey+10) . " " . s:KIV_menumap . ".&\\" . s:mapKchar . ((s:KIV_mapkeyid%len(s:KIV_kanmapkeysX)==s:inputkey)?"✓":"") . " <Plug>(KIVmap" . s:mapKchar . ")"
        execute "nmenu  <silent> " . s:KIV_menumapid . "." . (s:inputkey+10) . " " . s:KIV_menumap . ".&\\" . s:mapKchar . ((s:KIV_mapkeyid%len(s:KIV_kanmapkeysX)==s:inputkey)?"✓":"") . " a<C-o><Plug>(KIVmap" . s:mapKchar . ")"
        execute "imap <silent> <Space>" . s:KIV_inputkeys[s:inputkey] . " <C-o><Plug>(KIVmap" . s:mapKchar . ")"
        execute "imenu  <silent> " . s:KIV_menudicid . "." . (s:inputkey+10) . " " . s:KIV_menudic . ".&" . escape(s:KIV_inputkeys[s:inputkey],s:KIV_menuESCs) . "\\" . escape(substitute(s:dicchar,"&","&&","g"),s:KIV_menuESCs) . " " . s:KIV_inputkeys[s:inputkey]
        execute "imap <silent> " . s:KIV_inputkeys[s:inputkey] . s:dicVchar
        execute "imap <silent> " . s:KIV_findkeys[s:inputkey] . " <C-o>/" . escape(substitute(s:dicchar,"|","<bar>","g"),s:KIV_menuESCs) . "<Enter>"
    :endfor
    let s:KIV_mapkeyidbuf = s:KIV_mapkeyid

"    execute "imenu  <silent> " . (s:KIV_menumapid) . ".95 " . s:KIV_menumap . ".-sep_menumap- :"
"    execute "imenu  <silent> " . (s:KIV_menudicid) . ".89 " . s:KIV_menudic . ".-sep_menudic- :"
endfunction

"鍵盤変更(清濁平片)。
function! KIVmap(KIV_keyX)
    let s:KIV_mapkey = a:KIV_keyX
    call KIVpullmenu(0)
    call KIVpushmenu()
endfunction

"辞書変更。
function! KIVdic(KIV_keyX)
    let s:KIV_dickey = index(s:KIV_kanmapkeysX,a:KIV_keyX)>=0 ? s:KIV_kanmap[s:KIV_mapkey][index(s:KIV_kanmapkeysX,a:KIV_keyX)] :a:KIV_keyX
    call KIVpullmenu(0)
    call KIVpushmenu()
endfunction

"単漢字辞書読込
function! KIVpeek(KIV_dicC,KIV_dicL)
    let s:dicpeek = len(a:KIV_dicC) ? a:KIV_dicC : "　"
    let s:dicltsv = get(s:KIV_kandic,a:KIV_dicC,a:KIV_dicC)
    let s:dicposL = stridx(s:dicltsv,"\t" . a:KIV_dicL . ":")
    :if 0 < s:dicposL
        let s:dicposL = stridx(s:dicltsv,":",s:dicposL)+1
        let s:dicposR = stridx(s:dicltsv,"\t",s:dicposL)
        let s:dicpeekC = strpart(s:dicltsv,s:dicposL,s:dicposR-s:dicposL)
        let s:dicpeek = len(s:dicpeekC) ? s:dicpeekC : s:dicpeek
    :else
        :if a:KIV_dicL == "照"
            let s:dicpeek = printf("&#%d;",char2nr(s:dicpeek))
        :endif
    :endif
    :return s:dicpeek
endfunction

"メニューの撤去。
function! KIVpullmenu(KIV_exit)
    :if !a:KIV_exit
        execute "aunmenu  <silent> " . s:KIV_menumap
        execute "iunmenu  <silent> " . s:KIV_menudic
"        execute "iunmenu  <silent> " . s:KIV_menuhelp  #ウィンドウサイズが変わる恐れがあるので右端メニューは消さない。
    :else
        :if exists("s:KIV_menumap")
            execute "aunmenu  <silent> " . s:KIV_menumap
            unlet! s:KIV_menumap
        :endif
        :if exists("s:KIV_menudic")
            execute "iunmenu  <silent> " . s:KIV_menudic
            unlet! s:KIV_menudic
        :endif
        :if exists("s:KIV_menuhelp")
            execute "aunmenu  <silent> " . s:KIV_menuhelp
            unlet! s:KIV_menuhelp
        :endif
    :endif
endfunction

"「KanjiInputVim」の撤去。
function! KIVexit()
    call KIVpullmenu(1)
    vunmap <silent> <Space><Space>
    unmap <silent> <Space><Space>
    iunmap <silent> <Space><Space>
    iunmap <silent> <Space><Enter>
    iunmap <silent> <S-Space>
    iunmap <silent> <Space><Tab>
    iunmap <silent> <Space><S-Tab>
    iunmap <silent> <Space><S-Space>
    :for s:inputkey in range(len(s:KIV_kanmapkeysX))
        execute "iunmap <silent> " . s:KIV_inputkeys[s:inputkey]
        execute "iunmap <silent> " . s:KIV_findkeys[s:inputkey]
    :endfor
endfunction

"履歴ファイラー。
function! KIVfiler()
    cd $HOME
    let s:dirline = expand('%:p:h')
    execute "cd " . s:dirline
    let s:filelines = ["",s:dirline] + v:oldfiles
    let s:filelabels = ["ファイル履歴(01でフォルダ選択)※履歴はウィンドウの高さに合わせます。"]
    :for s:labelno in range(1,len(s:filelines)-2)
         let s:filelabels = s:filelabels + [ printf("%02d",s:labelno) . ":" . s:filelines[s:labelno] ]
    :endfor
    let s:filechoice = inputlist(s:filelabels[:max([1,min([&lines-2,len(s:filelabels)])])])
    :while 0 < s:filechoice && s:filechoice < len(s:filelines)
        echo "\n"
        :if isdirectory(s:filelines[s:filechoice])
            execute "cd " . s:filelines[s:filechoice]
            let s:dirline = getcwd()
        :elseif filereadable(s:filelines[s:filechoice])
            execute "enew"
            execute "e " . s:filelines[s:filechoice]
            :break
        :else
            echo "リーダブルではないファイルです「" . s:filelines[s:filechoice] . "」"
        :endif
        let s:filelines = ["",".."] + split(expand("./*"),"\n")
        let s:filelabels = ["「" . s:dirline . "」(01で親フォルダ選択)※ファイルクリックはズレるので注意。"]
        :for s:labelno in range(1,len(s:filelines)-1)
             let s:filelabels = s:filelabels + [ printf("%02d",s:labelno) . ":" . s:filelines[s:labelno] ]
        :endfor
        let s:filechoice = inputlist(s:filelabels)
    :endwhile
endfunction

"ファイル読込。
function! KIVhelp(KIV_text)
    let s:KIV_helpfilepath = s:KIV_scriptdir . "/" . a:KIV_text
    :if !filereadable(s:KIV_helpfilepath)
        let s:KIV_helpfilepath = s:KIV_scriptdir . "/KIV.vim"
    :endif
    :if filereadable(s:KIV_helpfilepath)
        execute "enew"
        execute "e " . s:KIV_helpfilepath . " | :se ro"
    :endif
endfunction

finish

"#! -- Copyright (c) 2016-2018 ooblog --
"#! License: MIT　https://github.com/ooblog/KIV/blob/master/LICENSE
        execute "amenu  <silent> " . s:KIV_menumapid . "." . (s:inputkey+10) . " " . s:KIV_menumap . ".&\\" . s:KIV_kanmapkeysX[s:inputkey] . " <Plug>(KIVmap" . s:KIV_kanmapkeysX[s:inputkey] . ")"
        execute "imap <silent> <Space>" . s:KIV_inputkeys[s:inputkey] . " <C-o><Plug>(KIVmap" . s:KIV_kanmapkeysX[s:inputkey] . ")"

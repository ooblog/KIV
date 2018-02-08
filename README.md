# 漢字直接入力＆漢字直接検索Vimプラグイン「KanjiInputVim」(準備中)。


## KIV超ザックリ説明。

漢字直接入力(漢直)Vimプラグインです(開発中)。  
KIVは約２ストローク(鍵盤切替時のスペース入力はSandSすなわちシフト扱い)のかな入力で、漢字変換を用いず直接漢字などが入力できます(予定)。  
独自のかな配列を用いる事で、USキーボード買ったのに設定はJISキーボード状態の様な混在環境(括弧の位置などがUSキーボードとJISキーボードでズレます)でも日本語入力できます。  

&#35;!	1あ 2い 3う 4え 5お 6か 7き 8く 9け 0こ -〜  
&#35;!	qさ wし eす rせ tそ yた uち iつ oて pと  
&#35;!	aな sに dぬ fね gの hや jゆ kよ lわ [を ]ん  
&#35;!	zま xみ cむ vめ bも nら mり ,る .れ /ろ  
&#35;!	1ぁ 2ぃ 3ぅ 4ぇ 5ぉ 6が 7ぎ 8ぐ 9げ 0ご -ゔ  
&#35;!	qざ wじ eず rぜ tぞ yだ uじ iづ oで pど  
&#35;!	aは sひ dふ fへ gほ hゃ jゅ kょ lっ [、 ]。  
&#35;!	zば xび cぶ vべ bぼ nぱ mぴ ,ぷ .ぺ /ぽ  
&#35;!	1ア 2イ 3ウ 4エ 5オ 6カ 7キ 8ク 9ケ 0コ -ー  
&#35;!	qサ wシ eス rセ tソ yタ uチ iツ oテ pト  
&#35;!	aナ sニ dヌ fネ gノ hワ jヲ kヤ lユ [ヨ ]ン  
&#35;!	zマ xミ cム vメ bモ nラ mリ ,ル .レ /ロ  
&#35;!	1ァ 2ィ 3ゥ 4ェ 5ォ 6ガ 7ギ 8グ 9ゲ 0ゴ -ヴ  
&#35;!	qザ wジ eズ rゼ tゾ yダ uヂ iヅ oデ pド  
&#35;!	aハ sヒ dフ fヘ gホ hャ jュ kョ lッ [「 ]」  
&#35;!	zバ xビ cブ vベ bボ nパ mピ ,プ .ペ /ポ  

KIVかな配列の外にある記号入力はJIS配列,US配列,Dvorak風配列の使い分けで補う形に。


## 既存のIMEおよびその他の漢直系日本語入と違う所。

漢字入力だけではなく漢字検索機能があります。  
Vimの機能でも一文字検索は存在しますが(fコマンドなど)同じ一行内移動です。しかも半角限定。  
KIVの漢直検索ならモードの切替無しに(厳密には&lt;C-o&gt;/を用いて)複数行間を一文字検索できます。しかも全角前提。  
IMEを起動しないのでモード切替時に全角半角キーを押す手間が不要。  
そのモード切替自体も「map &lt;silent&gt; &lt;Space&gt;&lt;Space&gt; a」「imap &lt;silent&gt; &lt;Space&gt;&lt;Space&gt; &lt;Esc&gt;」でEscもCtrlも不使用。ホームポジションが崩れるのを予防。  


## 操作一覧予定表(ToDo)。

☑&lt;Space&gt;&lt;Space&gt;	Vimの挿入モード切替  
☑&lt;Space&gt;&lt;Enter&gt;	半角スペース入力  
☑a-z	漢字入力([漢直鍵盤kanmap.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanmap.tsf "KIV3/KIV3_kanmap.tsf at master · ooblog/KIV3"))/字引項目があれば字引漢直([単漢字辞書kanchar.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanchar..tsf "KIV3/KIV3_kanchar..tsf at master · ooblog/KIV3"))  
☑A-Z	一文字検索下方向(&lt;C-o&gt;/)  
☑&lt;S-Space&gt;	一文字検索上方向(&lt;C-o&gt;?)  
☑&lt;Space&gt;a-z	鍵盤変更/清濁変更/かなカタ変更([漢直鍵盤kanmap.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanmap.tsf "KIV3/KIV3_kanmap.tsf at master · ooblog/KIV3"))  
☑&lt;Space&gt;&lt;Tab&gt;	ひらがな鍵盤に変更([漢直鍵盤kanmap.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanmap.tsf "KIV3/KIV3_kanmap.tsf at master · ooblog/KIV3"))  
☑&lt;Space&gt;&lt;S-Tab&gt;	カタカナ鍵盤に変更([漢直鍵盤kanmap.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanmap.tsf "KIV3/KIV3_kanmap.tsf at master · ooblog/KIV3"))  
☑&lt;Space&gt;A-Z	字引項目の変更([単漢字辞書kanchar.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanchar..tsf "KIV3/KIV3_kanchar..tsf at master · ooblog/KIV3"))  
☑&lt;Space&gt;&lt;S-Enter&gt;	字引項目自体の代入  
☑&lt;Space&gt;&lt;S-Space&gt;	字引項目の解除  
☐&lt;Space&gt;&lt;Esc&gt;a-z		[漢直鍵盤kanmap.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanmap.tsf "KIV3/KIV3_kanmap.tsf at master · ooblog/KIV3")上書き編集/[単漢字辞書kanchar.tsf](https://github.com/ooblog/KIV3/blob/master/autoload/KIV3_kanchar..tsf "KIV3/KIV3_kanchar..tsf at master · ooblog/KIV3")上書き編集  


## 拡張子TSFってTSVと何が違うの？

TSFはプログラミング言語「TSF_Tab-Separated-Forth」の拡張子です。  
詳しくは「[https://github.com/ooblog/TSF3KIV](https://github.com/ooblog/TSF3KIV "ooblog/TSF3KIV: プログラミング言語「TSF_Tab-Separated-Forth」開発準備(ver3草案)。")」などを参考。  
当初はTSFでエディタから作る予定だったけどVim版作った方が速かったのでVimプラグインとして独立。  


## ライセンス・著作権など。

&#35;! -- Copyright (c) 2016-2018 ooblog --  
&#35;! License: MIT　https://github.com/ooblog/KIV/blob/master/LICENSE  

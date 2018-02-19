# 漢字直接入力＆漢字直接検索Vimプラグイン「KanjiInputVim」(開発中)。


## KIV超ザックリ説明。

漢字直接入力(漢直)Vimプラグインです。  
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


## 既存のIMEおよびその他の漢直系日本語入力と違う所。

### 鍵盤切替

一般的な漢直は一文字２ストローク以上ですが、KIVはアルファベットひらがなカタカナ入力時などで鍵盤切替が発生しない場合１ストロークコンボを稼げるので期待値２ストローク未満に。  
(鍵盤切替時のスペース入力はSandSすなわち親指シフトキー換算で１ストロークにまとめる)  


### 漢字直接検索

Vimの機能でも一文字検索は存在しますが(fコマンドなど)同じ一行内移動です。しかも半角限定。  
KIVの漢直検索ならモードの切替無しに(厳密には&lt;C-o&gt;/を用いて)複数行間を一文字検索できます。しかも全角前提。  


### 漢字直接字引

単漢字辞書で漢直でも異体字を扱える予定。  
字引入力では単語も扱えるので地名入力の時にショートカットできるかも。  


### 全角半角Escキー不要

Vimの場合通常モードでの半角操作hjklなどが頻発します。  
KIVはOSのIMEを経由しないのでモード切替時の全角半角キーを押し直す手間が不要。  
そのモード切替自体も親指操作「map &lt;silent&gt; &lt;Space&gt;&lt;Space&gt; a」「imap &lt;silent&gt; &lt;Space&gt;&lt;Space&gt; &lt;Esc&gt;」でホームポジション崩れを予防。  


## 操作一覧予定表(ToDo)。

☑&lt;Space&gt;&lt;Space&gt;	Vimの挿入モード通常モード切替  
☑&lt;Space&gt;&lt;Enter&gt;	半角スペース入力  
☑&lt;Space&gt;&lt;S-Enter&gt;	全角スペース入力  
☑a-z	漢字入力([漢直鍵盤KIVmap.tsf](https://github.com/ooblog/KIV/blob/master/autoload/KIVmap.tsf "KIV3/KIVmap.tsf at master · ooblog/KIV3"))/字引項目があれば字引漢直([単漢字辞書KIVdic.tsf](https://github.com/ooblog/KIV/blob/master/autoload/KIVdic.tsf "KIV3/KIVdic.tsf at master · ooblog/KIV3"))  
☑A-Z	一文字検索下方向(&lt;C-o&gt;/)  
☑&lt;S-Space&gt;	一文字検索上方向(&lt;C-o&gt;?)  
☑&lt;Space&gt;a-z	挿入モード/ひらカタ鍵盤変更  
☑&lt;Space&gt;&lt;Tab&gt;	大小アルファベット鍵盤変更  
☑&lt;Space&gt;:	清濁ひらがな鍵盤変更  
☑&lt;Space&gt;;	清濁カタカナ鍵盤変更  
☑&lt;Space&gt;A-Z	字引項目の変更  
☑&lt;Space&gt;&lt;S-Space&gt;	字引項目の解除  
☐&lt;Space&gt;&lt;BS&gt;	 文字列置換([フレーズ辞書KIVphrase.tsf](https://github.com/ooblog/KIV/blob/master/autoload/KIVphrase.tsf "KIV3/KIVphrase.tsf at master · ooblog/KIV3"))  
☑&lt;Space&gt;&lt;Esc&gt;a-z		漢直鍵盤書き換え  


### 字引項目一覧(配置はブランチ毎に変わる場合があります)。

英	4え2	文字の名称(英語)を字引。もしくは漢字の英訳などを字引(和英)。  
名	aな-	文字の名称(日本語)を字引。  
異	2い-	異体字や俗字や略字や通用や大字などを表示。  
簡	6か&#93;	中国およびシンガポ—ルやマレ—シアなどの簡体字を字引。  
繁	aは&#93;	中国および台湾や香港などの繁体字(正体字)を字引。  
越	0こr	ベトナム(越南)のチュノム(字喃)を字引。  
地	uちv	国名や地名や名字などを字引。  
逆	7ぎh	反対の意味の漢字を字引。全角ではないという意味で半角ｶﾀｶﾅ等の入力にも流用。  
非	sひw	似て非なる意味の漢字を字引。  
代	yた2	濁音半濁音拗音促音入力補佐やロシア語以外のキリル文字など、似た文字での代用による字引入力。麻雀牌も。  
俗	tぞ8	当て字や送り仮名だけでは説明不足になりそうな使用例・例文などを字引。  
顔	6か5	顔文字などの１行AAや絵文字を字引。  
照	oてn	HTMLの文字参照。辞書に無い文字は数値文字参照で補う。  
訓	8く&#93;	漢字の訓読みを字引。原子記号だと音訓両方を字引。  
音	5お&#93;	漢字の音読みを字引。原子記号だとカタカナを字引。  
送	tそ3	漢字の送り仮名を字引。  
熙	7キw	康熙部首コードを字引。康熙部首だと部首名を字引。  
活	6かi	kan5x5dotフォント(グリフ)を字引。  
漫	zま6	kan5x5comicフォント(グリフ)を字引。  
筆	dふo	kan5x5brushフォント(グリフ)を字引。  
幅	aはz	kan5x5フォント幅を字引。  


## 相席について。

魑魅魍魎など特定の熟語でしか使わないような組み合わせの漢字は読みが遠くても同じ鍵盤にまとめてストローク数の削減を試みます。  


### 相席一覧(配置はブランチ毎に頻繁に変わる場合があります)。

宇宙	3ぅui  
男女	5おpa  
漢字	wじ&#91;&#93;  
味噌	xミty  
飛翔	sひhj  
挨拶	1ア23  
魑魅魍魎	uヂxcvb  


## 拡張子TSFってTSVと何が違うの？

TSFはプログラミング言語「TSF_Tab-Separated-Forth」の拡張子です。  
詳しくは「[https://github.com/ooblog/TSF3](https://github.com/ooblog/TSF3 "ooblog/TSF3KIV: プログラミング言語「TSF_Tab-Separated-Forth」開発準備(ver3草案)。")」などを参考。  
当初はTSFでエディタから作る予定だったけどVim版作った方が速かったのでVimプラグインとして独立。  


## ライセンス・著作権など。

&#35;! -- Copyright (c) 2016-2018 ooblog --  
&#35;! License: MIT　https://github.com/ooblog/KIV/blob/master/LICENSE  

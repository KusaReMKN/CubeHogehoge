# Debian の日本語化

**`vim` と `fbterm` の相性が良くないらしく度々フリーズします！ 実際に行う場合は様子を見ながら！**

## -1. お願い

**私も勉強中です。**
おそらく、この文書には隠し味のように至る所に *間違いや怪しさ* がちりばめられています。

この文書に間違いに気づいたら、なんか適当に修正して Pull Request 投げてください。
気づき次第、即座に修正します。
多分。


## 0. 前提

[Debian をインストールする](./index.md) の続きです。
`fbterm` が立ち上がっている前提で話をします。

vim を使う技能があることを前提とします。

## 1. 必要パッケージのインストール

いっぱいインストールします。
初めて `sudo` を利用すると*戒め*が表示されるので読みましょう。

`vim` はテキストエディタです。
`uim-fep` と `uim-anthy` は日本語入力に必要です。

```bash
$ sudo apt update
$ sudo apt upgrade

$ sudo apt install vim

$ sudo apt install uim-fep
$ sudo apt install uim-anthy
```

ついでに前回の尻拭いをします。
以下を実行してグループ video にユーザを追加します。

```
$ sudo usermod -aG video ユーザ名
```

## 2. 日本語入力の設定

設定ファイルを編集します。

```
$ vim ~/.uim
```

内容は以下の通り:

```
(define default-im-name 'anthy)
(define-key generic-on-key? '("<Control> "))
(define-key generic-off-key? '("<Control> "))
```

保存したら以下を実行して日本語入力ができるか確かめます。
日本語入力の ON/OFF を切り替えるには \[Ctrl\] + \[Space\] を押します。

```
$ uim-fep
$ echo こんにちは
$ exit
```

## 3. tty の切り替え

`.bashrc` の編集を行うときは**多重ログイン**を絶対にしてください。
さもないと `.bashrc` を編集して正しく起動できなくなったときに取り返しがつかなくなります。

多重ログインをするために tty を切り替えます。
tty を切り替えるには \[Alt\] を押しながら \[F1\] から \[F6\] のいずれかを押します。
おそらく、今ログインしている tty は tty1 なので、いまから tty2 に切り替えてログインをします。
\[Alt\] + \[F2\] を押します。
ログイン画面が表示されるのでログインします。
ログイン後は tty1 に戻してください。

![切り替えアニメーション](./img/ani10.gif)


## 4. `~/.bashrc` と `~/.profile` の編集

まずは `~/.profile` に以下を追加します。

```bash
if [ "$TERM" = "linux" ] ; then
	# パレットの設定
	echo -en "\e]P0222222" #black
	echo -en "\e]P8222222" #darkgray
	echo -en "\e]P1803232" #darkgray
	echo -en "\e]P9982b2b" #red
	echo -en "\e]P25b762f" #darkgreen
	echo -en "\e]PA89b83f" #green
	echo -en "\e]P3aa9943" #brown
	echo -en "\e]PBefef60" #yellow
	echo -en "\e]P4324c80" #darkblue
	echo -en "\e]PC2b4f98" #blue
	echo -en "\e]P5706c9a" #darkmagenta
	echo -en "\e]PD826ab1" #magenta
	echo -en "\e]P692b19e" #darkcyan
	echo -en "\e]PEa1cdcd" #cyan
	echo -en "\e]P7ffffff" #lightgray
	echo -en "\e]PFdedede" #white

	export FBTERM=1
	fbterm -- uim-fep # 本当は exec したいけどなぜか動いてくれない
fi
```

次に `~/.bashrc` に以下を追加

```bash
case "$TERM" in
    linux)
        [ -n "$FBTERM" ] && export TERM=fbterm
        ;;
    fbterm)
        #何もしない
        ;;
    *)
        export TERM="xterm-256color"
esac
```

## 5. 完成

これで取り合えず日本語表示と日本語入力ができる環境ができました。

**実はうまくいってないけど。**
上の `~/.profile` の不穏なコメントの箇所がどうしても未解決です。
誰か助けてください。


## 6. 参考文献

- [fbtermの日本語表示．uim-fepとuim-anthyで日本語入力も．ついでに，vimの256色化も](https://qiita.com/Pseudonym/items/12e447557a5234bb265b)

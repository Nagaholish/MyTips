# MyTips
MyTips Collection

## bash のプロンプト表示の変更

.bashrc に
>export PS1='/u /w /t'

のように定義する

参考
- https://qiita.com/zaburo/items/9194cd9eb841dea897a0

使える変数はこのあたり
- https://atmarkit.itmedia.co.jp/flinux/rensai/linuxtips/002cngprmpt.html

git-bashは
>{git-bash}/etc/profile.d/git-prompt.sh

を書き換えると調整できる

<pre>
PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'\[\033[32m\]'       # change to green
	PS1="$PS1"'\u@\h '             # user@host<space>
	PS1="$PS1"'\[\033[35m\]'       # change to purple
	PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
	PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
	PS1="$PS1"'\w'                 # current working directory
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[36m\]'  # change color to cyan
			PS1="$PS1"'`__git_ps1`'   # bash function
		fi
	fi
	PS1="$PS1"'\[\033[0m\]'        # change color
	PS1="$PS1"' \D{%Y/%m/%d} \t'   # !!!! 時間表示 !!!!!
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'$ '                 # prompt: always $
</pre>

コマンドラインでの書き換え方がわからなかったので、代案を記す
prompt コマンドを使う
>prompt $d$s$t$s$g

参考
- https://selifelog.com/blog-entry-1594.html

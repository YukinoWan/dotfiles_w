#
# Executes commands at the start of an interactive session.
#

# Colors
autoload -Uz colors && colors

# Theme
TERM='xterm-256color'
LS_COLORS=':no=00:fi=00:di=36:ln=35:pi=33:so=32:bd=34;46:cd=34;43:ex=31:'
LSCOLORS=gxfxcxdxbxegexabagacad

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=${HOME}/.zsh_history

# Don't regard these chars as delimeter
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Less
LESS="-i -M -R -x4"
PAGER="less"

# Options
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt auto_cd               # ディレクトリ名だけでcdする
setopt auto_param_slash      # ディレクトリ名を補完すると末尾に/を追加する
setopt auto_pushd            # cd したら自動的にスタックに入れる
setopt auto_remove_slash     # 補完による/の追加を、続く文字により削除する
setopt brace_ccl             # 範囲指定できるように 例) mkdir {1-3} で フォルダ1,2,3を作れる
setopt combiningchars
setopt complete_in_word      # 語の途中でもカーソル位置で補完
# setopt auto_correct          # 補完時にスペルチェック
# setopt correct               # スペルミスを補完
# setopt correct_all           # コマンドライン全てのスペルチェックをする
setopt extended_glob         # 高機能なワイルドカード展開を使用する
setopt extended_history      # 履歴ファイルに zsh の開始・終了時刻を記録する
setopt function_argzero      # シェル関数やスクリプトの source 実行時に、$0 を一時的にその関数スクリプト名にセットする
setopt glob_complete
setopt globdots              # ドットファイルを*で選択する
setopt hist_expand           # 補完時にヒストリを自動的に展開
setopt hist_ignore_dups      # 直前と同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups  # 過去に同じ履歴が存在する場合、古い履歴を削除する
setopt hist_ignore_space     # スペースで始まるコマンド行はヒストリリストから削除 (→ 先頭にスペースを入れておけば、ヒストリに保存されない)
setopt hist_reduce_blanks    # ヒストリに保存するときに余分なスペースを削除する
setopt ignore_eof            # C-d でzshを終了しない
setopt list_packed           # コンパクトに補完リストを表示
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示(訳注: ls -F の記号)
setopt long_list_jobs        # 内部コマンド jobs の出力をデフォルトで jobs -L にする
setopt magic_equal_subst     #  --prefix=~/localというように「=」の後でも「~」や「=コマンド」などのファイル名展開を行う
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt no_beep               # コマンド入力エラーでBeepを鳴らさない
setopt no_nomatch            # グロブ展開でnomatchにならないようにする
setopt numeric_glob_sort     # 数字を数値と解釈してソートする
setopt path_dirs             # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt pushd_ignore_dups     # 重複したディレクトリを追加しない
setopt pushd_silent          # pushd と popdでスタック表示を抑制
setopt pushd_to_home         # 引数なしの pushd は pushd $HOME になる
unsetopt promptcr            # 改行のない出力をプロンプトで上書きするのを防ぐ
# setopt prompt_subst          # プロンプトを表示する度にPROMPT変数内で変数参照する
setopt prompt_subst
# setopt prompt_percent
setopt print_eight_bit       # 日本語ファイル名を表示可能にする
setopt rm_star_wait          # rm * を実行する前に確認
# setopt short_loops           # FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる # 使い方よく分からない
setopt sun_keyboard_hack     # 行の末尾がバッククォートでも無視する
setopt nohup                 # シェルが終了しても SIGHUP を job に送らない
setopt transient_rprompt     # コマンド実行後に右プロンプトを消す(?)

# 以下の3つはそれぞれ排他的なオプション
# setopt inc_append_history      # 履歴リストにイベントを登録するのと同時に、履歴ファイルにも書き込みを行う(追加する)。
# setopt inc_append_history_time # コマンド終了時に、履歴ファイルに書き込む
#                                # つまりコマンドの経過時間が正しく記録される
#                                # 逆に言うと `INC_APPEND_HISTORY` × `EXTENDED_HISTORY` の併用では**経過時間が全て0で記録される**
setopt share_history          # 各端末で履歴(ファイル)を共有する = 履歴ファイルに対して参照と書き込みを行う。
                              # 書き込みは 時刻(タイムスタンプ) 付き


# Aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --color=auto'
alias h='history'
alias gomi='rm -f *~'
alias -g A='| awk'
alias -g H='| head'
alias -g Hn='| head -n'
alias -g T='| tail'
alias -g Tn='| tail -n'
alias -g G='| grep'
alias -g Gv='| grep -v'
alias -g W='| wc'
alias -g X='| xargs'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -- -='cd -'


# Completion
## initialize
autoload -U compinit && compinit -C

## Fuzzy match
### https://gihyo.jp/dev/serial/01/zsh-book/0005 を参考
### 補完候補がなければより曖昧に候補を探す
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する
### l:|=*: 入力文字の前にワイルドカード「*」があるものとして補完する
### r:|?=**: 各入力文字の前後に「*」があるものとして補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}' '+r:|[-_.]=**' '+l:|=*' '+r:|?=**'

zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true


# History search
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end


# Replace string
autoload -Uz replace-string
zle -N replace-string
bindkey "^[%" replace-string


# Using Emacs key bindings
bindkey -d  # reset
bindkey -e
bindkey "^[f" emacs-forward-word
bindkey "^[b" emacs-backward-word


# Suppress C-s
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi


# Auto ls after changing directory
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _ls_abbrev
# https://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059
_ls_abbrev() {
  local MAX_LINUM=20
  if [[ ! -r $PWD ]]; then
    return
  fi
  local LS_COLOR_OPT
  case "${OSTYPE}" in
  linux*|cygwin*)
    LS_COLOR_OPT='--color=always'
    ;;
  freebsd*|darwin*)
    LS_COLOR_OPT='-G'
    ;;
  esac

  # -C : Force multi-column output.
  # -F : Append indicator (one of */=>@|) to entries.
  local ls_result=$(CLICOLOR_FORCE=1 COLUMNS=${COLUMNS} command ls -ACF ${LS_COLOR_OPT} | sed $'/^\e\[[0-9;]*m$/d')
  local ls_lines=$(echo "${ls_result}" | wc -l | tr -d ' ')

  if [[ ${ls_lines} -gt ${MAX_LINUM} ]]; then
    echo "${ls_result}" | head -3
    echo '...'
    echo "${ls_result}" | tail -3
    echo "$(command ls -1UA | wc -l | tr -d ' ') files exist"
  else
    echo "${ls_result}"
  fi
}



# LOAD SETTING FILES
source ${ZSHHOME}/.zshrc

#
# kurolab
#
if [ -d /mnt/berry/home ]; then
    source ${HOME}/dotfiles/zsh.d/kurolab/.zshrc
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/agnoster-zsh-theme/agnoster.zsh-theme
source /Users/zhenwan/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

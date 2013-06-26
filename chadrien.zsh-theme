###
### symbols
###

# segments
[ -z "$SEGMENT_SEPARATOR" ] && SEGMENT_SEPARATOR=''
[ -z "$RSEGMENT_SEPARATOR" ] && RSEGMENT_SEPARATOR=''

## git
[ -z "$GIT_CLEAN_SYMBOL" ] && GIT_CLEAN_SYMBOL='%F{black}✔'
[ -z "$GIT_DIRTY_SYMBOL" ] && GIT_DIRTY_SYMBOL='%F{black}✘'
[ -z "$GIT_ADDED_SYMBOL" ] && GIT_ADDED_SYMBOL='%F{black}✚'
[ -z "$GIT_MODIFIED_SYMBOL" ] && GIT_MODIFIED_SYMBOL='%F{black}✹'
[ -z "$GIT_DELETED_SYMBOL" ] && GIT_DELETED_SYMBOL='%F{black}✖'
[ -z "$GIT_UNTRACKED_SYMBOL" ] && GIT_UNTRACKED_SYMBOL='%F{black}✭'
[ -z "$GIT_RENAMED_SYMBOL" ] && GIT_RENAMED_SYMBOL='➜'
[ -z "$GIT_UNMERGED_SYMBOL" ] && GIT_UNMERGED_SYMBOL='═'
[ -z "$GIT_AHEAD_SYMBOL" ] && GIT_AHEAD_SYMBOL='↑'
[ -z "$GIT_BEHIND_SYMBOL" ] && GIT_BEHIND_SYMBOL='↓'

# misc
[ -z "$STATUS_BACKGROUND_SYMBOL" ] && STATUS_BACKGROUND_SYMBOL='⚙'

###
### configuration
###

# git
[ -z "$GIT_DEFAULT_REMOTE" ] && GIT_DEFAULT_REMOTE='origin'
[ -z "$GIT_DEFAULT_BRANCH" ] && GIT_DEFAULT_BRANCH='master'

# misc
[ -z "$DATE_FORMAT" ] && DATE_FORMAT="%D{%d-%m-%Y} %D{%H:%M}"

ZSH_THEME_GIT_PROMPT_DIRTY=" $GIT_DIRTY_SYMBOL"
ZSH_THEME_GIT_PROMPT_CLEAN=" $GIT_CLEAN_SYMBOL"
ZSH_THEME_GIT_PROMPT_ADDED=" $GIT_ADDED_SYMBOL"
ZSH_THEME_GIT_PROMPT_MODIFIED=" $GIT_MODIFIED_SYMBOL"
ZSH_THEME_GIT_PROMPT_DELETED=" $GIT_DELETED_SYMBOL"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" $GIT_UNTRACKED_SYMBOL"
ZSH_THEME_GIT_PROMPT_RENAMED=" $GIT_RENAMED_SYMBOL"
ZSH_THEME_GIT_PROMPT_UNMERGED=" $GIT_UNMERGED_SYMBOL"

CURRENT_BG='NONE'
CURRENT_RBG='NONE'

segment_display() {
  local fg bg

  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi

  CURRENT_BG=$1

  [[ -n $3 ]] && echo -n $3
}

rsegment_display() {
  local bg fg

  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  if [[ $CURRENT_RBG == 'NONE' ]]
  then
    echo -n "%{%F{$1}%}$RSEGMENT_SEPARATOR%{$fg$bg%} "
  else
    echo -n "$RSEGMENT_SEPARATOR"
  fi

  CURRENT_BG=$1

  [[ -n $3 ]] && echo -n "$3 "
}

segment_stop() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

git_segment() {
  local git_status ref branch bgcolor dirty hash position remote rbranch

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1)
  then
    git_status=''
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    branch="${ref/refs\/heads\//}"
    dirty=$(git status -s)
    hash=$(git log -n1 --pretty="%h")
    position=''
    remote=$(git config branch.$branch.remote)
    [ -z $remote ] && remote="origin"
    rbranch=$(git config branch.$branch.merge)
    rbranch="${rbranch/refs\/heads\//}"
    [ -z $rbranch ] && rbranch=$GIT_DEFAULT_BRANCH

    if [ -z "$dirty" ]
    then
      bgcolor="green"
    else
      bgcolor="yellow"
    fi

    if [ $(git branch -r | grep -E "^\s*$remote/$branch$") ]
    then
      ahead=$(git log --pretty=oneline $remote/$rbranch..$branch | wc -l | tr -d ' ')
      behind=$(git log --pretty=oneline $branch..$remote/$rbranch | wc -l | tr -d ' ')

      if [ $ahead -gt 0 -o $behind -gt 0 ]
      then
        position="("
        [ $ahead -gt 0 ] && position="$position$GIT_AHEAD_SYMBOL$ahead"
        [ $behind -gt 0 ] && position="$position$GIT_BEHIND_SYMBOL$behind"
        position="$position)"
      fi
    fi

    git_status="$git_status$(parse_git_dirty) $branch$position@$hash$(git_prompt_status)"

    $1 $bgcolor black $git_status
  fi
}

date_segment() {
  $1 blue black $DATE_FORMAT
}

user_segment() {
  $1 black default "%n"
}

dir_segment() {
  $1 blue black "%~"
}

status_segment() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="✘ $RETVAL"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="$STATUS_BACKGROUND_SYMBOL"

  [[ -n "$symbols" ]] && $1 red white "$symbols"
}

build_prompt() {
  RETVAL=$?

  local left_prompt

  left_prompt=(user dir git)

  foreach plugin ($left_prompt) "$plugin"_segment 'segment_display'; end;

  segment_stop
}

build_rprompt() {
  RETVAL=$?

  local right_prompt

  right_prompt=(date status)

  foreach plugin ($right_prompt)  "$plugin"_segment 'rsegment_display'; end;
}

build_cmd_prompt() {
  CURRENT_BG='NONE'
  segment_display black default "$ %{%k%F{black}%}$SEGMENT_SEPARATOR"
}

PROMPT='%{%f%b%k%}$(build_prompt)
$(build_cmd_prompt)%{%f%k%b%} '
RPROMPT='%{%f%b%k%}$(build_rprompt)'

# vim:ft=zsh ts=2 sw=2 sts=2

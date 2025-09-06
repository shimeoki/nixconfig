#!/usr/bin/env bash

# source: https://github.com/3timeslazy/nix-search-tv/blob/main/nixpkgs.sh

# to run SHELL_CMD with the user's preferred shell
USER_SHELL="$SHELL"

# to ensure forked processes also run with bash
SHELL="bash"

declare -a INDEXES=(
    "nixpkgs P"
    "nixos N"
    "home-manager H"
    "all A"
)

# because i use ctrl for most of the builtin binds, use shift here
SNIPPETS_KEY="G"
SOURCE_KEY="S"
HOMEPAGE_KEY="O"
SHELL_KEY="L"
PREVIEW_KEY="V"

OPENER="xdg-open"
if [[ "$(uname)" == 'Darwin' ]]; then
    OPENER="open"
fi

OPEN="xargs $OPENER"

CMD="${NIX_SEARCH_TV:-nix-search-tv}"

bind_index() {
    local key="$1"
    local index="$2"

    local prompt=""
    local indexes_flag=""
    if [[ -n "$index" && "$index" != "all" ]]; then
        indexes_flag="--indexes $index"
        prompt=$index
    fi

    local preview="$CMD preview $indexes_flag"
    local print="$CMD print $indexes_flag"

    echo "$key:change-prompt($prompt> )+change-preview($preview {})+reload($print)"
}

STATE_FILE="/tmp/nix-search-tv-fzf"
READ_STATE="\$(cat $STATE_FILE)"

# save_state saves the currently displayed index
# to the $STATE_FILE. This file serves as an external script state
# for communication between "print" and "preview" commands
save_state() {
    local index="$1"

    local indexes_flag=""
    if [[ -n "$index" && "$index" != "all" ]]; then
        indexes_flag="--indexes $index"
    fi

    echo "execute(echo $indexes_flag > $STATE_FILE)"
}

HEADER="actions: \
$HOMEPAGE_KEY - homepage, \
$SOURCE_KEY - source, \
$SNIPPETS_KEY - snippets, \
$SHELL_KEY - shell, \
$PREVIEW_KEY - preview
indexes: "

FZF_BINDS=""
for e in "${INDEXES[@]}"; do
    index=$(echo "$e" | awk '{ print $1 }')
    keybind=$(echo "$e" | awk '{ print $2 }')

    fzf_bind=$(bind_index "$keybind" "$index")
    fzf_save_state=$(save_state "$index")
    FZF_BINDS="$FZF_BINDS --bind '$fzf_bind+$fzf_save_state'"

    HEADER="$HEADER$keybind - $index, "
done

# remove comma and space from the last index
HEADER="${HEADER%??}"

# reset the state
echo "" >/tmp/nix-search-tv-fzf

SNIPPETS_URL="\"https:://github.com/search?type=code&q=lang:nix+%s\""
SNIPPETS_CMD=$'echo "{}"'
# fzf surrounds the matched package with ', trim them
SNIPPETS_CMD="$SNIPPETS_CMD | tr -d \"\'\""
# if it's multi-index search, then we need to remove the prefix
SNIPPETS_CMD="$SNIPPETS_CMD | awk \'{ if (\$2) { print \$2 } else print \$1 }\'"
SNIPPETS_CMD="$SNIPPETS_CMD | xargs printf $SNIPPETS_URL \$1 "

# we want this expression to expand at the moment of execution
# shellcheck disable=SC2016
SHELL_PKG='$(echo "{}" | sed "s:nixpkgs/ ::g"'
# fzf surronds the replaced string with quotes
SHELL_PKG="$SHELL_PKG | tr -d \"\'\"\ )"

SHELL_CMD="nix shell nixpkgs#$SHELL_PKG --command $USER_SHELL"

eval "$CMD print | fzf \
    --preview '$CMD preview $READ_STATE {}' \
    --bind '$SOURCE_KEY:execute($CMD source $READ_STATE {} | $OPEN)' \
    --bind '$HOMEPAGE_KEY:execute($CMD homepage $READ_STATE {} | $OPEN)' \
    --bind $'$SNIPPETS_KEY:execute($SNIPPETS_CMD | $OPEN)' \
    --bind $'$SHELL_KEY:become($SHELL_CMD)' \
    --bind $'$PREVIEW_KEY:become($CMD preview $READ_STATE {})' \
    --scheme history \
    --header '$HEADER' --header-first \
    $FZF_BINDS
"

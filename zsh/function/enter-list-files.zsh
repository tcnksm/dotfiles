function _show-git-status() {
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        git status -sb
    fi
    return 0
}

function _ls-abbrev() {
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-CF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 5 ]; then
        echo "$ls_result" | head -n 3
    else
        echo "$ls_result"
    fi
}

function _enter-list-files() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi

    _ls-abbrev
    echo 

    _show-git-status
    echo 
    
    zle reset-prompt
    return 0
}

zle -N enter-list-files _enter-list-files
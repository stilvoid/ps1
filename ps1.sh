source $(dirname "$BASH_SOURCE")/plugins.sh

do_plugins() {
    for plugin in ${ps1_plugins[@]}; do
        colour=${ps1_colours[$plugin]-37}

        output=$(eval $plugin)

        if [ -n "$output" ]; then
            colourise "$colour" "$output"
        fi
    done

    echo "\[\]"
}

prompt() {
    if [ -z "${ps1_preamble+x}" ]; then
        ps1_preamble="$(colourise "1;30" "---")\n"
    fi

    if [ -z "${ps1_prompt+x}" ]; then
        ps1_prompt="[\u@\h]$ "
    fi

    export PS1="${ps1_preamble}$(do_plugins)${ps1_prompt}"
    export PS2="... "
}

# Set some defaults
if [ -z "${ps1_plugins[@]+x}" ]; then
    ps1_plugins=(python_virtualenv node_virtualenv git_branch aws_profile location)
fi

if [ -z "${ps1_colours[@]+x}" ]; then
    declare -A ps1_colours=(
        [python_virtualenv]=34
        [node_virtualenv]=35
        [git_branch]=32
        [aws_profile]=33
        [location]="1;37"
    )
fi

PROMPT_COMMAND=prompt

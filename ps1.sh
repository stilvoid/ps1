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

last_prompt=""

prompt() {
    if [ -z "${ps1_prompt+x}" ]; then
        ps1_prompt="[\u@\h]$ "
    fi

    export PS1="${ps1_preamble}$(do_plugins)${ps1_prompt}"
}

# Set some defaults
if [ -z "${ps1_plugins[@]+x}" ]; then
    ps1_plugins=(python_virtualenv git_branch aws_profile location)
fi

if [ -z "${ps1_colours[@]+x}" ]; then
    declare -A ps1_colours=(
        [python_virtualenv]=34
        [git_branch]=32
        [aws_profile]=33
        [location]="1;37"
    )
fi

if [ -z "${ps1_preable+x}" ]; then
    ps1_preamble="$(colourise "1;30" "---")\n"
fi

PROMPT_COMMAND=prompt

source $(dirname "$BASH_SOURCE")/plugins.sh

do_plugins() {
    colourise "1;30" "---"

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
    export PS1="$(do_plugins)> "
}

# Set some defaults
if [ -z "${ps1_plugins[@]+x}" ]; then
    ps1_plugins=(git_branch aws_profile location)
fi

if [ -z "${ps1_colours[@]+x}" ]; then
    declare -A ps1_colours=(
        [git_branch]=32
        [aws_profile]=33
        [location]="1;37"
    )
fi

PROMPT_COMMAND=prompt

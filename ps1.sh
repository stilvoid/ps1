# Laziness is key
colourise() {
    echo -e "\033[$1m$2\033[0m"
}

git_branch() {
	gitbranch=$(git branch 2>/dev/null | grep "*" | awk '{print $2}')
	if [ -n "$gitbranch" ]; then
        echo git: $gitbranch
	fi
}

aws_profile() {
    if [ -n "$AWS_PROFILE" ]; then
        echo aws: $AWS_PROFILE
    fi
}

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

location() {
    echo "\u@\h:\w"
}

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

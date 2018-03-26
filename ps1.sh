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
    prompt=""
    for plugin in ${!ps1_plugins[@]}; do
        colour=${ps1_plugins[$plugin]}
        output=$(eval $plugin)

        if [ -n "$output" ]; then
            prompt+=$(colourise "$colour" "$output")
            prompt+="\n"
        fi
    done

    if [ -n "$prompt" ]; then
        echo -e "$prompt\033"
    fi
}

prompt() {
    echo -n '$(do_plugins)'
    colourise "1;37" "\u@\h:\w"
    echo "> "
}

if [ -z ${ps1_plugins+x} ]; then
    declare -A ps1_plugins=()
    ps1_plugins[git_branch]="36"
    ps1_plugins[aws_profile]="33"
fi

export PS1=$(prompt)

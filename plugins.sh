# Laziness is key
colourise() {
    echo -e "\033[$1m$2\033[0m"
}

git_branch() {
	gitbranch=$(git branch 2>/dev/null | grep "*" | awk '{print $2}')
	if [ -n "$gitbranch" ]; then
        tracking=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

        if [ -n "$tracking" ]; then
            left="$(git cherry HEAD "$tracking")"
            right="$(git cherry "$tracking" HEAD)"

            if [ -n "$left" -a -n "$right" ]; then
                state=" (<>)"
            elif [ -n "$left" ]; then
                state=" (<<)"
            elif [ -n "$right" ]; then
                state=" (>>)"
            fi
        fi

        echo git: ${gitbranch}${state}
	fi
}

aws_profile() {
    if [ -n "$AWS_PROFILE" ]; then
        echo aws: $AWS_PROFILE
    fi
}

location() {
    echo "\u@\h:\w"
}

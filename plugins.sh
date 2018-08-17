# Laziness is key
colourise() {
    echo -e "\033[$1m$2\033[0m"
}

git_branch() {
	gitbranch=$(git branch 2>/dev/null | grep "*" | awk '{print $2}')
	if [ -n "$gitbranch" ]; then
        changes="[$(git status -s | wc -l)]"
        if [ "$changes" == "[0]" ]; then
            changes=""
        fi

        tracking=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
        if [ -n "$tracking" ]; then
            left="$(git cherry HEAD "$tracking")"
            right="$(git cherry "$tracking" HEAD)"

            if [ -n "$left" -a -n "$right" ]; then
                state=" (<> $tracking)"
            elif [ -n "$left" ]; then
                state=" (<< $tracking)"
            elif [ -n "$right" ]; then
                state=" (>> $tracking)"
            fi
        fi

        echo git: ${gitbranch}${changes}${state}
	fi
}

aws_profile() {
    if [ -n "$AWS_PROFILE" ]; then
        region=$(aws configure get region)

        if [ -n "$region" ]; then
            region="($region)"
        fi

        echo aws: $AWS_PROFILE $region
    fi
}

python_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo virtualenv: $(basename $VIRTUAL_ENV)
    fi
}

location() {
    echo "cwd: \w"
}

ssh_location() {
    echo "location: \u@\h:\w"
}

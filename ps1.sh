# Wonderful git branch function
get_git_branch() {
	gitbranch=$(git branch 2>/dev/null | grep "*" | awk '{print $2}')
	if [ -n "$gitbranch" ]; then
		gitbranch="$gitbranch\n"
	fi
	echo $gitbranch
}

PS1+="$(get_git_branch)"
PS1='\[\033[0;37m\]\u@\h:\w\[\033[0m\]\n'
PS1+="> "

export PS1

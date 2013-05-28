ZSH=$HOME/Documents/Projects/oh-my-zsh
ZSH_THEME="gentoo"
DISABLE_CORRECTION="true"
plugins=(git osx)
source $ZSH/oh-my-zsh.sh

# based on https://gist.github.com/MattiSG/3076772
function brewv() {
    versions=$(brew versions $1)
    result=$(echo "$versions" | grep -m 1 $2) #-m 1 to stop as soon as possible

    if [[ $? = 0 ]]
    then
        commit=$(echo $result | cut -d ' ' -f 7)
        formula=$(echo $result | cut -d ' ' -f 8)

        cd /usr/local
        if [[ -e $formula ]]
        then brew unlink $1	# will fail if not already installed, hence the check above
        fi
        git checkout $commit $formula &&
        brew install $1 &&
        git reset HEAD $formula &&
        git checkout -- $formula
        cd - > /dev/null
        echo "$1 $2 installed."
        echo "You can now switch versions with 'brew switch $1 <version>'"
    else
        echo "$versions"
        echo
        echo "No version matching '$2' for '$1'"
        echo "Available versions have been printed above"
        exit 1
    fi
}

export LANG="en_US.UTF-8"
export DEV=$HOME/Documents/Projects
export GOROOT=$DEV/go
export GOBIN=$GOROOT/bin
export PYBIN=/usr/local/share/python
export PATH=$PATH:$GOBIN:$PYBIN

alias dev="$DEV" 
alias g="git"
alias ir="irssi"

alias erebor-dev="ssh ianoshen@erebor-dev"
alias erebor-svc="ssh ianoshen@erebor-svc"
alias erebor-rc="ssh ianoshen@erebor-rc"
alias balin="ssh ianoshen@balin"
alias theoden="ssh ianoshen@theoden"

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

source ~/.zshrc

# expand functions in the prompt
#setopt prompt_subst

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export INPUTRC=~/.inputrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

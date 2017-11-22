#!/bin/sh

# Run commands in ZSH shell
# https://superuser.com/questions/280927/usr-bin-env-interpreter-arguments-portable-scripts-with-arguments-for-the/280937#answer-280937

if [ -z "$IN_ZSH" ]; then
  export IN_ZSH=1
  exec zsh -f "$0" "$@"
fi

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  if [[ -L "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]]
  then
    echo " Skipped linking ${ZDOTDIR:-$HOME}/.${rcfile:t}"
  else
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  fi
done

# Change prompt
sed -i '' "s/theme 'sorin'/theme 'steeef'/" ${HOME}/.zpreztorc

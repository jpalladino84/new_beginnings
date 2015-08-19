#!/bin/bash -e
################################################################################
# This script provides a relatively automated setup of a fresh OSX machine.
# @anthonyjso
################################################################################
CODE=${HOME}/code

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# Install xcode command line tools.
# https://github.com/chcokr/osx-init/blob/master/install.sh
# https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
install_xcode_clt () {
    if [ ! $(which gcc) ]; then
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
        PROD=$(softwareupdate -l |
        grep "\*.*Command Line" |
            head -n 1 | awk -F"*" '{print $2}' |
            sed -e 's/^ *//' | tr -d '\n')
        softwareupdate -i "$PROD" -v;
    fi

    success "XCode Command Line Tools Installed"
}


# Install Homebrew package manager.
install_homebrew () {
    if [ ! $(which brew) ]; then
        # This can be automated to just untar the tarball and symlink the bin
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi
    success "Homebrew installed"
}

install_kegs () {
    info "Installing Homebrew kegs"

    # http://www.debian-administration.org/article/316/An_introduction_to_bash_completion_part_1
    brew install bash-completion

    # Install large binaries http://caskroom.io/
    brew install caskroom/cask/brew-cask

    # Emacs dep management
    brew install cask

    # Linux vs BSD
    brew install coreutils

    # Tried and gave up and will try again
    brew install emacs

    # ascii art
    brew install figlet

    # no looking back at SVN
    brew install git

    # Eventually I'll sit down and write something with it
    brew install go

    # Nicer top
    brew install htop-osx

    # Parse and filter JSON from the command line
    brew install jq

    # SSL
    brew install openssl

    # Create machine images
    brew install packer

    # Run processes in parallel
    brew install parallel

    # Bread and butter
    brew install python

    # Lightweight and useful DB for hacks
    brew install sqlite

    # Nicer than mdfind and fast
    brew install the_silver_searcher

    # Terminal multiplexer
    brew install tmux

    # Print dirs out as a tree
    brew install tree

    # Not everything is a tar file
    brew install unrar

    # For those C explorations
    brew install valgrind

    # Required by coreutils
    brew install xz

    # vs curl -O
    brew install wget


    success "Homebrew kegs installed"
}

function install_casks () {

    brew cask install \
        1password \
        adium \
        caffeine \
        chromecast \
        cyberduck \
        emacs \
        evernote \
        firefox \
        flux \
        gas-mask \
        gitx \
        google-chrome \
        hostbuddy \
        intellij-idea-ce \
        iterm2 \
        keyboard-cleaner \
        kindle \
        pycharm \
        rdio \
        screenhero \
        skitch \
        slack \
        spectacle \
        sublime-text \
        vagrant \
        virtualbox

    success "Casks installed"

}

function fetch_themes () {

    for repo in git@github.com:neil477/base16-emacs.git \
        git@github.com:adilosa/base16-idea.git \
        git@github.com:chriskempson/base16-iterm2.git \
        git@github.com:chriskempson/base16-shell.git \
        git@github.com:chriskempson/base16-vim.git \
        https://github.com/anthonyjso/rig.git; do

        git -C $code clone $repo;
    done
    success "Third party repos installed"
}

function install_dotfiles () {
    ln -s ${CODE}/rig/bash/bashrc ${HOME}/.bashrc
}

install_xcode_clt
install_homebrew
install_casks
fetch_themes
fetch_dotfiles

#TODO: casks - Get current list of binaries

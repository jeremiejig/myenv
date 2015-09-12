#!/bin/sh

. $(dirname $0)/../lib/common.sh

exit 0;

test -z ${XDG_DATA_HOME+_}    && XDG_DATA_HOME="${HOME}/.local/share"
test -z ${XDG_CONFIG_HOME+_}  && XDG_CONFIG_HOME="${HOME}/.config"

test -z ${OMF_PATH+_}         && OMF_PATH="${XDG_DATA_HOME}/omf"
test -z ${OMF_CONFIG+_}       && OMF_CONFIG="${XDG_CONFIG_HOME}/omf"

test -z ${OMF_REPO_URI+_}     && OMF_REPO_URI="https://github.com/oh-my-fish/oh-my-fish"
test -z ${OMF_REPO_BRANCH+_}  && OMF_REPO_BRANCH="master"

die() {
	echo "$1" && exit 1
}

omf_preinstall () {
	mkdir -p "${OMF_CONFIG}"
	test -f "${OMF_CONFIG}/bundle"    || ln -s 
	test -f "${OMF_CONFIG}/theme"     || 
	test -f "${OMF_CONFIG}/init.fish" || 
}

echo "Peparing local configuration of Oh My Fish..."
if omf_preinstall; then
	#Simuling a CI env to avoid the reloading of fish.
	CI=custominstall
	curl -L github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | sh
else
	die "Oh My Fish couldn't install, but you can complain here → github.com/oh-my-fish/oh-my-fish/issues"
fi

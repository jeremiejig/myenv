# Common function has to be sourced first in your script.
# Will init this variable :
# DOWNLOADER to a command
# MYENV_PATH to the installation of MyEnv
# 
# function :
# - die
# - is_installed
# - check_sudo
# - confirm
# 


die () {
	local status=$?
	echo $@
	exit $status
}

is_installed() {
	type $1 > /dev/null 2>&1
}

confirm() {
	if [ $MYENV_UNATTENDED = "yes" ]; then
		REPLY=y
	else
		echo -n "Do you want to run $*? [N/y] "
		read REPLY < /dev/tty
	fi;
	if test "$REPLY" = "y" -o "$REPLY" = "Y"; then 
		"$@" < /dev/tty
	fi 
}

check_sudo () {
	if test -n "${MYENV_HAS_SUDO:+_}"; then
		if test ${MYENV_HAS_SUDO} = "1" ; then
			return 0;
		else
			return 1;
		fi
	elif is_installed sudo; then
		echo -n "Do you have admin right ? [N/y]"
		read REPLY < /dev/tty
		if test "$REPLY" = "y" -o "$REPLY" = "Y"; then 
			export MYENV_HAS_SUDO=1
			return 0;
		fi
	else
		return 1;
	fi
}

init () {
	if is_installed curl
	then
		DOWNLOADER='curl -L'
	elif is_installed wget
	then
		DOWNLOADER='wget -O -'
	else 
		die "Missing a dowloader utility."
	fi

	test -z ${MYENV_PATH+_} && MYENV_PATH=$(cd $(dirname $0) && pwd | sed 's-/\(bin\|lib\)$--')
	test -z ${MYENV_UNATTENDED+_} && MYENV_UNATTENDED=no
	test -z ${MYENV_DEBUG+_} && MYENV_DEBUG=no

	export MYENV_UNATTENDED
	export MYENV_PATH
	export MYENV_DEBUG

	if [ $MYENV_UNATTENDED = "yes" ] ; then
		opt_i=""
	else
		opt_i="-i"
	fi;
}

cleanup () {
	unset MYENV_HAS_SUDO
	unset MYENV_PATH
	unset MYENV_UNATTENDED
}

init
[ $MYENV_DEBUG = "yes" ] && set -x || :

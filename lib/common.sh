# Common function
# . $MYENV_PATH/lib/common.sh
#
# The entry point of myenv is in charge of initializing MYENV_PATH and MYENV_PATH_CONFIG
#
# DOWNLOADER		downloader utility
# MYENV_PATH		installation path of MyEnv
# MYENV_PATH_CONFIG	configuration path of MyEnv
#
# function :
# - die
# - e_info
# - e_error
# - e_warning
# - is_installed
# - check_sudo
# - confirm
# 

IFS=' 	
'
export IFS

#Color
clrblack='\e[0;30m'
clrred='\e[0;31m'
clrgreen='\e[0;32m'
clryellow='\e[0;33m'
clrblue='\e[0;34m'
clrpurple='\e[0;35m'
clrcyan='\e[0;36m'
clrwhite='\e[0;37m'
clrend='\e[0m'

colored (){
  local color
  color=$1
  shift
  case $color in
    black)
      echo "$clrblack${*}$clrend" ;;
    red)
      echo "$clrred${*}$clrend" ;;
    green)
      echo "$clrgreen${*}$clrend" ;;
    blue)
      echo "$clrblue${*}$clrend" ;;
    yellow)
      echo "$clryellow${*}$clrend" ;;
    cyan)
      echo "$clrcyan${*}$clrend" ;;
    purple)
      echo "$clrpurple${*}$clrend" ;;
    white)
      echo "$clrwhite${*}$clrend" ;;
    *)
      echo "${*}"
  esac
}

e_info (){
	colored white "$@"
}

e_error (){
	colored red "$@"
}

e_info (){
	colored yellow "$@"
}

die () {
	status=$?
	e_error "$@"
	exit "$status"
}

is_installed() {
	command -pv "$1" > /dev/null 2>&1
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
		else
			export MYENV_HAS_SUDO=0
			return 1;
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

	# Detect Package Manager
	if is_installed apt-get
	then
		PACKAGE_MANAGER='apt-get'
	elif is_installed dnf
	then
		PACKAGE_MANAGER='dnf'
	elif is_installed yum
	then
		PACKAGE_MANAGER='yum'
	fi

	# Load os-release
	[ -r /etc/os-release ] && . /etc/os-release || . /usr/lib/os-release
	OS_ID="$ID"

	#Normally already set
	test -z ${MYENV_PATH} && MYENV_PATH=$(cd $(dirname $0) && pwd | sed 's-/\(bin\|lib\)$--')
	test -z ${MYENV_DEBUG} && MYENV_DEBUG=no
	test -z ${UNATTENDED} && UNATTENDED=no

	export UNATTENDED
	export MYENV_PATH
	export MYENV_PATH_CONFIG
	export MYENV_DEBUG

	if [ $UNATTENDED = "yes" ] ; then
		opt_i="-f"
	else
		opt_i="-i"
	fi;
}

cleanup () {
	unset MYENV_HAS_SUDO
	unset MYENV_PATH
	unset MYENV_PATH_CONFIG
	unset UNATTENDED
}

init
trap cleanup 0
[ $MYENV_DEBUG = "yes" ] && set -x || :

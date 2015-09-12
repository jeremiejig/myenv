# Common function has to be sourced first in your script.
# Will init this variable :
# DOWNLOADER to a command
# MYENV_PATH to the installation of MyEnv
# 


die () {
	local status=$?
	echo $@
	exit $status
}

init () {
	local argv1 $1
	if which curl 2> /dev/null
	then
		DOWNLOADER='curl -L'
	elif which wget 2> /dev/null
	then
		DOWNLOADER='wget -O -'
	else 
		die "Missing a dowloader utility."
	fi

	MYENV_PATH=$(cd $(dirname $argv1) && pwd | sed 's-\(bin\|lib\)$--')

}

init $0 "$@"

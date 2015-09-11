_append_path $HOME/Dropbox/cours/L3/semestre1/li312_mips_simul/bin PATH

set -gx GIET $HOME/Dropbox/cours/L3/semestre1/li312_mips_simul/sesi-almo/soft/giet
#_append_path $HOME/Dropbox/cours/L3/semestre1/li312_mips_simul/sesi-almo/soft/giet GIET

set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH
_append_path $HOME/Dropbox/cours/L3/semestre1/li312_mips_simul/bin/mipsel-unknown-elf/lib LD_LIBRARY_PATH

function xspim ; command xspim -font 6x10 $argv ; end

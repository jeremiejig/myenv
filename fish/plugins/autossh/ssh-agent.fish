function ssh-agent --description "Wrapper to the Authentication agent"
  set -l stdout (command ssh-agent -c $argv ^&1) 
  set -l retval $status
  if test $retval -ne 0
    echo $stdout
  else
    eval (echo $stdout|sed -r 's/unsetenv/set -Ue/g;s/setenv/set -Ux/g')
  end
  return $retval
end

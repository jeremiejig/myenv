set -l date ""(set_color -o yellow)(date)(set_color normal)
set -l welcomeline "Welcome "(set_color green)$USER","(set_color normal)


set -U fish_greeting $date

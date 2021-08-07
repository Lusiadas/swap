source "$PREFIX"/../usr/share/fish/completions/mv.fish
source -- (status filename | command xargs dirname)/../dependency.fish
complete -c mv -n 'not contains_opts' -s s -l swap \
-d 'Swap the location of two files or folders'
complete -c mv -n 'not contains_opts' -s c -l contents \
-d 'Swap the contents of two files, or two folders'
complete -c mv -n 'not contains_opts' -l help \
-d 'Display instructions'
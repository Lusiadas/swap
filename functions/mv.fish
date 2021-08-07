set -l cmd (status filename | command xargs basename | command cut -f 1 -d '.')
function $cmd -V cmd -d "Swap the location or contents between two files or folders"
  set -l main (status filename | xargs dirname)/..
  source $main/dependency.fish

  # Parse flags
  if argparse -n $cmd -x h,s,c 'h/help' 's/swap' 'c/contents' -- $argv 2>&1 | read err
    string match -qri 'ex(clusive|pected)' $err
    or set -l flag (set --names \
    | string match -qr '(?<=^_flag_).*' \
    | string join /--)
    if test $status = 0
      test -z "$flag"
      and err $err
      or err "$cmd: option -$flag cannot be combined with other options"
      reg "Use |$cmd -h| to see examples of valid syntaxes"
      return 1  
    end
    command mv $argv
    return $status
  end

  # Help option
  if set --query _flag_help
    source $main/instructions.fish
    test -z "$argv"

  # If no fish options are called
  else if set --names | not string match -qe _flag_
    command mv $argv

  # Swap option    
  else

    # Check argument validity
    if test (count $argv) -ne 2
      err "$cmd: Only two files can be swapped"
      return 1
    end
    set -l failed
    for file in $argv
      test -e $file
      and continue
      err "$cmd: |$file| not found"
      set failed true
    end
    test "$failed"
    and return 1

    # Swap locations    
    if set --query _flag_swap
      if command dirname $argv[1] | string match -qv (dirname $argv[2])
        set -l tmp (command mktemp -d)
        command mv $argv[1] $tmp
        command mv $argv[2] (command dirname $argv[1])
        command mv $tmp/* (command dirname $argv[2])
        win "$cmd: The location of |$argv[1]| and |$argv[2]| have been swapped"
        return 0
      end
      wrn "Targets are in the same location."
      read -n 1 -P "Swap their contents instead? [y/n]: " | string match -qi y
      or return 1
      mv -c $argv
    
    else if set --query _flag_contents

      # Check argument validity
      set -l type
      if test -f $argv[1] -a test -f $argv[2]
        set type file
      else if test -d $argv[1] -a test -d $argv[2]
        set type folder
      else
        err "$cmd: Cannot swap the contents of a file for those of a folder"
        return 1
      end
  
      # Swap contents
      if string match -q folder $type
        read tmp (command mktemp -d)
        command mv $args[1]/* $tmp
        command mv $argv[2]/* $argv[1]
        command mv  $tmp/* $argv[2]
      else
        read tmp (command mktemp)
        command mv $argv[1] $tmp
        command mv $argv[2] $argv[1]
        command mv $tmp $argv[2]
      end
      win "The contents of |$argv[1]| and |$argv[2]| have been swapped"
    end
  end
end

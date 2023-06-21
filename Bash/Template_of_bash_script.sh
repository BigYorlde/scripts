#!/usr/bin/env bash

# Global vars

declare -r A="A" # read-only var
declare -a ARRAY=() # array
declare -a ARRAY1=()

# Functions
# Useful functions for every script
# Set colors for text
setColors() {
  COLOR_BLACK="\033[1;30m"
  COLOR_RED="\033[1;31m"
  COLOR_GREEN="\033[1;32m"
  COLOR_YELLOW="\033[1;33m"
  COLOR_BLUE="\033[1;34m"
  COLOR_PURPLE="\033[1;35m"
  COLOR_CYAN="\033[1;36m"
  COLOR_GREY="\033[0;37m"
  COLOR_WHITE="\033[1;37m"
  COLOR_DEFAULT="\033[m"
}
# Log func
log() {
  local cur_date
  if [ "$@" == "" ]; then
    return 0
  fi
  cur_date="[$(date +%H:%M:%S | cut -b1-12)]"
  printf "$cur_date -INFO- $@ ${COLOR_DEFAULT}\n" # comment this line for silent logging
  # removing color codes for log file record
  sed -r "s/\x1B\[[0-9;]*[mK]//g" <<< "$(printf "$cur_date -INFO- $@\n" 2> /dev/null)"
  # for logging into more than 1 file we can use:
  # | tee -a "$LOG_FILE_PATH" >> "$OTHER_LOG_FILE_PATH"
}
# Error log func
err() {
  local cur_date
  cur_date="[$(date +%H:%M:%S | cut -b1-12)]"
  printf "$cur_date ${COLOR_RED}-ERROR-${COLOR_DEFAULT} $@ ${COLOR_DEFAULT}\n" >&2
  #removing colors for logging to log file
  sed -r "s/\x1B\[[0-9;]*[mK]//g" <<< "$(printf "$cur_date ${COLOR_RED}-ERROR-${COLOR_DEFAULT} $@ ${COLOR_DEFAULT}\n")"
  # for logging into more than 1 file we can use:
  # | tee -a "$LOG_FILE_PATH" >> "$OTHER_LOG_FILE_PATH"
}
# Clean old logs
clean_old_log() {
  find "$LOG_FOLDER" -mtime +30 -delete # delete files older than 30 days
}
# Template of main func
main() {
  params="$(echo "$@" | tr [A-z] [A-z] )" # example of parsing params
  flag="$(echo "$1" | tr [A-z] [A-z] )" # example of parsing flags
  for par in $params; do
    if [[ "$par" == "a" ]]; then
      ARRAY+=("$par")
    elif [[ "$par" == "b" ]]; then
      ARRAY1+=("$par")
    fi
  done
  if [ "$flag" == "-h" ] || [ "$flag" == "-help" ]; then
    flag="--help"
  fi
  echo "Options: flag=$flag; params=${params[@]}"
  case "$flag" in
  "--help")
    echo "USAGE: myscript [-flag] [params]"
    echo "Example: myscript -start service1 service2 service3"
    echo "-h/-help to display this help page"
    exit
  ;;
  "-start")
  ;;
  "-stop")
  ;;
  "-status")
  ;;
  esac
}

# Main block

# Useful parameters for debug and minimize risks:
# Debug mode:
# set -x
# End script if exit code !-eq 0
# set -eo pipefail

setColors

log "$(whoami) is startint to work."
if [ "$1" == "-h" ] || [ "$1" == "-help" ] || [ "$1" == "-start" ] || [ "$1" == "-stop" ] || [ "$1" == "-status" ]; then
  main $@
else
  err "Wrong first parameter (flag). Use -h or -help to read more."
  exit
fi

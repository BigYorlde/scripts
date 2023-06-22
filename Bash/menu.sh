#!/usr/bin/env bash

# Global vars

action1="action1"
action2="action2"
action_all=("$action1" "$action2")
# Functions

setColumns() {
COLUMNS=1
}
showSelectMenu() {
  clear
  setColumns
  printf "Main menu\n"
  select action in "${action_all[@]}"; do
    if [[ "${action_main_all[@]}" != "${action_main_all[@]##$action}" ]]; then
      clear
      break
    fi
  done
}

action1_Options() {
  echo "this is action1 from main menu\n"
}
action2_Options() {
  echo "this is action2 from main menu\n"
}
while true; do
    setColumns
    showSelectMenu
    case $action in
        "$action1")
          action1_Options
        ;;
        "$action2")
          action2_Options
        ;;
    esac
    clear
done










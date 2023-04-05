#!/usr/bin/env bash

################################################################################
## Returns the current width of the terminal window in number of characters
## Examples:
## WINDOW_WIDTH=$(getWindowWidth)

getWindowWidth() {
  tput cols
}


################################################################################
## Prints the given string the given number of times
## Examples:
## repeatString "SOS" 5

repeatString() {
  local STRING_TO_REPEAT=$1
  local TIMES_TO_REPEAT=$2

  if [ -z "$TIMES_TO_REPEAT" ] || [ -z "$STRING_TO_REPEAT" ]; then
    return
  fi  

  local i=1 
  while [ "${i}" -le "${TIMES_TO_REPEAT}" ]; do
    echo -n "${STRING_TO_REPEAT}"
    i=$((i + 1)) 
  done
}


################################################################################
## Prints one line of hashtags (default) or 
## other, given chars/strings (respects window size)
## Examples:
## printLine
## printLine "-={TEST}=- "

printLine() {
  local WINDOW_WIDTH
  local STRING
  WINDOW_WIDTH="$(getWindowWidth)"
  STRING="${1:-"#"}"
  
  REPEATS=$(( WINDOW_WIDTH / ${#STRING} ))
  repeatString "${STRING}" $REPEATS
  echo "" #final newline
}


################################################################################
## Prints the given text centered in the terminal window
## Examples:
## printCentered "Hello World!"

printCentered() {
  if [ -z "$1" ]; then
    return;
  fi  

  local STRING
  local STRING_SIZE
  local WINDOW_WIDTH
  STRING="${1}"
  STRING_SIZE="${#STRING}"
  WINDOW_WIDTH="$(getWindowWidth)"

  if [ "${STRING_SIZE}" -gt "${WINDOW_WIDTH}" ]; then
    echo -e "${STRING}"
  else
    REQUIRED_SPACES=$(( (WINDOW_WIDTH - STRING_SIZE) / 2 ))
    repeatString " " "${REQUIRED_SPACES}"
    echo -e "${STRING}"
  fi  
}


################################################################################
## Prints the given text inside a block of hashtags "#"
## Examples:
## echoWithBorder "Hello World!"

echoWithBorder() {
  local STRING
  local STRING_SIZE
  local WINDOW_WIDTH
  STRING="${1}"
  STRING_SIZE="$(( ${#STRING} + 6 ))"
  WINDOW_WIDTH="$(getWindowWidth)"

  if [ "${STRING_SIZE}" -gt "${WINDOW_WIDTH}" ]; then
    printLine
  else
    printf '#%.0s' $(seq 1 "${STRING_SIZE}")
  fi
    
  echo -e "\n## ${STRING} ##"

  printLine
}


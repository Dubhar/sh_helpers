#!/usr/bin/env bash

################################################################################
## Call with a string to prompt, or use default "Are you sure?"
## Returns 0 if "yes" or "y" is entered (case insensitive). Otherwise 1.
## Examples:
## if confirm "Do you really wanna do that?"; then rm -rf /; fi
## $ANSWER=confirm

confirm() {
  read -r -e -p "${1:-"Are you sure?"} [y/N] " response
  case $response in
    [yY][eE][sS]|[yY])
      true
      ;;
    *)
      false
      ;;
  esac
}


################################################################################
## Lets the user enter a file path (with tab completion)
## Examples:
## FILE=$(getFilePath)
## sqltool imp $(getFilePath)

getFilePath() {
  local FILEPATH=""
  until [ -f "$FILEPATH" ]; do
    read -r -e -p "Please choose a file: " FILEPATH

    # replace ~ with $HOME as some bash versions do not recognize ~
    FILEPATH=${FILEPATH/#\~/$HOME}
  done
  echo "${FILEPATH}"
}


################################################################################
## Lets the User enter a directory path (with tab completion)
## Only accepts existing/valid directories
## Examples:
## DIR=$(getDirectoryPath)

getDirectoryPath() {
  local DIRPATH=""
  until [ -d "$DIRPATH" ]; do
    read -r -e -p "Please choose a directory: " DIRPATH

    # replace ~ with $HOME as some bash versions do not recognize ~
    DIRPATH=${DIRPATH/#\~/$HOME} 
  done
  echo "${DIRPATH}"
}


################################################################################
## Wait for <ENTER> to be pressed.
## Examples:
## waitForKey

waitForKey() {
  if [ "$IGNORE_WAIT_FOR_KEY" == true ]; then
    return
  fi

  read -r -p "Press <ENTER> to continue..."
}


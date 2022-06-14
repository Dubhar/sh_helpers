#!/usr/bin/env bash

# Echos a given text in a given color
# Ex: echoColor '\e[93m' 'This is a colored text'
echoColor() {
    local COLOR="${1}"
    local CLEAR='\e[0m'
    local TEXTS=( "${@:2}" )
    echo -e "${COLOR}${TEXTS[*]}${CLEAR}"
}

# Prepends a given text by the current datetime and echos it in a given color
logColor() {
  local COLOR="${1}"
  local TEXTS=( "${@:2}" )
  echoColor "${COLOR}" "$(date +"%Y-%m-%d %H:%M:%S") - ${TEXTS[*]}"
}

# Logs a green info message
logInfo() {
    local GREEN='\e[92m'
    logColor "${GREEN}" "INFO: ${*}"
}

# Logs a blue debug message
logDebug() {
    local BLUE='\e[94m'
    logColor "${BLUE}" "DEBUG: ${*}"
}

# Logs an orange warning message
logWarn() {
    local ORANGE='\e[33m'
    logColor "${ORANGE}" "WARNING: ${*}" 1>&2
}

# Logs a red error message
logError() {
    local RED='\e[31m'
    logColor "${RED}" "ERROR: ${*}" 1>&2
}

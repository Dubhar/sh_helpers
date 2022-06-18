#!/usr/bin/env zsh

retry() {
  local COMMAND="${1}"
  local max=${2:-3}
  local delay=${3:-1}

  local n=1
  while true; do
    if $SHELL -c "${COMMAND}"; then
      break
    else
      if [[ $n -lt $max ]]; then
        ((n++))
        logWarn "Command failed. Attempt ${n}/${max} in ${delay}s:"
        sleep "${delay}"
      else
        logError "The command has failed after ${n} attempts."
        return 1
      fi
    fi
  done
}

#!/usr/bin/env zsh:

brew-cask-upgrade() {
  local newest_version
  local is_installed
  for cask in $(brew list --cask); do
    newest_version="$(brew info --cask "${cask}" | grep "==> ${cask}" | awk '{print $3}')"
    is_installed="$(grep -ir "${newest_version}" "$(brew --prefix)/Caskroom/${cask}")"
    if [ -z "${is_installed}" ]; then
      echo "${cask} - upgrading to ${newest_version}"
      brew reinstall --force "${cask}"
    else
      echo "${cask} - is up to date"
    fi
  done
}

brew-leaves() {
  local tree
  tree="$(brew deps --tree --installed)"
  for package in $(brew list); do
    if [ "$(printf '%s' "${tree}" | grep -c "${package}")" -eq 1 ]; then
      echo "${package}"; 
    fi
  done
}


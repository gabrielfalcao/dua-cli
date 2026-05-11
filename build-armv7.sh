#!/usr/bin/env bash

set -umeTE
set +f
set -o pipefail
export IFS=$'\n'

declare -- script_name="$(basename "${BASH_SOURCE[0]}")"
declare -- script_path="$(2>/dev/random 1>/dev/random cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -- this_script_path="${script_path}/${script_name}"

on_exit() {
    set +x
}

on_ctrlc() {
    1>&2 echo -e "\x1b[1;38;2;253;67;83m\rAborted with Ctrl-C\x1b[0m"
    exit 130
}
trap on_exit exit
trap on_ctrlc hup
trap on_ctrlc int
trap on_ctrlc bus
trap on_ctrlc segv
trap on_ctrlc sys


declare -a argv=(${@})
declare -i argc=${#argv[@]}
declare -- target=""
declare -- name=""

declare -a targets=(
    "armv7-unknown-linux-gnueabihf"
    "armv7-unknown-linux-gnueabi"
)

# for target in ${targets[@]}; do
#     cargo zigbuild --target "${target}"
# done

1>&2 echo -e "\x1b[2J\x1b[3J\x1b[H"

cargo build
for target in $(find "${script_path}/target" -mindepth 2 -name debug -type d -exec path parent {} \;); do
    name=$(basename "${target}")
    # 1>&2 declare -p name target
    rustup target add "${target}"
    cargo zigbuild --target "${target}"
    cp -fv "${target}/debug/dua" "${script_path}/dua__${name}"
    echo
done

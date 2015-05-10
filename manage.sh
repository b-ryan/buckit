#!/bin/bash

set -e

debug() {
    echo >&2 "$@"
}

list-coffee() {
    ls public/app.coffee
    find public/services -name '*.coffee'
    find public/models -name '*.coffee'
    find public/components -name '*.coffee'
}

compile-coffee() {
    coffee --compile --print $(list-coffee) > public/.compiled/buckit.js
    debug Compiled coffeescript into public/.compiled/buckit.js
}

watch() {
    # relies on it not watching changes for hidden directories, specifically
    # public/.compiled
    compile-coffee || true

    while true; do
        change=$(inotifywait --quiet --event close_write,moved_to,create public)
        file=${change##* }
        filetype=${file##*.}
        if [[ "$filetype" = "coffee" ]]; then
            compile-coffee || true
        fi
    done
}

usage() {
    cat >&2 <<EOF
Available commands:

    * help
    * list-coffee
    * compile-coffee
    * watch
EOF
}

main() {
    local func=$1
    case $func in
        list-coffee) list-coffee ;;
        compile-coffee) compile-coffee ;;
        watch) watch ;;
        help) usage ;;
        *) usage ;;
    esac
}

main "$@"

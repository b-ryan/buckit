#!/bin/bash

set -e

debug() {
    echo >&2 "$(date --rfc-3339=seconds) $@"
}

list-coffee() {
    ls app/app.coffee
    find app/services -name '*.coffee'
    find app/models -name '*.coffee'
    find app/components -name '*.coffee'
}

compile-coffee() {
    coffee --compile --print $(list-coffee) > app/.compiled/buckit.js
    debug Compiled coffeescript into app/.compiled/buckit.js
}

watch() {
    compile-coffee || true

    while read change; do
        file=${change##* }
        filetype=${file##*.}
        if [[ "$filetype" = "coffee" ]]; then
            compile-coffee || true
        fi
    done < <(inotifywait --monitor --recursive \
        --event close_write,moved_to,delete \
        app)
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

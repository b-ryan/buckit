#!/bin/bash

set -e

debug() {
    echo >&2 "$(date --rfc-3339=seconds) $@"
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
    compile-coffee || true

    while read change; do
        file=${change##* }
        filetype=${file##*.}
        if [[ "$filetype" = "coffee" ]]; then
            compile-coffee || true
        fi
    done < <(inotifywait --monitor --recursive \
        --event close_write,moved_to,delete \
        public)
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

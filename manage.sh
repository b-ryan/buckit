#!/bin/bash

set -e

debug() {
    echo >&2 "$(date --rfc-3339=seconds) $@"
}

# ------------------------
# compilation

list_coffee() {
    modules=(
        core
        components
        routing
    )
    for m in ${modules[@]}; do
        ls app/buckit.${m}.coffee
        find app/${m} -name '*.coffee'
    done

    ls app/buckit.coffee
}

compile_coffee() {
    > app/.compiled/buckit.js
    for f in $(list_coffee); do
        coffee --compile --print $f >> app/.compiled/buckit.js
    done
    debug "Compiled coffeescript into app/.compiled/buckit.js"
}

watch() {
    compile_coffee || true

    while read change; do
        file=${change##* }
        filetype=${file##*.}
        if [[ "$filetype" = "coffee" ]]; then
            compile_coffee || true
        fi
    done < <(inotifywait --monitor --recursive \
        --event close_write,moved_to,delete \
        app)
}

# ------------------------
# testing

compile_test_coffee() {
    rm -rf test/app/.compiled
    coffee --compile --output test/app/.compiled test/app
    debug "Compiled test coffeescript into test/app/.compiled/"
}

test_coffee() {
    compile_coffee
    compile_test_coffee
    karma start karma.js --single-run
}

# ------------------------
# main

usage() {
    cat >&2 <<EOF
Available commands:

    * help
    * list-coffee
    * compile-coffee
    * watch
    * compile-test-coffee
    * test
EOF
}

main() {
    local func=$1
    case $func in
        help) usage ;;
        list-coffee) list_coffee ;;
        compile-coffee) compile_coffee ;;
        watch) watch ;;
        compile-test-coffee) compile_test_coffee ;;
        test) test_coffee ;;
        *) usage ;;
    esac
}

main "$@"

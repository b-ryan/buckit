#!/bin/bash

set -e

COMPILED_JS=app/.compiled/buckit.js

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
    # iterating through the list of files to compile rather than
    # providing them directly as an argument to coffee ensures the
    # files are compiled in the correct order. otherwise coffee
    # seems to sometimes order them incorrectly, perhaps due to
    # parallelization.

    > ${COMPILED_JS}
    for f in $(list_coffee); do
        coffee --compile --print ${f} >> ${COMPILED_JS}
    done

    debug "Compiled coffeescript into ${COMPILED_JS}"
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

#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P)
target=${CARGO_TARGET_DIR:-${CARGO_BUILD_TARGET_DIR:-target}}
case "$target" in
    /*) ;;
    *) target="$root/$target" ;;
esac
binary="$target/release/cosmic-panel"
link="$HOME/.local/bin/cosmic-panel"

fail() {
    printf '%s\n' "$*" >&2
    exit 1
}

is_our_link() {
    [ -L "$link" ] && [ "$(readlink -- "$link")" = "$binary" ]
}

case "${1:-}" in
    install)
        [ -x "$binary" ] || fail "No release binary at $binary. Run 'pixi run build' first."
        if ! is_our_link; then
            if [ -e "$link" ] || [ -L "$link" ]; then
                fail "$link does not point to this checkout. Leaving it alone."
            fi
            mkdir -p -- "${link%/*}"
            ln -sT -- "$binary" "$link"
        fi
        ;;
    restore)
        if is_our_link; then
            unlink -- "$link"
        elif [ -e "$link" ] || [ -L "$link" ]; then
            fail "$link does not point to this checkout. Leaving it alone."
        else
            printf 'No local panel override to remove.\n'
            exit 0
        fi
        ;;
    *)
        fail "Usage: $0 install|restore"
        ;;
esac

pkill -TERM -u "$(id -u)" -x cosmic-panel || {
    status=$?
    [ "$status" -eq 1 ] || exit "$status"
    printf '%s\n' 'No running panel was signalled; the change will take effect at the next launch.' >&2
}

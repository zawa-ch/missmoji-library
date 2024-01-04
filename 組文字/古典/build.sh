#! /bin/bash

cdir=$(cd "$(dirname "$0")" && pwd) || exit
buildtmp="${cdir}/.build"

unwrap() { "$@" || exit; }
build_png() {
	echo "building $1"
	cp -f "${cdir}/${1:?}" -t "${buildtmp:?}/" || return
	optipng -quiet "${buildtmp:?}/${1:?}" || return
}

case $1 in
'' | 'build')
[ -d "${buildtmp:?}" ] || unwrap mkdir "${buildtmp:?}"
unwrap build_png ashi.png
unwrap build_png haruhaagemono.png
unwrap build_png haruhaagepoyo.png
unwrap build_png haruhaakebono.png
unwrap build_png ito.png
unwrap build_png waroshi.png
unwrap build_png wokashi.png
unwrap build_png yoshi.png
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

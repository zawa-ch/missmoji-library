#! /bin/bash

cdir=$(cd "$(dirname "$0")" && pwd) || exit
buildtmp="${cdir}/.build"

unwrap() { "$@" || exit; }
build_svg() {
	echo "building $1"
	resvg -z "${2:-1}" --dpi 384 "${cdir}/$1" "${buildtmp:?}/${1/%.svg/.png}" || return
	optipng -quiet "${buildtmp:?}/${1/%.svg/.png}" || return
}

case $1 in
'' | 'build')
[ -d "${buildtmp:?}" ] || unwrap mkdir "${buildtmp:?}"
unwrap build_svg ledmatrix_r16_nextis.svg 1
unwrap build_svg ledmatrix_r16_nextomaeda.svg 1
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

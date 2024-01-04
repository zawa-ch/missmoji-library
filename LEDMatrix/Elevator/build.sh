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
unwrap build_svg ledmatrix_ev_space.svg 4
unwrap build_svg ledmatrix_ev_digitone.svg 4
unwrap build_svg ledmatrix_ev_digittwo.svg 4
unwrap build_svg ledmatrix_ev_digitthree.svg 4
unwrap build_svg ledmatrix_ev_digitfour.svg 4
unwrap build_svg ledmatrix_ev_digitfive.svg 4
unwrap build_svg ledmatrix_ev_digitsix.svg 4
unwrap build_svg ledmatrix_ev_digitseven.svg 4
unwrap build_svg ledmatrix_ev_digiteight.svg 4
unwrap build_svg ledmatrix_ev_digitnine.svg 4
unwrap build_svg ledmatrix_ev_digitzero.svg 4
unwrap build_svg ledmatrix_ev_latincapitalletterb.svg 4
unwrap build_svg ledmatrix_ev_latincapitalletterg.svg 4
unwrap build_svg ledmatrix_ev_latincapitalletterr.svg 4
unwrap build_svg ledmatrix_ev_fullblock.svg 4
unwrap build_svg ledmatrix_ev_downwardsarrow.svg 4
unwrap build_svg ledmatrix_ev_upwardsarrow.svg 4
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

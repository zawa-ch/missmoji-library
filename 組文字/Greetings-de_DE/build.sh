#! /bin/bash

cdir=$(cd "$(dirname "$0")" && pwd) || exit
buildtmp="${cdir}/.build"

unwrap() { "$@" || exit; }
build_svg() {
	echo "building $1"
	resvg -z "${2:-1}" --dpi 384 "${cdir}/$1" "${buildtmp:?}/${1/%.svg/.png}" || return
	optipng -quiet "${buildtmp:?}/${1/%.svg/.png}" || return
}
build_svg_anim() {
	echo "building $1"
	[ -d "${buildtmp:?}/${1:?}-tmp" ] || mkdir "${buildtmp:?}/${1:?}-tmp" || return
	for findex in $(seq 1 "${3:?}")
	do
		( cd "${buildtmp:?}/${1:?}-tmp" && inkscape -o "f${findex}.png" --export-page="$findex" "${cdir}/${2:?}" ) || return
		optipng -quiet "${buildtmp:?}/${1:?}-tmp/f${findex}.png" || return
	done
	apngasm "${buildtmp:?}/${1:?}" "${buildtmp:?}/${1:?}-tmp/f1.png" "${4:?}" "${5:?}" -l"${6:-0}" || return
	rm -rf "${buildtmp:?}/${1:?}-tmp"
}
build_png() {
	echo "building $1"
	cp -f "${cdir}/${1:?}" -t "${buildtmp:?}/" || return
	optipng -quiet "${buildtmp:?}/${1:?}" || return
}

case $1 in
'' | 'build')
[ -d "${buildtmp:?}" ] || unwrap mkdir "${buildtmp:?}"
unwrap build_svg_anim guten_morgen.png guten_morgen.svg 8 1 10 0
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

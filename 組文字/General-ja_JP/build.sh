#! /bin/bash

cdir=$(cd "$(dirname "$0")" && pwd) || exit
buildtmp="${cdir}/.build"

unwrap() { "$@" || exit; }
build_svg() {
	echo "building $1"
	resvg -z "${2:-1}" --dpi 384 "${cdir}/$1" "${buildtmp:?}/${1/%.svg/.png}" || return
	optipng -quiet "${buildtmp:?}/${1/%.svg/.png}" || return
}
build_png() {
	echo "building $1"
	cp -f "${cdir}/${1:?}" -t "${buildtmp:?}/" || return
	optipng -quiet "${buildtmp:?}/${1:?}" || return
}
build_gif() {
	echo "building $1"
	cp -f "${cdir}/${1:?}" -t "${buildtmp:?}/" || return
}

case $1 in
'' | 'build')
[ -d "${buildtmp:?}" ] || unwrap mkdir "${buildtmp:?}"
unwrap build_png aruaru.png
unwrap build_svg bluelet_okudake.svg 4
unwrap build_svg bouron.svg 4
unwrap build_svg chottodeiikara.svg 4
unwrap build_svg doshigatai.svg 4
unwrap build_svg emojioosugimondai.svg 4
unwrap build_svg gomottomo.svg 4
unwrap build_svg honmaya.svg 4
unwrap build_svg iizomottoyare.svg 4
unwrap build_svg inbouron.svg 4
unwrap build_svg jigokuman.svg 4
unwrap build_png nainai.png
unwrap build_svg seihekinisasaru.svg 4
unwrap build_gif shigotogahayai.gif
unwrap build_svg shikei.svg 4
unwrap build_svg wakaranai.svg 4
unwrap build_svg wakaru.svg 4
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

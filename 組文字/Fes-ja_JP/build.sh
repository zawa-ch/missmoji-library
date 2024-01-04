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

case $1 in
'' | 'build')
[ -d "${buildtmp:?}" ] || unwrap mkdir "${buildtmp:?}"
unwrap build_png arigatofes.png
unwrap build_png bikkurifes.png
unwrap build_png dosukebefes.png
unwrap build_png kawaiifes.png
unwrap build_png naruhodofes.png
unwrap build_png tasukarufes.png
unwrap build_png tasuketefes.png
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

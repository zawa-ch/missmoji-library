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
unwrap build_png ohayou.png
unwrap build_png okaeri.png
unwrap build_png osashimiyasai.png
unwrap build_png otsukaresama.png
unwrap build_png oyasumi.png
unwrap build_png tadaima.png
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

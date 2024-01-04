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
unwrap build_svg stellar_ch_handwrittenjissekikaijo.svg 2
unwrap build_svg stellar_ch_handwrittenoyasumi.svg 2
unwrap build_svg stellar_ch_handwrittensugoi.svg 2
unwrap build_svg stellar_ch_handwrittenerailtu.svg 2
unwrap build_svg stellar_ch_handwrittenkawaii.svg 2
unwrap build_svg stellar_ch_handwrittenshigotogahayai.svg 2
unwrap build_svg stellar_ch_handwrittentaitaikin.svg 2
unwrap build_svg stellar_ch_handwrittengupekorin.svg 2
unwrap build_svg stellar_ch_handwrittennetemorote.svg 2
unwrap build_svg stellar_ch_handwrittenshigotohayasugimondai.svg 2
unwrap build_svg stellar_ch_handwritteninvitingbed.svg 2
unwrap build_svg stellar_ch_handwrittenohayo.svg 2
unwrap build_svg stellar_ch_handwrittenstartdispute.svg 2
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

#! /bin/bash

cdir=$(cd "$(dirname "$0")" && pwd) || exit
buildtmp="${cdir}/.build"

unwrap() { "$@" || exit; }
build_gif() {
	echo "building $1"
	cp -f "${cdir}/${1:?}" -t "${buildtmp:?}/" || return
}

case $1 in
'' | 'build')
[ -d "${buildtmp:?}" ] || unwrap mkdir "${buildtmp:?}"
unwrap build_gif akuihanashi.gif
unwrap build_gif daijinahanashi.gif
unwrap build_gif iihanashi.gif
unwrap build_gif imanohanashi.gif
unwrap build_gif kanashiihanashi.gif
unwrap build_gif kowaihanashi.gif
unwrap build_gif mondaihanashi.gif
unwrap build_gif oishiihanashi.gif
unwrap build_gif sakkinohanashi.gif
unwrap build_gif sosuunahanashi.gif
unwrap build_gif sugoihanashi.gif
unwrap build_gif sutekinahanashi.gif
unwrap build_gif ureshiihanashi.gif
unwrap build_gif waruihanashi.gif
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

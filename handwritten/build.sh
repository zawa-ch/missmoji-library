#! /bin/bash

cdir=$(cd "$(dirname "$0")" && pwd) || exit
buildtmp="${cdir}/.build"

subdirs=(
	"stellar_ch"
)

unwrap() { "$@" || exit; }
build_subdir() {
	[ -x "${cdir:?}/$1/build.sh" ] || { echo "${cdir:?}/$1/build.sh is not executable. skipping..."; return; }
	echo "enter \"$1\"..."
	"${cdir:?}/$1/build.sh" "$2" || { local r=$?; echo "leave \"$1\"..."; return $r; }
	[ -d "${cdir:?}/$1/.build" ] && {
		[ -e "${buildtmp:?}/$1" ] && rm -rf "${buildtmp:?}/${1:?}"
		mv -f -T "${cdir:?}/$1/.build" "${buildtmp:?}/$1"
	}
	echo "leave \"$1\"..."
}

case $1 in
'' | 'build')
[ -d "${buildtmp:?}" ] || unwrap mkdir "${buildtmp:?}"
for i in "${subdirs[@]}"; do build_subdir "$i" "$1" || exit; done
;;
'clean')
for i in "${subdirs[@]}"; do build_subdir "$i" clean; done
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

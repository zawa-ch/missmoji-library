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
unwrap build_svg http_100.svg 1
unwrap build_svg http_101.svg 1
unwrap build_svg http_102.svg 1
unwrap build_svg http_103.svg 1
unwrap build_svg http_200.svg 1
unwrap build_svg http_201.svg 1
unwrap build_svg http_202.svg 1
unwrap build_svg http_203.svg 1
unwrap build_svg http_204.svg 1
unwrap build_svg http_205.svg 1
unwrap build_svg http_206.svg 1
unwrap build_svg http_207.svg 1
unwrap build_svg http_208.svg 1
unwrap build_svg http_226.svg 1
unwrap build_svg http_300.svg 1
unwrap build_svg http_301.svg 1
unwrap build_svg http_302.svg 1
unwrap build_svg http_303.svg 1
unwrap build_svg http_304.svg 1
unwrap build_svg http_305.svg 1
unwrap build_svg http_307.svg 1
unwrap build_svg http_308.svg 1
unwrap build_svg http_400.svg 1
unwrap build_svg http_401.svg 1
unwrap build_svg http_403.svg 1
unwrap build_svg http_404.svg 1
unwrap build_svg http_405.svg 1
unwrap build_svg http_406.svg 1
unwrap build_svg http_407.svg 1
unwrap build_svg http_408.svg 1
unwrap build_svg http_409.svg 1
unwrap build_svg http_410.svg 1
unwrap build_svg http_411.svg 1
unwrap build_svg http_412.svg 1
unwrap build_svg http_413.svg 1
unwrap build_svg http_414.svg 1
unwrap build_svg http_415.svg 1
unwrap build_svg http_416.svg 1
unwrap build_svg http_417.svg 1
unwrap build_svg http_418.svg 1
unwrap build_svg http_421.svg 1
unwrap build_svg http_422.svg 1
unwrap build_svg http_423.svg 1
unwrap build_svg http_424.svg 1
unwrap build_svg http_425.svg 1
unwrap build_svg http_426.svg 1
unwrap build_svg http_428.svg 1
unwrap build_svg http_429.svg 1
unwrap build_svg http_431.svg 1
unwrap build_svg http_451.svg 1
unwrap build_svg http_500.svg 1
unwrap build_svg http_501.svg 1
unwrap build_svg http_502.svg 1
unwrap build_svg http_503.svg 1
unwrap build_svg http_504.svg 1
unwrap build_svg http_505.svg 1
unwrap build_svg http_506.svg 1
unwrap build_svg http_507.svg 1
unwrap build_svg http_508.svg 1
unwrap build_svg http_510.svg 1
unwrap build_svg http_511.svg 1
;;
'clean')
[ -d "${buildtmp:?}" ] && rm -rf "${buildtmp:?}"
;;
*)
echo "build: unknown action $1" >&2
exit 1
;;
esac

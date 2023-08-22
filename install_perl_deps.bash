#!/usr/bin/env bash

# install perl dependencies

_root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
_cpanm=${_root_dir}/cpanm

curl -L -O http://xrl.us/cpanm > ${_cpanm}
chmod 755 ${_cpanm}
${_cpanm} PDF::Imposition

# Licensed under GNU Lesser General Public License v3 or later, see COPYING.
# Copyright (c) 2019 Alexander Sosedkin and other contributors, see AUTHORS.

{ coreutils, writeScriptBin, instDir }:

writeScriptBin "nix-on-droid-linker" ''
  #!/usr/bin/env sh
  set -e

  link() {
    local from="$1"
    local to="$2"

    echo "Linking ~/.nix-profile/$from to /$to"
    ${coreutils}/bin/mkdir -p $(dirname /$to)
    ${coreutils}/bin/ln -snf $HOME/.nix-profile/$from /$to
  }

  for i in login sh proot-static; do
    link bin/$i bin/$i
  done

  for i in group home.nix.default nix/nix.conf passwd resolv.conf; do
    link etc/$i etc/$i
  done

  link bin/env usr/bin/env
  link usr/lib/login-inner usr/lib/login-inner
''

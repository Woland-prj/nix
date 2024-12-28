{pkgs, ...}:
pkgs.writeShellScriptBin "show-colors" ''
  #!/usr/bin/env bash
    for i in {0..255}; do
      printf "\e[38;5;''${i}mcolour''${i}\e[0m\n"
    done
''

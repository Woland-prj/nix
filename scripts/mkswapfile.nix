{pkgs}:
pkgs.writeShellScriptBin "mkswapfile" ''
  sudo fallocate -l ''$1G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
''

{
  pkgs,
  config,
  ...
}:
pkgs.writeShellScriptBin "wallpaper" ''
  cat ${config.stylix.image}
''

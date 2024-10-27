{pkgs, ...}: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.woland = {
      isNormalUser = true;
      description = "Woland";
      extraGroups = ["networkmanager" "wheel" "input" "uinput" "libvirtd"];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "woland";
}

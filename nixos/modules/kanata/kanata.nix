{
  services.kanata = {
    enable = true;
    keyboards = builtins.readFile ./kanata.kbd;
  };
}

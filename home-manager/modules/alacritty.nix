{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 16.0;

        normal = {
          family = "JetBrains Mono NF";
          style = "Regular";
        };
        
        bold = {
          family = "JetBrains Mono NF";
          style = "Bold";
        };

        italic = {
          family = "JetBrains Mono NF";
          style = "Italic";
        };
      };

      window.padding = {
        x = 10;
        y = 10;
      };

      keyboard.bindings = [
        {
          action = "ScrollPageUp";
          key = "K";
          mods = "Control|Shift";
        }
        {
          action = "ScrollPageDown";
          key = "J";
          mods = "Control|Shift";
        }
      ];
    };
  };
}

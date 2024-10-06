_: {
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = 20;
    };
  };
  keymaps = [
    {
      mode = ["n" "t"];
      key = "<leader><Enter>v";
      action = "<cmd>ToggleTerm direction=vertical<cr>";
      options = {
        desc = "Toggle Vertical Terminal Window";
      };
    }
    {
      mode = ["n" "t"];
      key = "<leader><Enter>";
      action = "<cmd>ToggleTerm direction=horizontal<cr>";
      options = {
        desc = "Toggle Horizontal Terminal Window";
      };
    }
    {
      mode = ["n" "t"];
      key = "<leader><Enter>f";
      action = "<cmd>ToggleTerm direction=float<cr>";
      options = {
        desc = "Toggle Floating Terminal Window";
      };
    }
  ];
}

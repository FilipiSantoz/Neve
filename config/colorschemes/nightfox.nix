{ lib, config, ... }:
{
  options = {
    nightfox.enable = lib.mkEnableOption "Enable NightFox module";
  };
  config = lib.mkIf config.nightfox.enable {
    colorschemes = {
      nightfox = {
        enable = true;
        flavor = "nightfox";
        settings = {
          options = {
            terminal_colors = true;
            modules = {
              coc = {
                background = false;
              };
            };
            transparent = true;
            colorblind = {
              enable = false;
            };
          };
          palettes = {
            all = {
              green = "#94e871";
              cyan = "#87f6fd";
              blue = "#8aadf5";
              magenta = "#d29ff5";
              orange = "#f09924";
            };
          };
          groups = {
            all = {
              LineNr = {
                fg = "#ffffff";
              };
              Comment = {
                fg = "#85858f";
              };
              Boolean = {
                fg = "palette.orange";
              };
              Function = {
                fg = "palette.magenta";
              };
              Conditional = {
                fg = "#5f5fc2";
              };
              IncSearch = {
                fg = "#000000";
                bg = "#b1f2dc";
              };
              CursorLineNr = {
                fg = "#ebd3f8";
              };
              NormalFloat = {
                bg = "NONE";
              };
              FloatTitle = {
                bg = "NONE";
                fg = "#ffffff";
              };
              FloatBorder = {
                bg = "NONE";
                fg = "palette.cyan";
              };
              Directory = {
                fg = "palette.blue";
              };
              StatusLine = {
                bg = "NONE";
              };
              # StatusLineNC = {
              #   bg = "#202723";
              # };
              SnacksPickerBorder = {
                bg = "NONE";
                fg = "palette.cyan";
              };
              SnacksPickerGitStatusStaged = {
                fg = "palette.cyan";
              };
              Label = {
                fg = "palette.blue";
              };
              MatchParen = {
                fg = "palette.orange";
                bg = "#373a5d";
              };
              Constant = {
                fg = "#1fde8f";
              };
              Type = {
                fg = "#d42865";
              };
            };
          };
        };
      };
    };
  };
}

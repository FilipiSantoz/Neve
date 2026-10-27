{ lib, config, ... }:
{
  options = {
    nightfox.enable = lib.mkEnableOption "Enable NightFox module";
  };
  config = lib.mkIf config.nightfox.enable {
    colorschemes = {
      nightfox = {
        enable = true;
        flavor = "duskfox";
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
              cyan = "#52bbDE";
              blue = "#8aadf5";
              magenta = "#d29ff5";
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
                fg = "#e0a760";
              };
              Function = {
                fg = "#ceafff";
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
              BufferLineSeparator = {
                fg = "#000000";
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
                fg = "#87f6fd";
              };
              SnacksPickerBorder = {
                bg = "NONE";
                fg = "#87f6fd";
              };
              Directory = {
                fg = "#8aadf5";
              };
              StatusLine = {
                bg = "#232236";
              };
              StatusLineNC = {
                bg = "#232236";
              };
            };
          };
        };
      };
    };
  };
}

{ lib, config, ... }:
{
  options = {
    catppuccin.enable = lib.mkEnableOption "Enable catppuccin module";
  };
  config = lib.mkIf config.catppuccin.enable {
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          background = {
            light = "mocha";
            dark = "macchiato";
          };
          flavour = "macchiato"; # "latte", "mocha", "frappe", "macchiato" or raw lua code
          disable_bold = false;
          disable_italic = false;
          disable_underline = false;
          transparent_background = true;
          term_colors = true;
          integrations = {
            cmp = true;
            noice = true;
            notify = false;
            neotree = true;
            harpoon = false;
            gitsigns = true;
            which_key = true;
            illuminate = {
              enabled = true;
            };
            treesitter = true;
            treesitter_context = true;
            telescope.enabled = true;
            indent_blankline.enabled = true;
            mini.enabled = true;
            native_lsp = {
              enabled = true;
              inlay_hints = {
                background = true;
              };
              underlines = {
                errors = [ "underline" ];
                hints = [ "underline" ];
                information = [ "underline" ];
                warnings = [ "underline" ];
              };
            };
          };
          custom_highlights.__raw = ''
            function(colors)
              return {
                LineNr = { fg = "#ffffff" },
                Comment = { fg = "#85858f" },
                Boolean = { fg = "#e0a760" },
                Function = { fg = "#ceafff" },
                Conditional = { fg = "#5f5fc2" },
                IncSearch = { fg = "#000000", bg = "#b1f2dc" },
                CursorLineNr = { fg = "#ebd3f8" },
                BufferLineSeparator = { fg = "#000000" },
                NeoTreeModified = { fg = "#1fdedc" },
                NeoTreeGitModified = { fg = "#34d5e3" },
                NeoTreeRootName = { fg = "#ffffff" },
                NeoTreeDirectoryIcon = { fg = "#ceafff" },
                NeoTreeDirectoryName = { fg = "#dbdbdb" },
                NeoTreeIndentMarker = { fg = "#aaaaaa" },
                NeoTreeTabActive = { fg = "#ffffff" },
                NeoTreeTabSeparatorInactive = { bg = "NONE", fg = "#000000" },
                NeoTreeTabSeparatorActive = { bg = "NONE", fg = "#ffffff" },
                NormalFloat = { bg = "NONE" },
                FloatTitle = { bg = "NONE", fg = "#ffffff" },
                FloatBorder = { bg = "NONE", fg = "#87f6fd" },
                SnacksPickerBorder = { bg = "None", fg = "#87f6fd" },
                Directory = { fg = "#8aadf5" },
              }
            end
          '';
        };
      };
    };
  };
}

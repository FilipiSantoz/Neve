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
            transparent = true;
            colorblind = {
              enable = false;
            };
          };
          palettes = {
            all = {
              green = "#8bed64";
              cyan = "#94eaf7";
              blue = "#8bbbf4";
              magenta = "#c87df0";
              orange = "#faa028";
              white = "#ffffff";
              neve = "#e3f2ff";
              rust = "#f09751";
              lasse = "#a2f7a1"; # lassë
              luz = "#feffe4";
              mar = "#a0effb";
              rose = "#fa92d6";
              carm = "#e64c7e";
              jeans = "#769bdb";
              sky = "#ccf2ff";
              fn = "#7df0c8";
              serce = "#cf3f62"; # sercë
            };
          };
          groups = {
            all = {
              # General UI
              LineNr = {
                fg = "palette.white";
              };
              Visual = {
                bg = "#243352";
                fg = "palette.neve";
              };
              SnippetTabstop = {
                bg = "#2b3b51";
                fg = "palette.neve";
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
              Normal = {
                fg = "palette.neve";
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
              SnacksPickerFile = {
                fg = "palette.neve";
              };
              SnacksDashboardHeader = {
                fg = "palette.jeans";
              };
              SnacksIndentChunk = {
                fg = "palette.carm";
              };
              SnacksPickerListCursorLine = {
                bg = "#2b3b51";
                fg = "palette.neve";
              };
              SnacksPickerPreviewCursorLine = {
                link = "SnacksPickerListCursorLine";
              };
              Label = {
                fg = "palette.blue";
              };
              MatchParen = {
                fg = "palette.rust";
                bg = "#373a5d";
              };
              Comment = {
                fg = "#85858f";
              };
              CmpItemAbbr = {
                fg = "palette.neve";
              };

              # General LSP
              # Conditional = {
              #   fg = "#bc70c4";
              # };
              Boolean = {
                fg = "palette.rust";
              };
              Function = {
                fg = "palette.magenta";
              };
              Constant = {
                fg = "palette.sky";
              };
              Type = {
                fg = "palette.serce";
              };
              Number = {
                fg = "palette.neve";
              };
              Operator = {
                fg = "palette.mar";
              };
              "@keyword.operator" = {
                link = "Operator";
              };
              "@function.builtin" = {
                fg = "palette.rose";
              };
              "@variable" = {
                fg = "palette.neve";
              };
              "@variable.builtin" = {
                link = "Boolean";
              };
              "@module" = {
                fg = "palette.cyan";
              };
              "@type.builtin" = {
                link = "@module";
              };
              "@constant.builtin" = {
                link = "Constant";
              };
              "@parameter" = {
                fg = "palette.lasse";
              };
              "@property" = {
                fg = "palette.jeans";
              };
              "@punctuation.delimiter" = {
                fg = "palette.luz";
              };
              "@punctuation.bracket" = {
                fg = "palette.luz";
              };

              # Golang only
              "@lsp.typemod.function.definition.go" = {
                fg = "palette.fn";
              };
              "@lsp.typemod.method.definition.go" = {
                fg = "palette.fn";
              };

              # Rust only
              "@lsp.typemod.selfKeyword.declaration.rust" = {
                fg = "palette.carm";
              };
              "@lsp.type.selfKeyword.rust" = {
                fg = "palette.carm";
              };
              "@variable.builtin.rust" = {
                link = "Type";
              };
              "@lsp.type.interface.rust" = {
                fg = "palette.lasse";
              };
              "@lsp.typemod.enumMember.defaultLibrary.rust" = {
                fg = "palette.lasse";
              };
              "@variable.parameter.rust" = {
                link = "@parameter";
              };
              "@lsp.typemod.const.library.rust" = {
                link = "Constant";
              };

              # Frontend
              "@string.special.url" = {
                fg = "palette.blue";
              };
              "@lsp.type.interface.vue" = {
                fg = "palette.lasse";
              };
            };
          };
        };
      };
    };
  };
}

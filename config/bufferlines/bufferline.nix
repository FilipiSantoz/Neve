{ lib, config, ... }:
{
  options = {
    bufferline = {
      enable = lib.mkEnableOption "Enable bufferline module";

      keymaps = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable default keymaps";
        };

        enableHL = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable keymaps for switching buffers with h and l";
        };

        enableTab = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable keymaps for switching buffers with Tab and S-Tab";
        };
      };
    };
  };
  config =
    let
      cfg = config.bufferline;
    in
    lib.mkIf cfg.enable {
      plugins = {
        bufferline = {
          enable = true;
          settings = {
            highlights =
              let
                activeTabBg = "#b095e6";
                activeTabFg = "#1d2837";
                fillBg = "#1e2030";
                modFgSel = "#87f6fd";
                modFg = "#b0e8ff";
                modFgVis = "#b0e8ff";
                normalBg = "#26253c";
                activeBfFg = "#ecf3f9";

              in
              {
                fill = {
                  fg = "NONE";
                  bg = fillBg;
                };
                modified = {
                  fg = modFg;
                  bg = normalBg;
                };
                modified_selected = {
                  fg = modFgSel;
                  bg = normalBg;
                };
                modified_visible = {
                  fg = modFgVis;
                  bg = normalBg;
                };
                buffer_selected = {
                  fg = activeBfFg;
                  bg = normalBg;
                };
                separator_visible = {
                  fg = "NONE";
                  bg = fillBg;
                };

                # Most right tabs
                tab_selected = {
                  fg = activeTabFg;
                  bg = activeTabBg;
                };
                tab_separator = {
                  fg = fillBg;
                  bg = normalBg;
                };
                tab_separator_selected = {
                  fg = fillBg;
                  bg = activeTabBg;
                };
              };
            options = {
              show_buffer_icons = false;
              buffer_close_icon = "✘";
              show_close_icon = false;
              show_tab_indicators = true;
              truncate_names = true;
              separator_style = "thin";
              tab_size = 10;
              max_name_length = 14;
              max_prefix_length = 12;
              # left_trunc_marker = "";
              # right_trunc_marker = "";
              # name_formatter = ''
              #   function(buf)
              #     if buf.bufnr == vim.api.nvim_get_current_buf() then
              #       return "󰅱"
              #     else
              #       return ""
              #     end
              #   end
              # '';
              offsets = [
                {
                  filetype = "neo-tree";
                  text = "Neo-tree";
                  highlight = "Directory";
                  text_align = "left";
                }
              ];
            };
          };
        };
        # https://github.com/tiagovla/scope.nvim
        scope = {
          enable = true;
        };
      };
      keymaps = lib.mkIf cfg.keymaps.enable (
        [
          {
            mode = "n";
            key = "<leader>bd";
            action = "<cmd>bdelete<cr>";
            options = {
              desc = "Delete buffer";
            };
          }

          {
            mode = "n";
            key = "<leader>bb";
            action = "<cmd>e #<cr>";
            options = {
              desc = "Switch to Other Buffer";
            };
          }

          # {
          #   mode = "n";
          #   key = "<leader>`";
          #   action = "<cmd>e #<cr>";
          #   options = {
          #     desc = "Switch to Other Buffer";
          #   };
          # }

          {
            mode = "n";
            key = "<leader>br";
            action = "<cmd>BufferLineCloseRight<cr>";
            options = {
              desc = "Delete buffers to the right";
            };
          }

          {
            mode = "n";
            key = "<leader>bl";
            action = "<cmd>BufferLineCloseLeft<cr>";
            options = {
              desc = "Delete buffers to the left";
            };
          }

          {
            mode = "n";
            key = "<leader>bo";
            action = "<cmd>BufferLineCloseOthers<cr>";
            options = {
              desc = "Delete other buffers";
            };
          }

          {
            mode = "n";
            key = "<leader>bp";
            action = "<cmd>BufferLineTogglePin<cr>";
            options = {
              desc = "Toggle pin";
            };
          }

          {
            mode = "n";
            key = "<leader>bP";
            action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
            options = {
              desc = "Delete non-pinned buffers";
            };
          }
        ]
        ++ (lib.optionals cfg.keymaps.enableTab [
          {
            mode = "n";
            key = "<Tab>";
            action = "<cmd>BufferLineCycleNext<cr>";
            options = {
              desc = "Cycle to next buffer";
            };
          }

          {
            mode = "n";
            key = "<S-Tab>";
            action = "<cmd>BufferLineCyclePrev<cr>";
            options = {
              desc = "Cycle to previous buffer";
            };
          }
        ])
        ++ (lib.optionals cfg.keymaps.enableHL [
          {
            mode = "n";
            key = "<S-l>";
            action = "<cmd>BufferLineCycleNext<cr>";
            options = {
              desc = "Cycle to next buffer";
            };
          }

          {
            mode = "n";
            key = "<S-h>";
            action = "<cmd>BufferLineCyclePrev<cr>";
            options = {
              desc = "Cycle to previous buffer";
            };
          }
        ])
      );
    };
}

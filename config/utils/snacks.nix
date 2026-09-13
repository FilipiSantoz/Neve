{
  lib,
  config,
  ...
}:
{
  options = {
    snacks.enable = lib.mkEnableOption "Enable nvim-snacks modules";
  };
  config = lib.mkIf config.snacks.enable {
    plugins.snacks = {
      enable = true;
      settings = {
        indent = {
          hl = "SnacksIndendt";
          indent = {
            char = "┊";
          };
          scope = {
            enabled = false;
          };
          chunk = {
            enabled = true;
            char = {
              corner_top = "╭";
              corner_bottom = "╰";
            };
          };
          # função lua -> __raw
          filter.__raw = ''
            function(buf)
              return vim.g.snacks_indent ~= false
                and vim.b[buf].snacks_indent ~= false
                and vim.bo[buf].buftype == ""
                and vim.bo[buf].filetype ~= "markdown"
            end
          '';
        };

        scope.enabled = true;
        scroll.enabled = true;

        notifier = {
          # vim.log.levels.TRACE é uma expressão lua, não um valor nix -> __raw
          level.__raw = "vim.log.levels.TRACE";
          icons = {
            error = " ";
            warn = " ";
            info = " ";
            debug = " ";
            trace = " ";
          };
        };

        lazygit = {
          win = {
            border = "rounded";
            width = 0.9;
            height = 0.9;
          };
        };

        input.enabled = true;
        bigfile.enabled = true;

        statuscolumn = {
          enabled = true;
          left = [
            "mark"
            "sign"
          ];
          right = [
            "fold"
            "git"
          ];
        };

        words.enabled = true;

        picker = {
          files.hidden = true;
          buffers.layout = "select";
        };

        win = {
          input = {
            # cada entrada é uma tabela lua "mista": { "close", mode = {...} }
            # posição 1 (a ação) vira __unkeyed-1, o resto (mode) fica normal
            keys = {
              "<Esc>" = {
                __unkeyed-1 = "close";
                mode = [
                  "n"
                  "i"
                ];
              };
              "<C-e>" = {
                __unkeyed-1 = "toggle_preview";
                mode = [
                  "i"
                  "n"
                ];
              };
              "<C-u>" = {
                __unkeyed-1 = "preview_scroll_up";
                mode = [
                  "i"
                  "n"
                ];
              };
              "<C-d>" = {
                __unkeyed-1 = "preview_scroll_down";
                mode = [
                  "i"
                  "n"
                ];
              };
              "<C-f>" = {
                __unkeyed-1 = "list_scroll_down";
                mode = [
                  "i"
                  "n"
                ];
              };
              "<C-b>" = {
                __unkeyed-1 = "list_scroll_up";
                mode = [
                  "i"
                  "n"
                ];
              };
              "<C-p>" = {
                __unkeyed-1 = "history_back";
                mode = [
                  "i"
                  "n"
                ];
              };
              "<C-n>" = {
                __unkeyed-1 = "history_forward";
                mode = [
                  "i"
                  "n"
                ];
              };
            };
          };

          preview = {
            wo.signcolumn = "no";
          };

          styles = {
            notification.wo.wrap = true;
            terminal.keys.term_normal = false;

            input = {
              row = -3;
              col = -5;
              width = 32;
              relative = "cursor";
              title_pos = "left";
              keys = {
                # { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true }
                i_esc = {
                  __unkeyed-1 = "<esc>";
                  __unkeyed-2 = [
                    "cmp_close"
                    "cancel"
                  ];
                  mode = "i";
                  expr = true;
                };
              };
            };
          };
        };

        dashboard = {
          preset = {
            header = ''

              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⢀⣀⠈
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⢀⡀⠉⠛⢿⣿⣿⡿⠿⠁⢀⣶⣿⣿⣧
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⢠⣾⣿⣷⣦⡄⠀⣀⠀⢠⣶⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⣼⣿⣿⣿⣿⡇ ⣿ ⢸⣿⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢿⣿⠟⢿⡿⠿⠿⣿⠿⢿⡿⢿⡿⢿⠿⠿⣿⡿⢿⡿⢿⣿⣿⣿⣿⣿⡿⢿⣿⣧⣠⣿⣿⣿⣿⣿⣿⣾⣿⣷⣿⣿⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⡀⠻⠀⢸⡇⣛⣻⠁⣾⡆⢱⠸⠇⣾⡇⢸⣿⠁⣄⣠⠈⣿⣿⣿⣿⣿⣄⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠿⣿⣿⣿⣿⣏⠀⣨
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣿⣦⣤⣾⣧⣭⣭⣷⣬⣴⣿⣦⣴⣿⣥⣬⣿⣦⣿⣿⣴⣿⣿⣿⣿⣏⣀⣀⣨⣿⣿⡁⠀⣹⣿⣿⣿⠀⢠⣄⠈⢻⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠿⠿⠻⠿⠿⣿⣏⠉⢻⣿⣿⣿⣿⣿⡄⠘⢿⣆⠀⢻⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⢦⣤⣤⣶⣤⣤⣀⣀⠀⠀⠉⠛⠛⠛⢻⣿⣄⠈⠛⠀⢸⣿⣿⣿⣿
              ⣿⣿⣿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠙⢿⣿⠿⠿⢿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣷⣶⣶⣿⣿⣿⣿⣿
              ⡿⠋⢀⣤⣤⣀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠸⠏⠀⣤⣀⣀⠉⠉⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⠀⣰⣿⣿⣿⣿⣷⣤⡀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠉⣀⣠⣤⣶⡀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣴⣾⣿⣿⣿⣿⣿⣆⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⢠⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠙⠻⠿⠟⠛⠛⠛⠟⠁⣀⣴⣿⣿⣿⣿⣿⣿⡀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠈⢿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⣴⡄⠀⣴⣶⡄ ⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠈⢿⣿⣿⠋⠉⣀⣀⣤⣤⣤
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⣿⡇⠀⣿⣿⡇ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠙⠏⠀⣼⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣾⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣾⣿⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⣿⣿⡟⠉⠉⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⠤⠴⠶⠾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⣿⣿⣷⣤⣤⣾⣿⣿⣿⣿⣿⣿⣿⠿⠋⢉⣀⠉⢻⣿⣿⣿⣿⡿⠛⠻⣿⣿⣿⣿⣧⣤⣤⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⣠⣴⣿⣿⠀⢸⣿⣿⣿⣿⣷⣤⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢀⣴⣿⣿⣿⠏⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢀⣾⣿⣿⣿⠋⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⠙⠻⠿⣿⣿⣿⣿⣿⡟⠀⣾⣿⣿⠟⠁⣠⣾⣿⣿⣿⣿⣿⠿⠿⠿⠛⠁⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
              ⠀⣠⣤⣾⣿⣿⣿⣿⣷⡀⠙⠋⠁⣠⣾⣿⣿⣿⣿⣿⣿⣀⣤⠀⠀⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

            '';

            keys = [
              {
                text = [
                  {
                    __unkeyed-1 = "  ";
                    hl = "Label";
                  }
                  {
                    __unkeyed-1 = "New File";
                    hl = "CursorLineNr";
                    width = 55;
                  }
                  {
                    __unkeyed-1 = "n";
                    hl = "Constant";
                  }
                ];
                key = "n";
                action = ":ene | startinsert";
              }
              {
                text = [
                  {
                    __unkeyed-1 = "  ";
                    hl = "Label";
                  }
                  {
                    __unkeyed-1 = "Find File";
                    hl = "CursorLineNr";
                    width = 55;
                  }
                  {
                    __unkeyed-1 = "f";
                    hl = "Constant";
                  }
                ];
                action.__raw = "function() Snacks.picker.files() end";
                key = "f";
              }
              {
                text = [
                  {
                    __unkeyed-1 = "󱎸  ";
                    hl = "Label";
                  }
                  {
                    __unkeyed-1 = "Find Text";
                    hl = "CursorLineNr";
                    width = 55;
                  }
                  {
                    __unkeyed-1 = "g";
                    hl = "Constant";
                  }
                ];
                action.__raw = "function() Snacks.picker.grep() end";
                key = "g";
              }
              {
                text = [
                  {
                    __unkeyed-1 = "󱋡  ";
                    hl = "Label";
                  }
                  {
                    __unkeyed-1 = "Recent Files";
                    hl = "CursorLineNr";
                    width = 55;
                  }
                  {
                    __unkeyed-1 = "r";
                    hl = "Constant";
                  }
                ];
                action.__raw = "function() Snacks.picker.recent() end";
                key = "r";
              }
              {
                text = [
                  {
                    __unkeyed-1 = "  ";
                    hl = "Label";
                  }
                  {
                    __unkeyed-1 = "Recent Projects";
                    hl = "CursorLineNr";
                    width = 55;
                  }
                  {
                    __unkeyed-1 = "p";
                    hl = "Constant";
                  }
                ];
                action.__raw = "function() Snacks.picker.projects() end";
                key = "p";
              }
              {
                text = [
                  {
                    __unkeyed-1 = "󰈆  ";
                    hl = "Label";
                  }
                  {
                    __unkeyed-1 = "Quit";
                    hl = "CursorLineNr";
                    width = 55;
                  }
                  {
                    __unkeyed-1 = "q";
                    hl = "Constant";
                  }
                ];
                action = ":qa";
                key = "q";
              }
            ];
          };

          sections = [
            { section = "header"; }
            {
              section = "keys";
              gap = 1;
              padding = 3;
            }
            {
              # # { function() ... end } -> tabela com um único item posicional
              # __unkeyed-1.__raw = ''
              #   function()
              #     local count = 0
              #     local plugins = (vim.pack and vim.pack.get) and vim.pack.get() or {}
              #     local total = #plugins
              #     local loaded = 0
              #
              #     if vim.pack and vim.pack.get then
              #       count = #vim.pack.get()
              #     else
              #       for _, p in ipairs(vim.opt.packpath:get()) do
              #         count = count + #vim.fn.glob(p .. "/pack/*/start/*", false, true)
              #         count = count + #vim.fn.glob(p .. "/pack/*/opt/*", false, true)
              #       end
              #     end
              #     for _, plugin in ipairs(plugins) do
              #       if plugin.active then
              #         loaded = loaded + 1
              #       end
              #     end
              #     local start_time = _G.start_time or vim.uv.hrtime()
              #     local ms = (vim.uv.hrtime() - start_time) / 1e6
              #
              #     return {
              #       align = "center",
              #       text = {
              #         { "󰒲 ", hl = "LineNr" },
              #         { "Neovim loaded ", hl = "CursorLineNr" },
              #         { tostring(loaded), hl = "Label" },
              #         { "/", hl = "Comment" },
              #         { tostring(total), hl = "Label" },
              #         { " plugins in ", hl = "CursorLineNr" },
              #         { string.format("%.0fms", ms), hl = "Label" },
              #       },
              #     }
              #   end
              # '';
            }
          ];
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>un";
        action.__raw = "function() Snacks.notifier.hide() end";
        options.desc = "Dismiss all Notification";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action.__raw = "function() Snacks.lazygit() end";
        options.desc = "Lazygit";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action.__raw = "function() Snacks.lazygit.log() end";
        options.desc = "Git log";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action.__raw = "function() Snacks.picker.git_status() end";
        options.desc = "Git Stash";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action.__raw = "function() Snacks.bufdelete() end";
        options.desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>jj";
        action.__raw = "function() Snacks.scope.jump() end";
        options.desc = "Jump to Scope Boundary";
      }
      {
        mode = "n";
        key = "]]";
        action.__raw = "function() Snacks.words.jump(vim.v.count1) end";
        options.desc = "Next Reference";
      }
      {
        mode = "n";
        key = "[[";
        action.__raw = "function() Snacks.words.jump(-vim.v.count1) end";
        options.desc = "Prev Reference";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>fw";
        action.__raw = "function() Snacks.picker.grep_word() end";
        options.desc = "Visual selection or word";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action.__raw = "function() Snacks.picker.grep_buffers() end";
        options.desc = "Grep Open Buffers";
      }
      {
        mode = "n";
        key = "<leader>fl";
        action.__raw = "function() Snacks.picker.lines() end";
        options.desc = "Buffer Lines";
      }
      {
        mode = "n";
        key = "<C-'>";
        action.__raw = "function() Snacks.terminal() end";
        options.desc = "toggle terminal";
      }
    ];
  };
}

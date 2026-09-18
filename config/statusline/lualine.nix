{
  lib,
  config,
  ...
}:
{
  options = {
    lualine.enable = lib.mkEnableOption "Enable lualine module";
  };
  config = lib.mkIf config.lualine.enable {
    plugins.lualine = {
      enable = true;
      settings = {
        iconsEnabled = true;
        theme = "auto";
        component_separators = { };
        section_separators = { };
        disabled_filetypes = {
          statusline = [ "dashboard" ];
        };
        globalstatus = true;

        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              fmt.__raw = "function(str) return str:sub(1, 1) end";
              separator = {
                left = "";
                right = "";
              };
              padding = {
                left = 2;
                right = 2;
              };
            }
          ];

          lualine_b = [
            {
              __unkeyed-1 = "branch";
              separator = {
                right = "";
              };
              icon = {
                __unkeyed-1 = " ";
                align = "right";
                # color = {
                #   fg.__raw = "require('catppuccin.palettes').get_palette('macchiato').white";
                #   gui = "bold";
                # };
              };
              color = {
                # bg = "NONE";
                gui = "bold";
              };

            }
            {
              __unkeyed-1 = "filename";
              file_status = true;
              new_file_status = false;
              path = 0;
              shorting_target = 40;
              symbols = {
                modified = " ●";
                readonly = " ";
                unnamed = "[No name]";
                newfile = "[New]";
              };
              color = {
                fg.__raw = "require('catppuccin.palettes').get_palette('macchiato').lavender";
                bg = "NONE";
                gui = "bold";
              };
            }
          ];

          lualine_c = [
            {
              __unkeyed-1 = "diff";
              source.__raw = ''
                function()
                  local gitsigns = vim.b.gitsigns_status_dict
                  if gitsigns then
                    return {
                      added = gitsigns.added,
                      modified = gitsigns.changed,
                      removed = gitsigns.removed,
                    }
                  end
                end
              '';
              symbols = {
                added = " ";
                modified = " ";
                removed = " ";
              };
              cond.__raw = "_G.lualine_hide_in_width";
            }
            {
              __unkeyed-1.__raw = ''
                function()
                  if not package.loaded["dap"] then
                    return ""
                  end
                  return require("dap").status()
                end
              '';
              icon = " ";
              color.fg.__raw = "require('catppuccin.palettes').get_palette('macchiato').yellow";
              cond.__raw = ''
                function()
                  return package.loaded["dap"] and require("dap").status() ~= ""
                end
              '';
            }
            {
              __unkeyed-1 = "diagnostics";
              sources = [ "nvim_diagnostic" ];
              sections = [
                "error"
                "warn"
                "info"
                "hint"
              ];
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
                hint = "󱠂";
              };
              cond.__raw = "_G.lualine_hide_in_width";
            }
          ];

          lualine_x = [
            {
              __unkeyed-1 = "filesize";
              icon = "󰙴";
              color.fg.__raw = "require('catppuccin.palettes').get_palette('macchiato').lavender";
              padding = {
                left = 1;
                right = 1;
              };
              cond.__raw = "_G.lualine_hide_in_width";
            }
            {
              __unkeyed-1 = "filetype";
              colored = true;
              icon_only = true;
              cond.__raw = "_G.lualine_hide_in_width";
            }
          ];

          lualine_y = [
            {
              __unkeyed-1.__raw = ''
                function()
                  local words = vim.fn.wordcount().words
                  return string.format(" %d ", words)
                end
              '';
              cond.__raw = ''
                function()
                  local ft = vim.bo.filetype
                  return ft == "markdown" or ft == "text" or ft == "txt"
                end
              '';
              color.fg.__raw = "require('catppuccin.palettes').get_palette('macchiato').lavender";
              padding = {
                left = 1;
                right = 1;
              };
            }
          ];

          lualine_z = [
            {
              __unkeyed-1.__raw = ''
                function()
                  local line = vim.fn.line(".")
                  local lines = vim.fn.line("$")
                  local col = vim.fn.virtcol(".")
                  return string.format("%d/%d:%d", line, lines, col)
                end
              '';
              icon = {
                __unkeyed-1 = "";
                gui = "bold";
              };
              color.gui = "bold";
              cond.__raw = "_G.lualine_hide_in_width";
              separator = {
                left = "";
                right = "";
              };
            }
          ];
        };
      };
    };

    # única coisa que sobrevive do extraConfigLua original: a condição
    # "hide_in_width", compartilhada entre vários componentes acima.
    extraConfigLuaPre = ''
      _G.lualine_hide_in_width = function()
        return vim.o.columns > 100
      end
    '';
  };
}

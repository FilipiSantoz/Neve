{ lib, config, ... }:
{
  options = {
    winbar.enable = lib.mkEnableOption "Enable navic breadcrumbs via lualine winbar";
  };

  config = lib.mkIf config.winbar.enable {
    plugins.navic = {
      enable = true;
      settings = {
        lsp = {
          auto_attach = true;
          preference = [
            "rust_analyzer"
          ];
        };
      };
    };

    plugins.lualine.settings = {
      winbar = {
        lualine_a = [ ];
        lualine_b = [
          {
            __unkeyed-1 = "filetype";
            colored = false;
            icon_only = true;
            icon = {
              align = "left";
            };
          }
        ];
        lualine_c = [
          {
            __unkeyed-1.__raw = "function() return require('nvim-navic').get_location() end";
            cond.__raw = "function() return require('nvim-navic').is_available() end";
          }
        ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ ];
      };
      inactive_winbar = {
        lualine_a = [ ];
        lualine_b = [ ];
        lualine_c = [
          {
            __unkeyed-1.__raw = "function() return require('nvim-navic').get_location() end";
            cond.__raw = "function() return require('nvim-navic').is_available() end";
          }
        ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ ];
      };
    };
  };
}

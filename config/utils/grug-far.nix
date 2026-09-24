{
  lib,
  config,
  ...
}:
{
  options = {
    grug-far.enable = lib.mkEnableOption "Enable grug-far module";
  };

  config = lib.mkIf config.grug-far.enable {
    plugins.grug-far = {
      enable = true;
      settings = {
        transient = true;
        debounceMs = 1000;
        engine = "ripgrep";
        engines = {
          ripgrep = {
            path = "rg";
            showReplaceDiff = true;
          };
        };
        maxSearchMatches = 2000;
        maxWorkers = 8;
        minSearchChars = 1;
        normalModeSearch = false;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gs";
        action.__raw = "function() require('grug-far').open() end";
        options.desc = "Search and Replace (Grug-far)";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action.__raw = "function() require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } }) end";
        options = {
          silent = true;
          desc = "Search and Replace (Grug-far) Current File";
        };
      }
    ];
  };
}

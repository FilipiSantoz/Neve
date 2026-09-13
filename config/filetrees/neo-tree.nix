{
  lib,
  config,
  ...
}:
{
  options = {
    neo-tree.enable = lib.mkEnableOption "Enable neo-tree module";
  };
  config = lib.mkIf config.neo-tree.enable {
    plugins.neo-tree = {
      enable = true;
      settings = {
        windbar = true;
        contentLayout = "center";
        truncation_character = "…";
        separator = {
          left = "▏";
          right = "▕";
        };
        enableDiagnostics = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
        closeIfLastWindow = true;
        popupBorderStyle = "NC"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
        buffers = {
          bindToCwd = false;
          followCurrentFile = {
            enabled = true;
          };
        };
        indent = {
          indentSize = 2;
          padding = 2;
          withMarkers = true;
          indentMarker = "│";
          lastIndentMarker = "╰";
          expanderCollapsed = "";
          expanderExpanded = "";
        };
        icon = {
          folderClosed = "";
          folderOpen = "";
          folderEmpty = "󰜌";
          folderEmptyOpen = "󰷏";
          useFilteredColors = true;
          selected = "󰐾";
          default = "*";
        };
        git_status = {
          symbols = {
            added = "🞥";
            modified = "";
            deleted = "✖";
            renamed = "󰁕";
            untracked = "";
            ignored = "";
            unstaged = "🟒";
            staged = "";
            conflict = "";
          };
        };
        window = {
          position = "left";
          width = 40;
          mappingOptions = {
            noremap = true;
            nowait = true;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle reveal_force_cwd<cr>";
        options = {
          silent = true;
          desc = "Explorer NeoTree (root dir)";
        };
      }
      {
        mode = "n";
        key = "<leader>E";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          silent = true;
          desc = "Explorer NeoTree (cwd)";
        };
      }
      {
        mode = "n";
        key = "<leader>be";
        action = ":Neotree buffers<CR>";
        options = {
          silent = true;
          desc = "Buffer explorer";
        };
      }
      {
        mode = "n";
        key = "<leader>ge";
        action = ":Neotree git_status<CR>";
        options = {
          silent = true;
          desc = "Git explorer";
        };
      }
    ];
  };
}

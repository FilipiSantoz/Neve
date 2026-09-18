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
        source_selector = {
          winbar = true;
          content_layout = "center";
          truncation_character = "…";
          separator = {
            left = "▏";
            right = "▕";
          };
        };
        enable_diagnostics = true;
        enable_git_status = true;
        enable_modified_markers = true;
        enable_refresh_on_write = true;
        close_if_last_window = true;
        popup_border_style = "NC";
        buffers = {
          bind_to_cwd = false;
          follow_current_file = {
            enabled = true;
          };
        };
        filesystem = {
          bind_to_cwd = false;
          follow_current_file = {
            enabled = true;
          };
        };

        default_component_configs = {
          indent = {
            indent_size = 2;
            padding = 2;
            with_markers = true;
            indent_marker = "│";
            last_indent_marker = "╰";
            with_expanders = false;
            # expander_collapsed = "";
            # expander_expanded = "";
          };
          icon = {
            folder_closed = "";
            folder_open = "";
            folder_empty = "󰜌";
            folder_empty_open = "󰷏";
            use_filtered_colors = true;
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
        };

        window = {
          position = "left";
          width = 40;
          mapping_options = {
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

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    incline.enable = lib.mkEnableOption "Enable incline.nvim floating statusline";
  };

  config = lib.mkIf config.incline.enable {
    extraPlugins = [
      pkgs.vimPlugins.incline-nvim
    ];

    extraConfigLua = ''
      local helpers = require 'incline.helpers'
      local devicons = require 'nvim-web-devicons'
      require('incline').setup {
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == ' ' then
            filename = '[T-T]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified

          local function get_git_diff()
            local icons = { added = '', changed = '󰏭',  removed = '' }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. ' ', signs[name] .. ' ', group = 'Diff' .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { '┊' })
            end
            return labels
          end

          return {
            { get_git_diff() },
            {' ' .. (ft_icon or ' ') .. ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color), ' ' } or "",
            {' ' .. filename .. ' ' },
            modified and { '● ' } or "",
            -- guibg = '#AA99C7',
          }
        end,
      }

    '';
  };
}

{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    nvim-dap.enable = lib.mkEnableOption "Enable Debug Adapter Protocol module";
  };
  config = lib.mkIf config.nvim-dap.enable {

    plugins = {
      dap = {
        enable = true;
        lazyLoad.settings = {
          cmd = [
            "DapToggleBreakpoint"
            "DapContinue"
            "DapStepInto"
            "DapStepOut"
            "DapStepOver"
            "DapToggleRepl"
            "DapTerminate"
          ];
          keys = [
            {
              __unkeyed-1 = "<leader>dB";
              __unkeyed-2.__raw = "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
              desc = "Breakpoint Condition";
            }
            {
              __unkeyed-1 = "<leader>da";
              __unkeyed-2.__raw = "function() require('dap').continue({ before = get_args }) end";
              desc = "Run with Args";
            }
            {
              __unkeyed-1 = "<leader>dC";
              __unkeyed-2.__raw = "function() require('dap').run_to_cursor() end";
              desc = "Run to cursor";
            }
            {
              __unkeyed-1 = "<leader>dg";
              __unkeyed-2.__raw = "function() require('dap').goto_() end";
              desc = "Go to line (no execute)";
            }
            {
              __unkeyed-1 = "<leader>dj";
              __unkeyed-2.__raw = "function() require('dap').down() end";
              desc = "Down";
            }
            {
              __unkeyed-1 = "<leader>dk";
              __unkeyed-2.__raw = "function() require('dap').up() end";
              desc = "Up";
            }
            {
              __unkeyed-1 = "<leader>dl";
              __unkeyed-2.__raw = "function() require('dap').run_last() end";
              desc = "Run Last";
            }
            {
              __unkeyed-1 = "<leader>dp";
              __unkeyed-2.__raw = "function() require('dap').pause() end";
              desc = "Pause";
            }
            {
              __unkeyed-1 = "<leader>ds";
              __unkeyed-2.__raw = "function() require('dap').session() end";
              desc = "Session";
            }
            {
              __unkeyed-1 = "<leader>dw";
              __unkeyed-2.__raw = "function() require('dap.ui.widgets').hover() end";
              desc = "Widgets";
            }
          ];
        };
        # dap-go precisa estar carregado junto com o dap; dap-ui/virtual-text
        # já dependiam disso antes também.
        luaConfig.pre = ''
          require('lz.n').trigger_load('nvim-dap-go')
          require('lz.n').trigger_load('nvim-dap-ui')
          require('lz.n').trigger_load('nvim-dap-virtual-text')
        '';
        signs = {
          dapBreakpoint = {
            text = "󰄛 ";
            texthl = "DapBreakpoint";
          };
          dapStopped = {
            text = "󰋇 ";
            texthl = "DapStopped";
          };
          dapBreakpointCondition = {
            text = "󰄛 ";
            texthl = "DapBreakpointCondition";
          };
          dapLogPoint = {
            text = "◆";
            texthl = "DapLogPoint";
          };
        };

        adapters = {
          executables = {
            lldb.command = lib.getExe' pkgs.lldb "lldb-vscode";
          };
          servers = {
            codelldb = {
              port = 13000;
              executable = {
                command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
                args = [
                  "--port"
                  "13000"
                ];
              };
            };
          };
        };

        configurations = {
          java = [
            {
              type = "java";
              request = "launch";
              name = "Debug (Attach) - Remote";
              hostName = "127.0.0.1";
              port = 5005;
            }
          ];

          rust = [
            {
              name = "Launch (CodeLLDB)";
              type = "codelldb";
              request = "launch";
              program.__raw = ''
                function()
                  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                end
              '';
              cwd = "\${workspaceFolder}";
              stopOnEntry = false;
            }
          ];
        };
      };

      dap-virtual-text = {
        enable = true;
        lazyLoad.settings.lazy = true;
      };

      dap-ui = {
        enable = true;
        lazyLoad.settings = {
          before.__raw = "function() require('lz.n').trigger_load('nvim-dap') end";
          keys = [
            {
              __unkeyed-1 = "<leader>du";
              __unkeyed-2.__raw = "function() require('dapui').toggle() end";
              desc = "Dap UI";
            }
            {
              __unkeyed-1 = "<leader>de";
              __unkeyed-2.__raw = "function() require('dapui').eval() end";
              mode = [
                "n"
                "v"
              ];
              desc = "Eval";
            }
          ];
        };
        luaConfig.post = ''

          -- Opens the UI when start/stop an debug session
          local dap = require("dap")
          local dapui = require("dapui")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          -- Close UI when end an debug session
          dap.listeners.before.event_terminated["dapui_config"] = function()
          	dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
          	dapui.close()
          end

        '';

        settings = {
          floating = {
            border = "rounded";
            mappings = {
              close = [
                "<ESC>"
                "q"
              ];
            };
          };
          layouts = [
            {
              elements = [
                {
                  id = "scopes";
                  size = 0.32;
                }
                {
                  id = "breakpoints";
                  size = 0.21;
                }
                {
                  id = "stacks";
                  size = 0.21;
                }
                {
                  id = "watches";
                  size = 0.26;
                }
              ];
              position = "right";
              size = 50;
            }
            {
              elements = [
                {
                  id = "repl";
                  size = 0.4;
                }
                {
                  id = "console";
                  size = 0.4;
                }
              ];
              position = "bottom";
              size = 12;
            }
          ];
        };
      };

      dap-go = {
        enable = true;
        lazyLoad.settings.lazy = true;
        settings = {
          delve = {
            path = "dlv";
            initialize_timeout_sec = 20;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>db";
        action = ":DapToggleBreakpoint<cr>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = ":DapContinue<cr>";
        options = {
          silent = true;
          desc = "Continue";
        };
      }
      {
        mode = "n";
        key = "<leader>di";
        action = ":DapStepInto<cr>";
        options = {
          silent = true;
          desc = "Step into";
        };
      }
      {
        mode = "n";
        key = "<leader>do";
        action = ":DapStepOut<cr>";
        options = {
          silent = true;
          desc = "Step Out";
        };
      }
      {
        mode = "n";
        key = "<leader>dO";
        action = ":DapStepOver<cr>";
        options = {
          silent = true;
          desc = "Step Over";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = ":DapToggleRepl<cr>";
        options = {
          silent = true;
          desc = "Toggle REPL";
        };
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = ":DapTerminate<cr>";
        options = {
          silent = true;
          desc = "Terminate";
        };
      }
    ];
  };
}

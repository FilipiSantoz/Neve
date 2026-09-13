{
  lib,
  config,
  ...
}: {
  options = {
    lsp-nvim.enable = lib.mkEnableOption "Enable lsp-nvim module";
  };
  config = lib.mkIf config.lsp-nvim.enable {
    plugins = {
      lsp = {
        enable = true;
        capabilities = "offsetEncoding = 'utf-16'";
        servers = {
          clangd = {
            enable = true;
          };
          lua_ls = {
            enable = true;
            extraOptions = {
              settings = {
                Lua = {
                  completion = {
                    callSnippet = "Replace";
                  };
                  diagnostics = {
                    globals = ["vim"];
                  };

                  telemetry = {
                    enabled = false;
                  };
                  hint = {
                    enable = true;
                  };
                };
              };
            };
          };
          nil_ls = {
            enable = false;
          };
          nixd = {
            enable = true;
          };
          ts_ls = {
            enable = true;
            autostart = true;
            filetypes = [
              "javascript"
              "javascriptreact"
              "typescript"
              "typescriptreact"
            ];
            extraOptions = {
              settings = {
                javascript = {
                  inlayHints = {
                    includeInlayEnumMemberValueHints = true;
                    includeInlayFunctionLikeReturnTypeHints = true;
                    includeInlayFunctionParameterTypeHints = true;
                    includeInlayParameterNameHints = "all";
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                    includeInlayPropertyDeclarationTypeHints = true;
                    includeInlayVariableTypeHints = true;
                    includeInlayVariableTypeHintsWhenTypeMatchesName = true;
                  };
                };
                typescript = {
                  inlayHints = {
                    includeInlayEnumMemberValueHints = true;
                    includeInlayFunctionLikeReturnTypeHints = true;
                    includeInlayFunctionParameterTypeHints = true;
                    includeInlayParameterNameHints = "all";
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                    includeInlayPropertyDeclarationTypeHints = true;
                    includeInlayVariableTypeHints = true;
                    includeInlayVariableTypeHintsWhenTypeMatchesName = true;
                  };
                };
              };
            };
          };
          eslint = {
            enable = true;
          };
          pyright = {
            enable = true;
          };
          ruff = {
            enable = true;
          };

          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            settings = {
              checkOnSave = true;
              check = {
                command = "clippy";
              };
              # inlayHints = {
              #   enable = true;
              #   showParameterNames = true;
              #   parameterHintsPrefix = "<- ";
              #   otherHintsPrefix = "=> ";
              # };
              procMacro = {
                enable = true;
              };
            };
          };
          gopls = {
            enable = true;
            settings.settings.gopls = {
              gofumpt = true;
              codelenses = {
                gc_details = false;
                generate = true;
                regenerate_cgo = true;
                run_govulncheck = true;
                test = true;
                tidy = true;
                upgrade_dependency = true;
                vendor = true;
              };
              hints = {
                assignVariableTypes = true;
                compositeLiteralFields = true;
                compositeLiteralTypes = true;
                constantValues = true;
                functionTypeParameters = true;
                parameterNames = true;
                rangeVariableTypes = true;
              };
              analyses = {
                fieldalignment = true;
                nilness = true;
                unusedparams = true;
                unusedwrite = true;
                useany = true;
              };
              usePlaceholders = true;
              completeUnimported = true;
              staticcheck = true;
              directoryFilters = [
                "-.git"
                "-node_modules"
                "-.nvim"
              ];
              semanticTokens = true;
            };
          };
        };
        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "Workspace Symbol";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Code Action";
            };
            "<C-k>" = {
              action = "signature_help";
              desc = "Signature Help";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
          };
        };
        onAttach = ''
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(false)
              end
              vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            end,
          })
        '';
      };
    };
    extraConfigLua = ''
      require("lspconfig.ui.windows").default_options = { border = "rounded" }

      vim.lsp.config("*", {
        handlers = {
          ["textDocument/hover"] = function(err, result, ctx, config)
            vim.lsp.handlers.hover(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
          end,
          ["textDocument/signatureHelp"] = function(err, result, ctx, config)
            vim.lsp.handlers.signature_help(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
          end,
        },
      })

      vim.diagnostic.config({
        float = { border = "rounded" },
        virtual_text = { prefix = "" },
        signs = true,
        underline = true,
        update_in_insert = true,
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "[d";
        action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
        options = {
          silent = true;
          desc = "Next Diagnostic";
        };
      }
      {
        mode = "n";
        key = "]d";
        action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
        options = {
          silent = true;
          desc = "Previous Diagnostic";
        };
      }
    ];
  };
}

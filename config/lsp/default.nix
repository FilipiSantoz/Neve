{
  lib,
  config,
  ...
}: {
  imports = [
    ./conform.nix
    ./fidget.nix
    ./lsp-nvim.nix
    ./trouble.nix
  ];

  options = {
    lsp.enable = lib.mkEnableOption "Enable lsp module";
  };
  config = lib.mkIf config.lsp.enable {
    conform.enable = lib.mkDefault true;
    fidget.enable = lib.mkDefault false;
    lsp-nvim.enable = lib.mkDefault true;
    trouble.enable = lib.mkDefault true;
  };
}

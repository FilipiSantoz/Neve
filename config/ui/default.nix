{
  lib,
  config,
  ...
}:
{
  imports = [
    ./alpha.nix
    ./barbecue.nix
    ./dressing-nvim.nix
    ./indent-blankline.nix
    ./noice.nix
    ./notify.nix
    ./nui.nix
    ./web-devicons.nix
    ./winbar.nix
  ];

  options = {
    ui.enable = lib.mkEnableOption "Enable ui module";
  };
  config = lib.mkIf config.ui.enable {
    alpha.enable = lib.mkDefault false;
    barbecue.enable = lib.mkDefault false;
    dressing-nvim.enable = lib.mkDefault false;
    indent-blankline.enable = lib.mkDefault false;
    noice.enable = lib.mkDefault false;
    notify.enable = lib.mkDefault false;
    nui.enable = lib.mkDefault true;
    web-devicons.enable = lib.mkDefault true;
    winbar.enable = lib.mkDefault true;
  };
}

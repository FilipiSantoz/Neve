{
  lib,
  config,
  ...
}:
{
  imports = [
    ./better-escape.nix
    ./cloak.nix
    ./colorizer.nix
    ./harpoon.nix
    ./markdown-preview.nix
    ./peek.nix
    ./mini.nix
    ./neocord.nix
    ./neotest.nix
    ./nvim-autopairs.nix
    ./nvim-surround.nix
    ./nvterm.nix
    ./oil.nix
    ./persistence.nix
    ./plenary.nix
    ./project-nvim.nix
    ./snacks.nix
    ./tmux-navigator.nix
    ./todo-comments.nix
    ./undotree.nix
    ./wakatime.nix
    ./which-key.nix
    ./wilder.nix
  ];

  options = {
    utils.enable = lib.mkEnableOption "Enable utils module";
  };
  config = lib.mkIf config.utils.enable {
    better-escape.enable = lib.mkDefault false;
    cloak.enable = lib.mkDefault false;
    harpoon.enable = lib.mkDefault false;
    markdown-preview.enable = lib.mkDefault true;
    peek.enable = lib.mkDefault false;
    mini.enable = lib.mkDefault true;
    neocord.enable = lib.mkDefault false;
    neotest.enable = lib.mkDefault true;
    nvim-autopairs.enable = lib.mkDefault true;
    colorizer.enable = lib.mkDefault true;
    nvim-surround.enable = lib.mkDefault true;
    nvterm.enable = lib.mkDefault false;
    oil.enable = lib.mkDefault true;
    persistence.enable = lib.mkDefault true;
    plenary.enable = lib.mkDefault true;
    project-nvim.enable = lib.mkDefault true;
    snacks.enable = lib.mkDefault true;
    tmux-navigator.enable = lib.mkDefault true;
    todo-comments.enable = lib.mkDefault false;
    undotree.enable = lib.mkDefault true;
    wakatime.enable = lib.mkDefault false;
    which-key.enable = lib.mkDefault true;
    wilder.enable = lib.mkDefault false;
  };
}

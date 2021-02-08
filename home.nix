
{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tek";
  home.homeDirectory = "/home/tek";
  home.packages = with pkgs; [

    # Shell/Terminal Customization
    starship
    autojump
    zsh-completions
    zsh-command-time
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    nix-zsh-completions

    # Fonts
    fontconfig
    font-awesome_4
    (nerdfonts.override { fonts = [ "JetBrainsMono" "DejaVuSansMono" ]; })
    twemoji-color-font
    noto-fonts-emoji-blob-bin
    emojione

    # Language Servers
    gcc
    rnix-lsp
    clang-tools
    rust-analyzer
    nodePackages.pyright
    haskellPackages.haskell-language-server
   # unstable.sumneko-lua-language-server
    nodePackages.vscode-json-languageserver-bin
    nodePackages.yaml-language-server
    nodePackages.bash-language-server
    nodePackages.vue-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    # Linters  
    rustfmt
    ormolu
    python38Packages.pylint
    yamllint
    lua51Packages.luacheck
    lua51Packages.lua


  ];
  programs.neovim = {
      enable = true;
      withPython3 = true;
      package = pkgs.neovim-nightly-overlay.neovim-nightly;
      extraPython3Packages = (ps: with ps; [
        pynvim
        unidecode
        black
        isort
	]);

    };
  programs.git = {
      enable = true;
      userName = "ShifterBit";
      userEmail = "48891590+ShifterBit@users.noreply.github.com";
  };

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}

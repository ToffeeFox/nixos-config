{
  flux.zsh = {
    nixos.programs.zsh.enable = true;

    homeManager =
    { ... }:
    {
      programs.zsh = {
        enable = true;

        # Core Settings
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        # Zsh-Specific Aliases
        shellAliases = {
        };

        # Zsh Functions to be injected into zshrc
        initContent = ''
          mkcd() {
            mkdir -p "$@" && cd"$@"
          }
          '';

        # lil tweaks
        autocd = true;
        defaultKeymap = "emacs";

        # History Settings
        history = {
          # General history to keep on hand
          size = 10000;
          # History to actually save to histfile
          save = 50000;
        };

        # Oh-My-Zsh Config
        oh-my-zsh = {
          enable = true;

          plugins = [
            "git"
            "sudo"
          ];

          theme = "agnoster";
        };
      };
    };
  };
}

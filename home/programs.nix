{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
    };

    obs-studio = {
      enable = true;

      # optional Nvidia hardware acceleration
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };

      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        input-overlay
      ];
    };
  };
}

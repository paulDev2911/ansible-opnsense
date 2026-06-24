{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ansible
    python3Packages.httpx
    python3Packages.pip
    claude-code
  ];
}

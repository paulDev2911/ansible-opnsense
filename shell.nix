{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ansible
    python3Packages.httpx
    python3Packages.pip
  ];
}

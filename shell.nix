{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    nixfmt
    rnix-lsp
  ];
}

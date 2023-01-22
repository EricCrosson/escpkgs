{
  description = "charmbracelet/vhs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Why this flake?
  # Nixpkgs is on v0.1.1 and I want to use v0.2.0

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        vhs = pkgs.buildGoModule {
          pname = "vhs";
          version = "0.2.0";

          src = pkgs.fetchFromGitHub {
            owner = "charmbracelet";
            repo = "vhs";
            rev = "v0.2.0";
            hash = "sha256-t6n4uID7KTu/BqsmndJOft0ifxZNfv9lfqlzFX0ApKw=";
          };

          vendorHash = "sha256-9nkRr5Jh1nbI+XXbPj9KB0ZbLybv5JUVovpB311fO38=";
        };
      in {
        packages.default = vhs;
      }
    );
}

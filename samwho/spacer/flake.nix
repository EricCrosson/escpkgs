{
  description = "ast-grep";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    forEachSystem = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  in {
    packages = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      spacer = pkgs.rustPlatform.buildRustPackage {
        name = "spacer";
        src = pkgs.fetchFromGitHub {
          owner = "samwho";
          repo = "spacer";
          rev = "c5fcae3773da8993e470ad0807649cdab4b186d6";
          sha256 = "sha256-F2PrBlS9uL6BQtjNNabCpl3ofavsUGlBy/Hotm42Oec=";
        };
        cargoSha256 = "sha256-4JCYGSJPZK1geD9Yj0veWseNBbVw2SxbAV8GUGVpn6A=";
        meta = {
          description = "CLI tool to insert spacers when command output stops";
          homepage = "https://github.com/samwho/spacer";
        };
      };
    in {
      default = spacer;
    });
  };
}

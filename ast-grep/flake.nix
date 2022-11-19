{
  description = "ast-grep";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ast-grep = pkgs.rustPlatform.buildRustPackage {
          name = "ast-grep";
          src = pkgs.fetchFromGitHub {
            owner = "ast-grep";
            repo = "ast-grep";
            rev = "283e78abb8d30309a52ba6b08aac455213b4159a";
            sha256 = "sha256-SWeZSfUo8gYXSON5kcs4hw2GTEYFrtB+Vn7HlraZE3Q=";
          };
          cargoSha256 = "sha256-uGTotfVb+cFy8e/xTz/RpvqS22l+w+zEP91XipXd1uo=";
          runVend = true;
          meta = {
            description = "A fast and easy tool for code searching, linting, rewriting at large scale.";
            homepage = "https://github.com/ast-grep/ast-grep";
          };
        };
      in {
        packages.default = ast-grep;
      }
    );
}

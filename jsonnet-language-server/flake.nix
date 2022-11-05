{
  description = "Jsonnet Language Server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        jsonnet-language-server = pkgs.buildGoModule {
          name = "jsonnet-language-server";
          src = pkgs.fetchFromGitHub {
            owner = "grafana";
            repo = "jsonnet-language-server";
            rev = "e6112122ab389ec06f361ee9927466dac5806db3";
            sha256 = "lOdcu/xlSpodlEJkEXWaq5NUl5hJxCYqPQt6vNeiImk=";
          };
          vendorSha256 = "ZyTo79M5nqtqrtTOGanzgHcnSvqCKACacNBWzhYG5nY=";
          runVend = true;
          meta = {
            description = "A Language Server Protocol (LSP) server for Jsonnet";
            homepage = "https://github.com/grafana/jsonnet-language-server";
          };
        };
      in {
        packages.default = jsonnet-language-server;
      }
    );
}

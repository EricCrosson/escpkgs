# Why this flake? Ouch exists in nixpkgs.
#
# The nixpkgs version is out of date and contains issues in shell completion
# (since fixed upstream).

{
  description = "Obvious Unified Compression Helper";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ouch = pkgs.rustPlatform.buildRustPackage {
          name = "ouch";
          src = pkgs.fetchFromGitHub {
            owner = "ouch-org";
            repo = "ouch";
            # 1 month after 0.4.0
            rev = "6da32c497fc069c8878b6b80a446b28f27d4634a";
            hash = "sha256-br4IZtQP3A8VAQjyba2ZZTUh19ZREQLdzF9rSp/N6SI=";
          };
          cargoSha256 = "sha256-ywGRes7nZW7S0CgN0T1xatuIpgKWolAwt/hkX2+MOI0=";
          runVend = true;
          meta = {
            description = "Painless compression and decompression for your terminal";
            homepage = "https://github.com/ouch-org/ouch";
          };

          nativeBuildInputs = with pkgs; [ help2man installShellFiles ];

          OUCH_ARTIFACTS_FOLDER = "target/${pkgs.rust.toRustTargetSpec pkgs.stdenv.hostPlatform}/release/build/artifacts";

          postInstall = ''
            help2man $out/bin/ouch > ouch.1
            installManPage ouch.1
            completions=($releaseDir/build/artifacts)
            installShellCompletion $completions/ouch.{bash,fish} --zsh $completions/_ouch
          '';
        };
      in {
        packages.default = ouch;
      }
    );
}

{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem ( system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
            in
            rec {
                packages.default = pkgs.buildNpmPackage {
                    name = "jq-tutorial";
                    version = "1.0.0";

                    buildInputs = with pkgs; [ nodejs_22 ];

                    src = ./.;

                    npmDepsHash = "sha256-StaPWlsqw4gnalHsQjqn6GQVGBxbkPRLQAu2MgFmyzc=";

                    dontNpmBuild = true;
                };

                devShells.default = pkgs.mkShell {
                    buildInputs = with pkgs; [ jq nodejs_22 fzf jiq ];
                    shellHook = ''
                        npm set prefix ~/.npm-global
                        npm install -g jq-tutorial
                    '';
                };
            }

    );
}

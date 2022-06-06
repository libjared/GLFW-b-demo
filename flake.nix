# taken from github:srid/haskell-template
{
  description = "GLFW-b demo";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/haskell-updates";
  };
  outputs = { self, nixpkgs, flake-utils }:
  (
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      project = returnShellEnv: (
        pkgs.haskellPackages.developPackage {
          inherit returnShellEnv;
          name = "glfw-b-demo";
          root = ./.;
          modifier = drv: pkgs.haskell.lib.doJailbreak drv;
        }
      );
      in {
        defaultPackage = project false;
        devShell = project true;
      }
    )
  );
}

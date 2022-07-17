# taken from github:srid/haskell-template
{
  description = "GLFW-b demo";

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
        packages.default = project false;
        devShells.default = project true;
      }
    )
  );
}

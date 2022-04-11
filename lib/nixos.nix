{ inputs, lib, pkgs, ... }:

let
  inherit (lib.my) mapModules;
  inherit (lib) nixosSystem removeSuffix filterAttrs mkDefault;
  inherit (builtins) elem;
in rec {
  mkHost = { hostPath, system, extraModules }: nixosSystem {
    inherit system;
    specialArgs = { inherit lib inputs pkgs; };
    modules = extraModules ++ [
      {
        nixpkgs.pkgs = pkgs;
        networking.hostName = mkDefault (baseNameOf (removeSuffix "/default.nix" hostPath));
      }
      (import hostPath)
    ];
  };

  mapHosts = { directory, system, extraModules }:
    mapModules directory
      (hostPath: mkHost { inherit hostPath system extraModules; });
}

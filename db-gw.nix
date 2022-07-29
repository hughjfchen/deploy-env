{ config, lib, pkgs, ... }:
let envSubM = import ./env.nix { inherit config lib pkgs; };
in {
  imports = [ ];

  options = {
    db-gw = lib.mkOption {
      type = lib.types.submodule envSubM;
      description = ''
        The deploy target host env.
      '';
    };
  };
}
{ modules ? [ ], pkgs, ... }:

let _pkgs = pkgs;
in let
  pkgs = if builtins.typeOf _pkgs == "path" then
    import _pkgs
  else if builtins.typeOf _pkgs == "set" then
    _pkgs
  else
    builtins.abort
    "The pkgs argument must be an attribute set or a path to an attribute set.";

  lib = pkgs.lib;

  optionModule = lib.attrsets.mapAttrsToList (subModuleName: _: import ./option-spec.nix { inherit subModuleName; }) modules;

  configModule = lib.attrsets.attrValues modules;

  envBuilder = lib.evalModules { modules = builtinModules ++ optionModule ++ configModule; };

  builtinModules = [ argsModule ] ++ import ./module-list.nix;

  argsModule = {
    _file = ./env-builder.nix;
    key = ./env-builder.nix;
    config._module.check = true;
    config._module.args.pkgs = lib.mkIf (pkgs != null) (lib.mkForce pkgs);
  };

in { env = lib.attrByPath [ "config" ] { } envBuilder; } // {
  # throw in lib and pkgs for repl convenience
  inherit lib;
  inherit (envBuilder._module.args) pkgs;
}

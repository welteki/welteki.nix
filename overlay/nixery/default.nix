{ inputs, pkgs, ... }:

let
  lock = builtins.fromJSON (builtins.readFile ../../flake.lock);
in
(import "${inputs.nixery}/default.nix" {
  inherit pkgs;
  commitHash = _: lock.nodes.nixery.locked.rev;
}).nixery-bin


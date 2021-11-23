{ inputs, pkgs, ... }:

(import "${inputs.nixery}/default.nix" {
  inherit pkgs;
  commitHash = _: pkgs.flakeLock.nodes.nixery.locked.rev;
}).nixery-bin


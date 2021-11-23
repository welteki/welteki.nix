{ system ? builtins.currentSystem or "unknown-system" }:

let
  flakeOutputs = import ../.;
in
(if flakeOutputs ? nixeryPackages.${system} then flakeOutputs.nixeryPackages.${system} else { })

inputs:

final: prev:
{
  inherit inputs;

  flakeLock = builtins.fromJSON (builtins.readFile ../flake.lock);

  caddy = import ./caddy final;
  nixery = import ./nixery final;
}

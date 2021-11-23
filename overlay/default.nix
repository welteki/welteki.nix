inputs:

final: prev:
{
  inherit inputs;

  caddy = import ./caddy final;
  nixery = import ./nixery final;
}

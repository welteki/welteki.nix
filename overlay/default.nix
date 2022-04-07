inputs:

final: prev:
{
  inherit inputs;

  caddy = import ./caddy final;
}

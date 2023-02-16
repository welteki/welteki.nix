inputs:

final: prev:
{
  inherit inputs;

  caddy = import ./caddy final;
  nsc = import ./nsc final;
  supabase = import ./supabase final;
}

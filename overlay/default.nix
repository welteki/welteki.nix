inputs:

final: prev:
{
  inherit inputs;

  actuated-cli = import ./actuated-cli final;
  caddy = import ./caddy final;
  nsc = import ./nsc final;
  supabase = import ./supabase final;
}

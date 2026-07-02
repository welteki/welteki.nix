inputs:
{ stdenv
, ...
}:

(inputs.hunk.packages.${stdenv.hostPlatform.system}.hunk).overrideAttrs (old: {
  meta = old.meta // {
    mainProgram = "hunk";
  };
})

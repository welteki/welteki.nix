{ buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "supabase";
  version = "1.38.4";

  src = fetchFromGitHub {
    owner = "supabase";
    repo = "cli";
    rev = "v${version}";
    sha256 = "sha256-rDFlogIEjGew02nY35aU+BU4hYIrePhui2wWr8OSmKk=";
  };

  vendorSha256 = "sha256-f1lsGQDsxXi8XGTqry6ycVxu249xAgKi1AbxNQyloL0=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/supabase/cli/internal/utils.Version=${version}"
  ];

  CGO_ENABLED = 0;

  subPackages = [ "." ];

  postInstall = ''
    mv $out/bin/cli $out/bin/supabase
  '';
}

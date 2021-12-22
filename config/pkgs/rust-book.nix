{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "rust-book";

  src = builtins.fetchGit { 
    url = "https://github.com/rust-lang/book";
    ref = "HEAD";
  };

  buildInputs = [ pkgs.mdbook ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/rust
    mdbook build $src -d $out/rust
  '';
}

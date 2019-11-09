with import <nixpkgs> { };

let jekyll_env = bundlerEnv rec {
    name = "jekyll_env";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
stdenv.mkDerivation rec {
  name = "jekyll_env";
  buildInputs = [ jekyll_env bundler ruby ];

  shellHook = ''
    export LANG=C.UTF-8
    exec ${jekyll_env}/bin/jekyll serve --watch --host 0.0.0.0 --port 4000
  '';
}


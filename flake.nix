{
  description = "Spanish study aid generation environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      # Exactly the faces the documents use, and nothing else.
      #
      # Fraunces ships one family per optical size ("Fraunces 9pt", "72pt",
      # "144pt", each also Soft and SuperSoft); only the 72pt Bold is used.
      fonts = pkgs.runCommand "espanol-fonts" { } ''
        mkdir -p $out
        cp ${pkgs.fraunces}/share/fonts/opentype/Fraunces72pt-Bold.otf $out/
        for w in Regular Italic Bold BoldItalic; do
          cp ${pkgs.atkinson-hyperlegible-next}/share/fonts/opentype/AtkinsonHyperlegibleNext-$w.otf $out/
        done
      '';

      # Fish completion calls `task __complete`, which first ships in 3.54.0.
      go-task = pkgs.go-task.overrideAttrs (old: rec {
        version = "3.54.0";
        src = pkgs.fetchFromGitHub {
          owner = "go-task";
          repo = "task";
          tag = "v${version}";
          hash = "sha256-AmfrF+FJ2dLmyT8h/l5zCUveFoOTKW/ZItG7MEwJp9Q=";
        };
        vendorHash = "sha256-5QJ8W2a+fZG5HJMnHkg+j/OFM8wkiVEd7FjUwydQ+F4=";
      });

    in
    {

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.typst
          pkgs.typstyle
          go-task
        ];

        TYPST_FONT_PATHS = "${fonts}";
      };

      packages.${system}.fonts = fonts;
    };
}

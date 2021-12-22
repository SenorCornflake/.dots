{ pkgs, ... }:

{
  xdg.dataFile."php" = {
    target = "wikis/php";
    source = "${pkgs.php-docs}/php";
    recursive = false; 
  };

  xdg.dataFile."rust" = {
    target = "wikis/rust";
    source = "${pkgs.rust-book}/rust";
    recursive = false; 
  };
}

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Baker";
    userEmail = "cmdwannabe@gmail.com";
  };
}

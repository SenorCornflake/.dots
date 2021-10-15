
{ config, pkgs, ... }: 

{
  fonts.fonts = with pkgs; [
    terminus_font
    terminus_font_ttf
    termsyn
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "VictorMono"
      ];
    })
    scheherazade-new
    scheherazade
  ];
}

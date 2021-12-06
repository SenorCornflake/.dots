{ config, pkgs, ... }:

{
  /* home.packages = with pkgs; [
    autorandr
  ];

  xdg.configFile."autorandr" = {
    target = "autorandr";
    source = ../files/autorandr;
    recursive = true;
  }; */

  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        restart-wm = ''
          herbstclient reload
        '';
      };
    };
    profiles = {
      docked-open = {
        fingerprint = {
          VGA-1 = "00ffffffffffff001e6d335732c701000813010308331c78eac9a5a4564b9d25125054a56b80818f7140b300814f01010101010101011a3680a070381f4030203500fd1e1100001a000000fd00384b1e5311000a202020202020000000fc004d32333934410a202020202020000000fc000a202020202020202020202020005e";
          eDP-1 = "00ffffffffffff0030e4fc030000000000170104951f11780aa3e59659558e271f505400000001010101010101010101010101010101482640a460841a303020250035ae10000019000000000000000000000000000000000000000000fe004c4720446973706c61790a2020000000fe004c503134305744322d54504231002a";
        };
        config = {
          VGA-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            crtc = 0;
            rate = "59.93";
          };
          eDP-1 = {
            enable = true;
            primary = false;
            position = "1920x0";
            mode = "1600x900";
            crtc = 0;
            rate = "60.0";
          };
        };
      };
      docked-closed = {
        fingerprint = {
          VGA-1 = "00ffffffffffff001e6d335732c701000813010308331c78eac9a5a4564b9d25125054a56b80818f7140b300814f01010101010101011a3680a070381f4030203500fd1e1100001a000000fd00384b1e5311000a202020202020000000fc004d32333934410a202020202020000000fc000a202020202020202020202020005e";
        };
        config = {
          VGA-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            crtc = 0;
            rate = "59.93";
          };
          eDP-1 = {
            enable = false;
          };
        };
      };
      undocked = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0030e4fc030000000000170104951f11780aa3e59659558e271f505400000001010101010101010101010101010101482640a460841a303020250035ae10000019000000000000000000000000000000000000000000fe004c4720446973706c61790a2020000000fe004c503134305744322d54504231002a";
        };
        config = {
          VGA-1 = {
            enable = false;
          };
          eDP-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1600x900";
            crtc = 0;
            rate = "60.0";
          };
        };
      };
    };
  };
}

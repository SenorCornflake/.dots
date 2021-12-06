{ config, pkgs, ... }:

{
  programs.lf = {
    enable = true;
    settings = {
      ratios = "1:2:3";
      hidden = true;
      preview = true;
      drawbox = true;
      icons = false;
      ignorecase = true;
    };
    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!${pkgs.bash}/bin/bash
      case "$1" in
          *.tar*) tar tf "$1";;
          *.zip) unzip -l "$1";;
          *.rar) unrar l "$1";;
          *.7z) 7z l "$1";;
          *.pdf) pdftotext "$1" -;;
          *) bat --color always --style=numbers --theme=base16 "$1" ;;
      esac
    '';
    commands = {
      q = "quit";
      open = ''
        ''${{
            case $(file --mime-type "$f" -bL) in
                text/*|application/json) $EDITOR "$f";;
                *) xdg-open "$f" ;;
            esac
        }}
      '';
      chmod = ''
        ''${{
          printf "Mode Bits: "
          read ans

          for file in "$fx"
          do
            chmod $ans $file
          done

          lf -remote 'send reload'
        }}
      '';
      sudomkfile = ''
        ''${{
          printf "File Name: "
          read ans
          sudo $EDITOR $ans
        }}
      '';
      sudomkdir = ''
        ''${{
          printf "File Name: "
          read ans
          sudo mkdir $ans
        }}
      '';
      dragon = "%dragon-drag-and-drop -a -x \"$fx\"";
      dragon-stay = "%dragon-drag-and-drop -a \"$fx\"";
      dragon-individual = "%dragon-drag-and-drop \"$fx\"";

      unarchive = ''
        ''${{
          case "$f" in
              *.zip) unzip "$f" ;;
              *.tar.gz) tar -xzvf "$f" ;;
              *.tar.bz2) tar -xjvf "$f" ;;
              *.tar) tar -xvf "$f" ;;
              *) echo "Unsupported format" ;;
          esac
        }}
      '';

      zip = "%zip -r \"$f\" \"$f\"";
      tar = "%tar cvf \"$f.tar\" \"$f\"";
      targz = "%tar cvzf \"$f.tar.gz\" \"$f\"";
      tarbz2 = "%tar cjvf \"$f.tar.bz2\" \"$f\"";

      trash = ''
        ''${{
          files=$(printf "$fx" | tr '\n' ';')
          while [ "$files" ]; do
            # extract the substring from start of string up to delimiter.
            # this is the first "element" of the string.
            file=''${files%%;*}

            trash-put "$(basename "$file")"
            # if there's only one element left, set `files` to an empty string.
            # this causes us to exit this `while` loop.
            # else, we delete the first "element" of the string from files, and move onto the next.
            if [ "$files" = "$file" ]; then
              files='''
            else
              files="''${files#*;}"
            fi
          done
        }}
      '';

      clear_trash = "%trash-empty";

      restore_trash = "\${{trash-restore}}";

      stripspace = "%stripspace \"$f\"";

      # $ was %
      link = ''
        ''${{
            set -- $(cat ~/.local/share/lf/files)
            mode="$1"
            shift
            if [ "$#" -lt 1 ]; then
                lf -remote "send $id echo no files to link"
                exit 0
            fi
            case "$mode" in
                # symbolically copy mode is indicating a soft link
                copy) ln -sr -t . -- "$@";;
                # while a move mode is indicating a hard link
                move) ln -t . -- "$@";;
            esac
            rm ~/.local/share/lf/files
            lf -remote "send clear"
        }}
      '';

      fzf_jump = ''
        ''${{
            res="$(find . -maxdepth 1 | fzf --header='Jump to location' | sed 's/\\/\\\\/g;s/"/\\"/g')"
            if [ -d "$res" ]; then
                cmd="cd"
            else 
                cmd="select"
            fi
            lf -remote "send $id $cmd \"$res\""
        }}
      '';

      fzf_jump_nodepth = ''
        ''${{
            res="$(find . | fzf --header='Jump to location' | sed 's/\\/\\\\/g;s/"/\\"/g')"
            if [ -d "$res" ]; then
                cmd="cd"
            else 
                cmd="select"
            fi
            lf -remote "send $id $cmd \"$res\""
        }}
      '';
    };
    keybindings = {
      "`h" = "cd ~";
      "`w" = "cd /srv/http";
      "`W" = "cd ~/wallpapers";
      "`d" = "cd ~/Downloads";
      "`S" = "cd ~/Desktop";
      "`c" = "cd ~/.config";
      "`m" = "cd ~/MAIN";
      "<a-q>" = "quit";

      # Remove some defaults
      #"m" = "";
      #"o" = "";
      #"n" = "";
      #"'" = "";
      #"\"" = "";
      #"e" = "";

      ee = "$$EDITOR \"$f\"";

      # Archive Mappings
      az = "zip";
      at = "tar";
      ag = "targz";
      ab = "targz";
      au = "unarchive";

      # "Trash Mappings
      x = "trash";
      tc = "clear_trash";
      tr = "restore_trash";

      # "Dragon Mapping";
      Dr = "dragon";
      Ds = "dragon-stay";
      Di = "dragon-individual";

      ss = "stripspace";

      # Basic Functions";"
      "." = "set hidden!";
      X = "delete";
      p = "paste";
      d = "cut";
      y = "copy";
      "<enter>" = "open";
      A = "push %mkdir<space>";
      a = "push %touch<space>";
      "<c-A>" = "sudomkdir";
      "<c-a>" = "sudomkfile";
      ch = "chmod";
      r = "rename";
      R = "$vimv $fx";
      H = "top";
      L = "bottom";
      c = "clear";
      u = "unselect";
      P = ":link";
      F = ":fzf_jump";
      "<c-f>" = ":fzf_jump_nodepth";
    };
  };
}

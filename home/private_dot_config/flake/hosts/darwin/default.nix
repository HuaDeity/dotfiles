{
  pkgs,
  lib,
  ...
}:

with lib;

{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  environment = {
    profiles = (mkOrder 799 [ "$HOME/.local/state/nix/profile" ]);
    systemPackages = import ../../modules/shared/system-packages.nix { inherit pkgs; };
  };

  programs = {
    zsh = {
      enableBashCompletion = false;
      enableCompletion = false;
      interactiveShellInit = ''
        # Disable the log builtin, so we don't conflict with /usr/bin/log
        disable log

        # Useful support for interacting with Terminal.app or other terminal programs
        [ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"
      '';
      loginShellInit = ''
        if [ -x /usr/libexec/path_helper ]; then
          eval `/usr/libexec/path_helper -s`
        fi
      '';
      promptInit = "";
    };
  };

  nix = {
    channel.enable = false;
    gc = {
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "@admin"
      ];
    };
  };

  security = {
    pam = {
      services = {
        sudo_local = {
          enable = true;
          reattach = true;
          touchIdAuth = true;
        };
      };
    };
  };

  system = {
    checks = {
      verifyNixPath = false;
    };

    defaults = {
      dock = {
        autohide = true;
        show-recents = true;
        launchanim = true;
        orientation = "bottom";
        tilesize = 64;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = false;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 6; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 35; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 1.0;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    primaryUser = "huadeity";

    stateVersion = 6;
  };
}

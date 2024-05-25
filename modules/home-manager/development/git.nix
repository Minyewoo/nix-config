{lib, config, ...}:
with lib;
let
  cfg = config.gitUser;
in
{
  options.gitUser = {
    name = mkOption {
      type = types.str;
      description = ''
        Name of your git user
      '';
    };
    email = mkOption {
      type = types.str;
      description = ''
        Email of your git user
      '';
    };
  };

  config = {
    programs.git = {
      enable = true;
      userName  = cfg.name;
      userEmail = cfg.email;
    };
  };
}

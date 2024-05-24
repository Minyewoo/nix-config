{lib, config, ...}:
{
  options = {
    gitUserName = lib.mkOption {
      type = lib.types.str;
      description = ''
        Name of your git user
      '';
    };
    gitUserEmail = lib.mkOption {
      type = lib.types.str;
      description = ''
        Email of your git user
      '';
    };
  };
  config = {
    programs.git = {
      enable = true;
      userName  = config.gitUserName;
      userEmail = config.gitUserEmail;
    };
  };
}

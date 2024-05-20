{lib, ...}:
{
  options = {
    gitUserName = lib.mkOption {
      # default = "Minyewoo";
      type = lib.types.string;
      description = ''
        Name of your git user
      '';
    };
    gitUserEmail = lib.mkOption {
      # default = "Minyewoo";
      type = lib.types.string;
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
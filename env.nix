{ config, lib, pkgs, ... }:

{
  imports = [ ];

  options = {
    hostName = lib.mkOption {
      type = lib.types.nonEmptyStr;
      example = "myhost";
      description = ''
        The host name of the deploy target host.
      '';
    };
    dnsName = lib.mkOption {
      # type = lib.types.strMatching "^([a-z0-9]+(-[a-z0-9]+)*.)+[a-z]{2,}$";
      type = lib.types.nonEmptyStr;
      example = "myhost.subdomain.com";
      description = ''
        The DNS name of the deploy target host.
      '';
    };
    ipAddress = lib.mkOption {
      type = lib.types.strMatching
        "^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5])).){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$";
      default = "127.0.0.1";
      example = "10.1.23.222";
      description = ''
        The IP address of the deploy target host.
      '';
    };
    processUser = lib.mkOption {
      type = lib.types.nonEmptyStr;
      example = "myuser";
      description = ''
        The user name under which the service or program will run on the target host.
      '';
    };
    isSystemdService = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = ''
        If the service should be a systemd service on the target host?
      '';
    };
    runDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/${config.processUser}/run";
      example = "/var/myuser/run";
      description = ''
        The directory the runtime intermedia files should be put under on the target host.
      '';
    };
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/${config.processUser}/data";
      example = "/var/myuser/data";
      description = ''
        The directory the data files should be put under on the target host.
      '';
    };
  };
}

# original file from: https://cs.tvl.fyi/depot

# The MIT License (MIT)

# Copyright (c) 2019 Vincent Ambo
# Copyright (c) 2020-2021 The TVL Authors

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# NixOS module to run Nixery, currently with local-storage as the
# backend for storing/serving image layers.
self:

{ config, lib, pkgs, ... }:

let
  cfg = config.services.nixery;

  description = "Nixery - container images on-demand";
  storagePath = "/var/lib/nixery/${pkgs.flakeLock.nodes.nixpkgs.locked.rev}";
in
{
  options.services.nixery = {
    enable = lib.mkEnableOption description;

    port = lib.mkOption {
      type = lib.types.int;
      default = 45243; # "image"
      description = "Port on which Nixery should listen";
    };

    storagePath = lib.mkOption {
      type = lib.types.string;
      default = storagePath;
      description = "Path to a folder in which to store build cache and image layers";
    };


  };

  config = lib.mkIf cfg.enable {
    systemd.services.nixery = {
      inherit description;
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        DynamicUser = true;
        StateDirectory = "nixery";
        Restart = "always";
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${cfg.storagePath}";
        ExecStart = "${pkgs.nixery}/bin/nixery";
      };

      environment = {
        PORT = toString cfg.port;
        NIXERY_PKGS_PATH = "${self}/.nixery";
        NIXERY_STORAGE_BACKEND = "filesystem";
        NIX_TIMEOUT = "60"; # seconds
        STORAGE_PATH = cfg.storagePath;
      };
    };
  };
}

# wee-slack-overlay.nix
self: super: {
  wee-slack = super.wee-slack.overrideAttrs (oldAttrs: {
    version = "2.10.2";  # Change this if needed
    src = super.fetchFromGitHub {
      repo = "wee-slack";
      owner = "wee-slack";
      rev = "f4fcf380e7baff9b84d32ac5c55fd8effd393119";  # Change this to the desired revision
      sha256 = "";  # Update with the correct sha256 hash
    };
  });
}

# vim:set et sw=2 ts=2:

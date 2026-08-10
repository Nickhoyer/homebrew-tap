# Homebrew cask for Spotlight-rs.
#
# Release checklist:
#   1. scripts/bundle.sh                      # builds dist/Spotlight-rs.zip
#   2. Upload dist/Spotlight-rs.zip to a GitHub release tagged vX.Y.Z
#   3. Fill in `version` and `sha256` (the shasum printed by bundle.sh) below
#   4. Publish via your own tap:  brew install --cask <user>/tap/spotlight-rs
#
# Releases from v0.10.0 on are Developer ID signed and notarized, with the
# notarization ticket stapled into the bundle, so Gatekeeper clears them on
# first launch with no right-click → Open and no quarantine workaround.
cask "spotlight-rs" do
  version "0.13.0"
  sha256 "51fc8303bdf5d6a249dba09e76dc3c9f37397a9374727c50678092f67de79d07"

  url "https://github.com/Nickhoyer/spotlight-rs/releases/download/v#{version}/Spotlight-rs.zip"
  name "Spotlight-rs"
  desc "Background menu-bar launcher (GPUI)"
  homepage "https://github.com/Nickhoyer/spotlight-rs"

  depends_on macos: :ventura # 13.0+, for SMAppService (Launch at Login)

  app "Spotlight-rs.app"

  # Restart the app across an upgrade. `brew upgrade` uninstalls the old cask
  # before installing the new one, so `uninstall quit:` is what stops the
  # running instance before its bundle is replaced — without it the old process
  # survives, running from the deleted bundle, until it is manually restarted.
  # postflight then brings the new version straight back up.
  #
  # This also launches the app after a plain `brew install`, which is the useful
  # behaviour for a menu-bar agent with no Dock icon to click.
  postflight do
    system_command "/usr/bin/open",
                   args: ["-a", "#{appdir}/Spotlight-rs.app"],
                   sudo: false
  end

  uninstall quit: "com.nickolashoyer.spotlight-rs"

  zap trash: "~/Library/Application Support/spotlight-rs"
end

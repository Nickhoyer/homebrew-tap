# Homebrew cask for Spotlight-rs.
#
# Release checklist:
#   1. scripts/bundle.sh                      # builds dist/Spotlight-rs.zip
#   2. Upload dist/Spotlight-rs.zip to a GitHub release tagged vX.Y.Z
#   3. Fill in `version` and `sha256` (the shasum printed by bundle.sh) below
#   4. Publish via your own tap:  brew install --cask <user>/tap/spotlight-rs
#
# NOTE: the app is ad-hoc signed, not notarized. On first launch macOS Gatekeeper
# will block it; users right-click → Open once, or run:
#   xattr -dr com.apple.quarantine "/Applications/Spotlight-rs.app"
# The `quarantine` stanza below asks Homebrew to strip the attribute on install.
cask "spotlight-rs" do
  version "0.7.1"
  sha256 "8ea5d8002bf5946b2a1b3f8bf7466b5097f00ecb534135c7a1e435978a60f65b"

  url "https://github.com/Nickhoyer/spotlight-rs/releases/download/v#{version}/Spotlight-rs.zip"
  name "Spotlight-rs"
  desc "Background menu-bar launcher (GPUI)"
  homepage "https://github.com/Nickhoyer/spotlight-rs"

  depends_on macos: :ventura # 13.0+, for SMAppService (Launch at Login)

  app "Spotlight-rs.app"

  # Unsigned/un-notarized: clear quarantine so it launches without a right-click.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Spotlight-rs.app"],
                   sudo: false
  end

  zap trash: "~/Library/Application Support/spotlight-rs"
end

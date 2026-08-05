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
  version "0.10.0"
  sha256 "0be0a9d12efa2964529a290675cab83a6ed7a72ecd5bed507c170c219d85a8ff"

  url "https://github.com/Nickhoyer/spotlight-rs/releases/download/v#{version}/Spotlight-rs.zip"
  name "Spotlight-rs"
  desc "Background menu-bar launcher (GPUI)"
  homepage "https://github.com/Nickhoyer/spotlight-rs"

  depends_on macos: :ventura # 13.0+, for SMAppService (Launch at Login)

  app "Spotlight-rs.app"

  zap trash: "~/Library/Application Support/spotlight-rs"
end

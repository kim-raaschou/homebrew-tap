cask "aerocontrol" do
  version "0.1.0-Beta"
  sha256 "0bee7a44479d45f1a3d0a6f863b9c8f77c82318915c1aec2159f10d7d287f967"

  url "https://github.com/kim-raaschou/AeroControl/releases/download/v#{version}/AeroControl-v#{version}.zip"
  name "AeroControl"
  desc "Floating workspace overview for the AeroSpace tiling window manager"
  homepage "https://github.com/kim-raaschou/AeroControl"

  # AeroControl requires macOS 26 (Tahoe) — it uses SwiftUI Liquid Glass.
  depends_on macos: ">= :tahoe"

  app "AeroControl-v#{version}/AeroControl.app"

  # The app is ad-hoc signed (no Apple Developer notarization, mirroring
  # AeroSpace), so strip the Gatekeeper quarantine on install.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AeroControl.app"]
  end

  caveats <<~EOS
    AeroControl is a companion for AeroSpace and needs AeroSpace >= 0.21.1-Beta:
      brew install --cask nikitabobko/tap/aerospace

    Launch AeroControl.app once from Finder (Gatekeeper), then wire it into
    ~/.aerospace.toml. No Accessibility or other permissions are required.
    See the README for details.
  EOS

  zap trash: [
    "~/Library/Preferences/com.aerocontrol.AeroControl.plist",
  ]
end

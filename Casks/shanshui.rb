# typed: strict
# frozen_string_literal: true

# Made by `make cask` from Resources/shanshui.rb.in in kim-raaschou/shanshui-macos.
cask "shanshui" do
  version "0.3.0"
  sha256 "27436846a5c925d344206a5aa8fe8422f645a72c163a8ecda004533d1f4df420"

  url "https://github.com/kim-raaschou/shanshui-macos/releases/download/v#{version}/ShanShui-#{version}.zip"
  name "Shan Shui"
  desc "Endless Chinese landscape scroll as a desktop background and screen saver"
  homepage "https://github.com/kim-raaschou/shanshui-macos"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Shan Shui.app"
  screen_saver "Shan Shui.saver"

  # Signed ad hoc and not notarized, so the Gatekeeper quarantine is removed before the app
  # and the screen saver are put in place.
  preflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}"], must_succeed: false
  end

  # The old build must not keep running from a replaced bundle.
  uninstall quit: "shanshui-macos"

  zap trash: [
    "~/.cache/shanshui",
    "~/.config/shanshui",
    "~/.local/state/shanshui",
  ]

  caveats <<~EOS
    Start it; it lives in the menu bar as 山:
      open -a "Shan Shui"
    The screen saver is chosen in System Settings > Screen Saver.
  EOS
end

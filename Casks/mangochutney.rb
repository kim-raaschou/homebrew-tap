# typed: strict
# frozen_string_literal: true

# Made by `make cask` from Resources/mangochutney.rb.in in kim-raaschou/mangochutney.
cask "mangochutney" do
  version "0.0.2-20261105-beta"
  sha256 "82448acab62eb5dcba4bde7912d129d028e8d89f9f43e835c2df864ff94b1fd5"

  url "https://github.com/kim-raaschou/mangochutney/releases/download/v#{version}/MangoChutney-#{version}.zip"
  name "Mango Chutney"
  desc "Tiling window manager: a port of the mango Wayland compositor"
  homepage "https://github.com/kim-raaschou/mangochutney"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Mango Chutney.app"
  binary "#{appdir}/Mango Chutney.app/Contents/MacOS/mango"
  binary "#{appdir}/Mango Chutney.app/Contents/MacOS/mmsg"

  # Signed with a fixed self-made certificate and not notarized (as AeroSpace), so the
  # Gatekeeper quarantine is removed on install. The certificate is the same for every
  # release, which keeps the Accessibility grant across upgrades.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Mango Chutney.app"], must_succeed: false
  end

  # The old build must not keep running from a replaced bundle.
  uninstall quit: "dev.mangochutney"

  # ~/.config/mango is mango's config and stays.
  zap trash: [
    "~/Library/Application Support/mango",
    "~/Library/LaunchAgents/dev.mangochutney.plist",
    "~/Library/Preferences/dev.mangochutney.plist",
  ]

  caveats <<~EOS
    Start it, and allow Accessibility in the window it shows:
      open -a "Mango Chutney"
    To start it at login (and again after an upgrade):
      mmsg service install
    Stop AeroSpace, yabai or any other tiling window manager first.

    Remember two keys: Hyper K lists every key, Hyper L picks a layout.
    Hyper is the key you choose on the first start, as Raycast's Hyper Key (Caps Lock, …).
    Getting Started: https://github.com/kim-raaschou/mangochutney/blob/main/docs/guide.md#getting-started
  EOS
end

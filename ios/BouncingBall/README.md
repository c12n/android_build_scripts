# BouncingBall (SwiftUI)

A minimal iOS app that shows a red ball bouncing up and down.

## Get the IPA
- **GitHub Actions:** the `Build BouncingBall IPA` workflow builds it on every push touching this folder
  (or run it manually). Download `BouncingBall-ipa` from the run's artifacts.
- **Locally (macOS + Xcode):** `./build_ipa.sh` → `build/BouncingBall.ipa`

The IPA is ad-hoc signed, not signed with an Apple certificate. Install it with a sideloading tool
(AltStore, Sideloadly, etc.) that re-signs it with your Apple ID, or with TrollStore.

# webapp 1.3.0

Feature release after 1.2.1. The Helm chart does not change; nothing to do before upgrading.

- Browser logs can be kept on the device (opt-in), with structured logging.
- Encrypted PDF previews in conversations, behind the Edge feature flag.
- Shared Drive bulk actions without a feature flag; bulk restore stays behind one.
- MLS and calling fixes, mark as unread is back.
- Backup export works again.

---

## Details

Changes since 1.2.1: https://github.com/wireapp/wire-webapp/compare/v1.2.1...v1.3.0-beta.3

### Features

- Opt-in persistent browser logs: startup toggle, structured JSON logging with Pino, bounded buffering, rotation and retention aligned with Wire Desktop, processing in a dedicated worker.
- Encrypted PDF previews and thumbnails in conversations behind the Edge feature flag (WPB-29908).
- Shared Drive: bulk actions out of the feature flag, bulk restore behind a flag, translated move-to-bin and restore strings, checkboxes hidden on the All files tab (WPB-29892, WPB-29920, WPB-29939, WPB-29960).
- API client: bulk archive download for Cells.

### Fixes

- Backup export restored: libsodium-sumo pinned to 0.7.15 (WPB-29974).
- MLS: epoch recovery when message buffering lasts too long; buffered messages keep their authors; malformed buffered messages are isolated; stale conference joins are retried with jittered backoff; debug toggle to drop incoming MLS events.
- Calls: AVS 10.5.24; no missed-call message when the call was answered on another device; meeting reminders stay silent while the status is away; call security line feature released.
- Local data is kept when the local client cannot be loaded; federated E2EI identities separated by domain; stale X509 key packages removed on renewal.
- Mark as unread restored, with the manual unread state kept locally.

### Internal

- Bundled server as the production deployment artifact, gzip and deflate response compression, Node 26.13.1.
- API client, UI kit and commons moved into the webapp; dependency-cruiser circular dependency checks; Renovate lock file maintenance.
- SemVer release planning supports diverged stable tags.

### Chart

No change: `charts/webapp` is the one of 1.2.1.

### Compatibility

Client API versions 1 to 17 (meetings need 17 on the backend). coturn 5.6.0 or later, sftd and Wire Drive 5.0.3 or later when their features are enabled. See `publication/compatibility.yaml`.

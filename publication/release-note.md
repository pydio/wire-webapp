# webapp 0.51.1

The first 0.51 release to go through the standard release process. It ships the same
application as 0.51.0, the September production build, and adds the two fixes already
published in 0.50.1. Nothing to do before upgrading when the chart runs with the nginx
ingress, which is the default.

Compared with the 0.50 line, 0.51 brings three months of product work:

- Shared Drive: drag-and-drop uploads of files and folders, multi-file uploads with a
  status popup, retry and cancel, viewer and editor roles with matching restrictions.
- Meetings: instant meetings with Meet now, time zone aware recurrence, meeting names
  kept in sync with the conversation.
- MLS: reset system messages, unread messages kept across the migration, read receipts
  disabled for MLS and mixed conversations, key-package recovery.
- Groups: guests clearly shown as read-only, admin-less groups handled.
- Chart: a `routing` section selects the controller (`nginx`, `envoy` or `migration`
  via the Gateway API). `ingress.enabled` still works as an alias in this release;
  move to `routing.enabled`.
- Client API versions 1 to 17.

---

## Details

### Fixes added since 0.51.0
- Declare the asset metadata length in UTF-8 bytes, so uploads with non-ASCII file names are not truncated: [wireapp/wire-webapp#22893](https://github.com/wireapp/wire-webapp/pull/22893), WPB-29368
- Keep the "device removed" logout reason when local storage is wiped during logout: [wireapp/wire-webapp#22799](https://github.com/wireapp/wire-webapp/pull/22799), WPB-29521

### Changes since 0.50 (0.51.0 is `7d827697eb`, 2026-09-23.1-production)
Full list: [compare e7b3fd62c2...7d827697eb](https://github.com/wireapp/wire-webapp/compare/e7b3fd62c2...7d827697eb) (686 pull requests, 56 features, 91 fixes).

Shared Drive
- Direct upload module, drag-and-drop of single and multiple files, folder drops and folder selection: WPB-28356, WPB-28291, WPB-28297, WPB-28308, WPB-28304
- Upload status popup and files tab indicator, retry of failed uploads, cancel of active uploads: WPB-28302, WPB-28319, WPB-28305, WPB-28470, WPB-28486
- Viewer and editor roles, viewer banner and restricted actions, access settings: WPB-26111, WPB-26056, WPB-25259, WPB-25254, WPB-25260, WPB-27941
- File preview header metadata, file type labels, tags sorted in the picker: WPB-20724, WPB-27130, WPB-21608

Meetings
- Meet now modal and instant meeting flow: WPB-25057
- Meeting time zone sent and recurrence expanded in the creator's zone: WPB-27613
- Meeting conversation name synced after an update: WPB-27616

MLS
- MLS reset system message, unread messages kept after the 1:1 migration: WPB-26398, WPB-25346
- Read receipts disabled for MLS and mixed protocol conversations: WPB-27943
- Key packages uploaded on initialisation and recovered after exhaustion: WPB-27396

Groups and guests
- Guests shown as read-only to participants and admins: WPB-26116, WPB-26115
- Admin-less group events and member-update events handled: WPB-24879, WPB-25262
- Connection requests via simplified QR code: WPB-22749

Other notable fixes
- Conversation list avatars no longer show the wrong user: WPB-22420
- Original video never exposed when a background effect is enabled: WPB-26402
- Outgoing text message status no longer stale: WPB-27032
- Focus-triggered backend sync tasks throttled and deduplicated: WPB-23080
- MLS established for meeting conversations after login: WPB-26735
- Verification code rate limits no longer retried: WPB-23381
- Archiving and settings navigation fixes: WPB-27977

### Chart
- `routing.enabled` and `routing.mode` (`nginx`, `envoy`, `migration`) replace `ingress.enabled`, kept as a deprecated alias for one release. New `gateway` values (`name`, `namespace`, `sectionName`, `httpRouteAnnotations`) for the Gateway API modes, with new `HTTPRoute` and `ListenerSet` templates. Gateway API 1.5 or later and an existing Gateway are required for `envoy` and `migration`.

### Compatibility
- Client API versions 1 to 17 (0.50 stopped at 16); Kubernetes 1.24 or later; ingress-nginx, Gateway API and cert-manager optional.

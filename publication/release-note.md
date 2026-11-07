# webapp 0.50.1

The first 0.50 release to go through the standard release process, so it comes with a
compatibility file and a release declaration. It carries two fixes. Nothing to do before
upgrading.

- Uploads of files with non-ASCII characters in their name are no longer truncated.
- When this device is removed from the account, the login page says so again. Before, the
  reason was sometimes missing.

---

## Details

### Fixes
- Declare the asset metadata length in UTF-8 bytes, so uploads with non-ASCII file names are not truncated: [wireapp/wire-webapp#22893](https://github.com/wireapp/wire-webapp/pull/22893), [`f55ded426b`](https://github.com/pydio/wire-webapp/commit/f55ded426b), WPB-29368
- Keep the "device removed" logout reason when local storage is wiped during logout: [wireapp/wire-webapp#22799](https://github.com/wireapp/wire-webapp/pull/22799), [`a828877919`](https://github.com/pydio/wire-webapp/commit/a828877919), WPB-29521

### Compatibility
- First `publication/compatibility.yaml` for the 0.50 line: client API versions 1 to 16,
  Kubernetes 1.24 or later, ingress-nginx and cert-manager optional.

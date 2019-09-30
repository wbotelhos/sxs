## v0.2.1

### Fixes

- Requires missing redis class.

## v0.2.0

### Updates

- `provider` key now is mandatory;
- `provider` is only used on `production`;
- `provider` is auto setted by `redis` on `development` and `memory` on `test`;
- You can override auto set using env `SXS_PROVIDER` that overwrites `provider` on production too;

## v0.1.0

### News

- SQS Support;

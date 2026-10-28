# osint_scan

**One capability bit from GBT V8, packaged standalone.** No. 198 of 341,
`recon` domain (Recon).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> OSINT 扫描（DNS/WHOIS/子域名/端口/指纹/邮箱/IP归属/社交；拒绝内网目标）

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-osint-scan.git
cd gbt-osint-scan
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_osint_scan info                  # capability card
python -m gbt_osint_scan spec --json           # machine-readable contract
python -m gbt_osint_scan check --payload '{"target": "<在此填写>"}'
python -m gbt_osint_scan run   --payload '{"target": "<在此填写>"}'
```

Real `info` output from this machine:

```text
osint_scan  (recon)  v1.0.0
----------------------------------------
OSINT 扫描（DNS/WHOIS/子域名/端口/指纹/邮箱/IP归属/社交；拒绝内网目标）

gated      : False
external   : False
multi-op   : False
params     : target
             要扫描的域名或 IP
```

Wire a real implementation:

```python
from gbt_osint_scan import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({"target": "<在此填写>"}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| `target` | yes | declared required by the registry |

Registry hint (`params_hint`): 要扫描的域名或 IP

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
22 passed, 1 skipped in 0.11s
```

## Provenance

| field | value |
|---|---|
| capability | `osint_scan` |
| domain | `recon` |
| handler | `osint_scan` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [recon/osint_scan](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/recon/osint_scan.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.

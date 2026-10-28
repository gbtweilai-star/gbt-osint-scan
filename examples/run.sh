#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_osint_scan info
PYTHONPATH=src python -m gbt_osint_scan check --payload '{"target": "<在此填写>"}'
PYTHONPATH=src python -m gbt_osint_scan run   --payload '{"target": "<在此填写>"}'

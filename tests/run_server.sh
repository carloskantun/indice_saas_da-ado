#!/bin/sh
# Simple PHP dev server for running test and debug scripts
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
php -S localhost:8000 -t "$ROOT_DIR"

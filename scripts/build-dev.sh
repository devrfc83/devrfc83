#!/bin/sh
# Prepara un clon nuevo para desarrollo: enlaza los hooks de .githooks/ en .git/hooks/.
# No usa core.hooksPath para no saltarse los hooks globales (~/.config/git/hooks,
# que corren gitleaks y luego delegan en .git/hooks/).
set -e
cd "$(dirname "$0")/.."
hooks="$(git rev-parse --git-common-dir)/hooks"
mkdir -p "$hooks"
for f in .githooks/*; do
  ln -sf "$(pwd)/$f" "$hooks/$(basename "$f")"
  echo "enlazado: $hooks/$(basename "$f") -> $f"
done

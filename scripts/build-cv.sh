#!/bin/sh
# Compila los CV de cv/ a PDF, uno por idioma.
set -e
cd "$(dirname "$0")/../cv"
for f in cv-rodrigo-fuentealba-*.typ; do
  typst compile "$f"
  echo "$f -> ${f%.typ}.pdf"
done

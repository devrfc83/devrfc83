#!/bin/sh
# Genera las imágenes derivadas a partir de profile.jpg, la fuente de verdad.
set -e
cd "$(dirname "$0")/.."
magick profile.jpg -resize 512x512 -strip -quality 90 profile-512.jpg
magick profile.jpg -resize 600x600 -strip -quality 90 cv/profile.jpg

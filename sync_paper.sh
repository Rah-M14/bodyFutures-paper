#!/usr/bin/env bash
# Sync edits from BodyMind/paper/ into this repo and push to GitHub.
# Run from anywhere: bash /home/rahm/PhD/bodyFutures-paper/sync_paper.sh

set -e

PAPER_SRC="/home/rahm/PhD/BodyMind/paper"
PAPER_REPO="/home/rahm/PhD/bodyFutures-paper"

rsync -av \
  --exclude='*.aux' --exclude='*.log' --exclude='*.bbl' \
  --exclude='*.blg' --exclude='*.fdb_latexmk' --exclude='*.fls' \
  --exclude='*.out' --exclude='*.synctex.gz' --exclude='*.bak' \
  --exclude='*.mp4' --exclude='outputs/' --exclude='generated_figures/' \
  --exclude='supplement_outline.*' --exclude='widthtest.*' \
  "$PAPER_SRC/" "$PAPER_REPO/"

cd "$PAPER_REPO"

if git diff --quiet && git diff --cached --quiet; then
  echo "Nothing changed — already up to date."
  exit 0
fi

git add -A
git status --short

MSG="sync: paper update $(date '+%Y-%m-%d %H:%M')"
git commit -m "$MSG"
git push
echo "Pushed to GitHub: $MSG"

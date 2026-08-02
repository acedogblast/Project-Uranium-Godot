#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

if command -v msginit > /dev/null 2>&1; then
    for cat in Cutscenes Events NPC Objects UI Battle Maps; do
        msginit --no-translator --input=$cat.pot --locale=en --output=Generated/en/$cat.po
    done
else
    echo "msginit absent (gettext) : catalogues .pot inchangés"
fi

UDATA="$1"
if [ -n "$UDATA" ] && [ -d "$UDATA/Data" ]; then
    cd ..
    for lang in french german spanish portuguese dutch chinese korean; do
        UDATA_DIR="$UDATA" python3 Tools/extract_translations.py "$lang"
    done
else
    [ -n "$UDATA" ] && echo "udata introuvable: $UDATA"
fi
echo "Traductions à jour."

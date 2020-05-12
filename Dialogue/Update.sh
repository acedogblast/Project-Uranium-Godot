#!/usr/bin/env bash

for file in Cutscenes Events NPC Objects UI
do
	echo "Updating $file..."
	msgmerge --update --backup=none -N Generated/en/$file.po $file.pot
done
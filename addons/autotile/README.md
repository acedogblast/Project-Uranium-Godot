# Godot AutoTileLayer

v1.1

![Preview](http://i.imgur.com/VR5Z7Up.png)

This is an addon for the [Godot Engine](https://godotengine.org/)
(currently the git version is requred) that allows automatic 2D tiling
using RPG Maker's Autotile format.

For more information on the format:
http://blog.rpgmakerweb.com/tutorials/anatomy-of-an-autotile/

Compatible with both Godot 2.1 and git.
https://github.com/godotengine/godot

Tileset used in preview:
http://opengameart.org/content/lpc-modified-base-tiles

## Usage

 1. Download and place everything in your project's `addons/autotile/`
    directory tree.
 2. In Godot, go to Scene -> Project Settings -> Plugins (Tab).
 3. Set the status for the plugin to `Active`.
 4. In the 2D scene editor, create a new node. Type in `AutoTileLayer`
    to find the node to add.
 5. Use the property panel to set up the tileset to use.
 6. in the default brush mode, use the left mouse button to draw and
    right mouse button to erase.
 7. Switch to box mode to cover larger areas in one go using the toggle
    at the top of the viewport or using `B` and `N` keys.

*NOTE*: While RPG Maker's Autotile is a conveninent format to work with
do remember that most of their official tilesets are licensed for use
only on their products. Always check the license before using other
people's work in your project.

## License

Copyright (c) 2016, Zher Huei Lee
All rights reserved.

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

 1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software
    in a product, an acknowledgment in the product documentation would
    be appreciated but is not required.

 2. Altered source versions must be plainly marked as such, and must not
    be misrepresented as being the original software.

 3. This notice may not be removed or altered from any source
    distribution.

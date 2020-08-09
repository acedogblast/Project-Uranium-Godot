tool
extends Node2D

export(Texture) var texture
export var tileSize = Vector2(16, 16)
export var tiles_to_map = Vector2(0, 0)
export var generate = false
export(Script) var gen_script

func _process(delta):
	if generate:
		generate = false
		if texture != null and get_child_count() < 1:
			var xwidth
			var ywidth
			var own = get_tree().get_edited_scene_root()
			if tiles_to_map == Vector2():
				xwidth = texture.get_size().x / tileSize.x
				ywidth = texture.get_size().y / tileSize.y
			else:
				xwidth = tiles_to_map.x
				ywidth = tiles_to_map.y
			texture.get_data().lock()
			for x in range(0, xwidth):
				for y in range(0, ywidth):
					var pos = Vector2(x,y) * tileSize
					if texture.get_data().get_pixel(pos.x + tileSize.x/2.0, pos.y + tileSize.y/2.0).a < 0.2:
						continue
					var nd = Sprite.new()
					nd.position = pos + Vector2(x,y)
					nd.texture = texture
					nd.region_enabled = true
					nd.region_rect = Rect2(pos, tileSize)
					nd.set_script(gen_script)
					add_child(nd)
					nd.set_owner(own)

extends ParallaxBackground

# If a Camera2D is in the same tree as ParallaxBg, scrolling is disabled :<
# ...unless ParallaxBg is not actually there but just rendered by a viewport :p

# For tiling to work correctly, the viewport with ParallaxBg needs to be on a CanvasLayer
# so that it's fixed in the same place on the screen (like an interface)

func _process(delta: float) -> void:
	scroll_offset.x -= 15

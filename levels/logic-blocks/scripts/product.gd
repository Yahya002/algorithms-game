extends Node2D

var id
var product_name
var price

func setup(data: ProductData):
	id = data.id
	product_name = data.product_name
	price = data.price
	$Sprite2D.texture = data.texture
	$RichTextLabel.text = "[font_size=8][center][color=yellow]%s[/color][/center][/font_size]" % id

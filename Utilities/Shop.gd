extends CanvasLayer
# Pokémon Mart screen - faithful to 146_PScreen_Mart.rb:
# Buy at official price (items.dat), Sell at price/2, important items filtered from stock.

var stock : Array = []
var mode := "menu"  # menu / buy / sell
var idx := 0
var scroll := 0
const VISIBLE := 6

signal shop_closed

func open(stock_names: Array):
	stock = []
	for s in stock_names:
		var nm = ItemPrices.name_from_symbol(s) if not s.contains(" ") else s
		if nm == "":
			nm = s
		if ItemPrices.price_of(nm) > 0 or Global.inventory.get_item_by_name(nm) != null:
			stock.append(nm)
	mode = "menu"
	idx = 0
	visible = true
	get_tree().paused = true
	_refresh()

func _close():
	visible = false
	get_tree().paused = false
	emit_signal("shop_closed")

func _unhandled_input(event):
	if not visible:
		return
	if event.is_action_pressed("ui_down"):
		idx += 1; _clamp(); _refresh()
	elif event.is_action_pressed("ui_up"):
		idx -= 1; _clamp(); _refresh()
	elif event.is_action_pressed("ui_cancel") or event.is_action_pressed("x"):
		if mode == "menu": _close()
		else: mode = "menu"; idx = 0; _refresh()
	elif event.is_action_pressed("ui_accept"):
		_accept()

func _clamp():
	var n = _list().size()
	idx = clampi(idx, 0, maxi(0, n - 1))
	if idx < scroll: scroll = idx
	if idx >= scroll + VISIBLE: scroll = idx - VISIBLE + 1

func _list() -> Array:
	match mode:
		"menu": return ["Buy", "Sell", "Quit"]
		"buy": return stock
		"sell":
			var out = []
			for cat in [Global.inventory.items, Global.inventory.medicine, Global.inventory.balls, Global.inventory.berries, Global.inventory.battle_items]:
				for st in cat:
					var nm2 = st.item.name if "item" in st else str(st)
					if ItemPrices.price_of(nm2) > 0:
						out.append(nm2)
			return out
	return []

func _accept():
	var l = _list()
	if l.is_empty():
		return
	match mode:
		"menu":
			match l[idx]:
				"Buy": mode = "buy"
				"Sell": mode = "sell"
				"Quit": _close(); return
			idx = 0; scroll = 0; _refresh()
		"buy":
			var nm = l[idx]
			var price = ItemPrices.price_of(nm)
			if Global.money >= price:
				Global.money -= price
				Global.inventory.add_item_by_name(nm)
				$Box/Info.text = "Bought " + nm + " for $" + str(price) + "."
			else:
				$Box/Info.text = "You don't have enough money."
			_refresh(false)
		"sell":
			var nm = l[idx]
			var price = ItemPrices.price_of(nm) / 2
			var it = Global.inventory.get_item_by_name(nm)
			if it != null:
				Global.inventory.remove_item(it)
			Global.money += price
			$Box/Info.text = "Sold " + nm + " for $" + str(price) + "."
			_clamp()
			_refresh(false)

func _refresh(reset_info := true):
	var l = _list()
	var lines = []
	for i in range(scroll, mini(l.size(), scroll + VISIBLE)):
		var prefix = "> " if i == idx else "  "
		var price_txt = ""
		if mode == "buy":
			price_txt = "  $" + str(ItemPrices.price_of(l[i]))
		elif mode == "sell":
			price_txt = "  $" + str(ItemPrices.price_of(l[i]) / 2)
		lines.append(prefix + l[i] + price_txt)
	$Box/List.text = "\n".join(lines) if lines.size() else "(nothing)"
	$Box/Money.text = "$" + str(Global.money)
	if reset_info:
		$Box/Info.text = "What can I do for you?" if mode == "menu" else ("How many? Press A to " + mode + ".")

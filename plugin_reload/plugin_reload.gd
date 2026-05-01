@tool
extends EditorPlugin

var replug : Button
var menu : PopupMenu

var all_plugins : Array[String]

func _enter_tree() -> void:
	replug = Button.new()
	replug.text = "Re-Plug"
	replug.pressed.connect(_on_replug_pressed)
	add_control_to_container(CONTAINER_TOOLBAR, replug)
	
	menu = PopupMenu.new()
	menu.hide_on_checkable_item_selection = false
	menu.index_pressed.connect(_on_target_pressed)
	for plugin in DirAccess.get_directories_at("addons"):
		if plugin == "plugin_reload":
			continue
		all_plugins.append(plugin)
	add_tool_submenu_item("Re-Plug", menu)
	update_target_list()


func _exit_tree() -> void:
	remove_control_from_container(CONTAINER_TOOLBAR, replug)
	remove_tool_menu_item("Re-Plug")
	replug.queue_free()

func _on_replug_pressed():
	for idx in range(menu.item_count):
		var plugin = menu.get_item_text(idx)
		if menu.is_item_checked(idx):
			EditorInterface.set_plugin_enabled(plugin, false)
			EditorInterface.set_plugin_enabled.call_deferred(plugin, true)
	update_target_list.call_deferred()

func _on_target_pressed(idx:int):
	var checked = not menu.is_item_checked(idx)
	menu.set_item_checked(idx, checked)

func update_target_list():
	# Persist checked targets
	var checked : Array[String]
	for idx in range(menu.item_count):
		if menu.is_item_checked(idx):
			checked.append(menu.get_item_text(idx))
	# Rebuild targets
	menu.clear()
	var idx : int = -1
	for plugin in all_plugins:
		if EditorInterface.is_plugin_enabled(plugin):
			idx += 1
			menu.add_check_item(plugin)
			if plugin in checked:
				menu.set_item_checked(idx, true)

static func patch():
	var script_path = "res://nodes/partners/SwapPartnerAction.gd"
	var patched_script : GDScript = preload("res://nodes/partners/SwapPartnerAction.gd")

	if !patched_script.has_source_code():
		var file : File = File.new()
		var err = file.open(script_path, File.READ)
		if err != OK:
			push_error("Check that %s is included in Modified Files"% script_path)
			return
		patched_script.source_code = file.get_as_text()
		file.close()

	var code_lines:Array = patched_script.source_code.split("\n")

	var code_index = code_lines.find("	if yield (MenuHelper.confirm(message), \"completed\"):")
	if code_index > 0:
		code_lines.insert(code_index+1,get_code("add_new_confirm"))

	code_lines.insert(code_lines.size()-1,get_code("new_function"))

	patched_script.source_code = ""
	for line in code_lines:
		patched_script.source_code += line + "\n"

	var err = patched_script.reload()
	if err != OK:
		push_error("Failed to patch %s." % script_path)
		return

static func get_code(block:String)->String:
	var code_blocks:Dictionary = {}
	code_blocks["add_new_confirm"] = """
		if yield(MenuHelper.confirm("MOD_TAPESWAP_CONFIRM_TAPE"),"completed"):
			retain_current_party_tapes(current_partner, pawn)
	"""

	code_blocks["new_function"] = """
func retain_current_party_tapes(current_partner, swapping_partner):
	var current_tapes = current_partner.character.tapes.duplicate()
	var stored_tapes = swapping_partner.character.tapes.duplicate()
	current_partner.character.tapes = stored_tapes
	swapping_partner.character.tapes = current_tapes
	"""
	return code_blocks[block]




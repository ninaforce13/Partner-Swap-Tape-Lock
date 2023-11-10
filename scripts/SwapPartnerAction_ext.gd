extends "res://nodes/partners/SwapPartnerAction.gd"

func _run():
	var pawn = get_pawn()
	var current_partner = WorldSystem.get_partner()
	
	var message = Loc.trgf("PARTNER_SWAP_CONFIRM", pawn.character.pronouns, {
		"name":pawn.character.name
	})
	
	if yield (MenuHelper.confirm(message), "completed"):
		if yield(MenuHelper.confirm("MOD_TAPESWAP_CONFIRM_TAPE"),"completed"):
			retain_current_party_tapes(current_partner, pawn)		
		swap_partners(pawn, current_partner)
		return true
	return false
	
func retain_current_party_tapes(current_partner, swapping_partner):
	var current_tapes = current_partner.character.tapes.duplicate()
	var stored_tapes = swapping_partner.character.tapes.duplicate()
	current_partner.character.tapes = stored_tapes
	swapping_partner.character.tapes = current_tapes
	


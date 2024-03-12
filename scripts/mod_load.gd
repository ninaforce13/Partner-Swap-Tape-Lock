extends ContentInfo
var swap_partner = preload("res://mods/PartnerSwapRetainTape/scripts/SwapPartnerAction_patch.gd")

func _init():
	swap_partner.patch()


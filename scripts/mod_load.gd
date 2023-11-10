extends ContentInfo

func init_content():
	var SwapPartnerExt:Resource = preload("res://mods/PartnerSwapRetainTape/scripts/SwapPartnerAction_ext.gd")
	SwapPartnerExt.take_over_path("res://nodes/partners/SwapPartnerAction.gd")
	

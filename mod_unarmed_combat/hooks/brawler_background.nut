::ModUnarmedCombat.HooksMod.hook("scripts/skills/backgrounds/brawler_background", function( q ) {

	q.onAddEquipment = @(__original) function()
	{
		__original();
		this.getContainer().getActor().getItems().equip(this.new("scripts/items/accessory/legend_hand_wraps_item"));
	}
});

::ModUnarmedCombat.HooksMod.hook("scripts/skills/backgrounds/legend_berserker_commander_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.LegendUnarmedTraining);
	}

	q.onAddEquipment = @(__original) function()
	{
		__original();
		if (this.getContainer().getActor().getMainhandItem() == null)
			this.getContainer().getActor().getItems().equip(this.new("scripts/items/accessory/legend_hand_wraps_item"));
	}
});
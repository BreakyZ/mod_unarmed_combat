::ModUnarmedCombat.HooksMod.hook("scripts/skills/perks/perk_mastery_fist", function ( q ) {
	q.onAdded <- function()
	{
		if (!this.getContainer().hasSkill("actives.legend_kick"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_kick"));
		}
	}

	q.onRemoved <- function()
	{
		this.getContainer().removeByID("actives.legend_kick");
	}
});

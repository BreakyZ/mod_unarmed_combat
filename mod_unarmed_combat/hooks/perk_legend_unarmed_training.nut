::ModUnarmedCombat.HooksMod.hook("scripts/skills/perks/perk_legend_unarmed_training", function ( q ) {
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == "actives.hand_to_hand")
		{
			if (_properties.IsSpecializedInFists)
				_properties.DamageArmorMult *= 1.2;
			if (this.getContainer().hasSkill("perk.sundering_strikes"))
				_properties.DamageArmorMult *= 1.2;

			local damage = (actor.getHitpointsMax()) / 15;

			if (actor.getOffhandItem() != null)
				damage = damage * 0.5;

			if (actor.getMainhandItem() != null)
				damage = damage * 0.2;
			
			if (this.getContainer().hasSkill("perk.crGrandslam"))
			{
				damage = damage * 1.5;
			}

			_properties.DamageRegularMin += this.Math.floor(damage);
			_properties.DamageRegularMax += this.Math.floor(damage);
		}

		if (_skill.getID() == "actives.legend_choke")
		{
			_properties.DamageTotalMult *= 1.5;
			_properties.MeleeSkill += 10;
		}
	}

	q.onAdded <- function()
	{
		if (!this.getContainer().hasSkill("actives.legend_tackle") && this.getContainer().getActor().isPlayerControlled())
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_tackle"));
		}
	}

	q.onRemoved <- function()
	{
		this.getContainer().removeByID("actives.legend_tackle");
	}
});
::ModUnarmedCombat.HooksMod.hook("scripts/skills/perks/perk_legend_unarmed_training", function ( q ) {
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == "actives.hand_to_hand" || _skill.getID() == "actives.legend_dropkick")
		{
			if (_properties.IsSpecializedInFists)
				_properties.DamageArmorMult *= 1.2;
			if (this.getContainer().hasSkill("perk.sundering_strikes"))
				_properties.DamageArmorMult *= 1.2;

			local damage = (actor.getFatigue() + actor.getHitpoints()) / 30;

			if (_skill.getID() == "actives.hand_to_hand")
			{
				if (actor.getOffhandItem() != null)
					damage = damage * 0.5;

				if (actor.getMainhandItem() != null)
					damage = damage * 0.2;
			}
			
			if (this.getContainer().hasSkill("perk.crGrandslam"))
			{
				damage = damage * 1.5;
				_properties.DamageDirectMult = 1.5;
			}

			_properties.DamageRegularMin += this.Math.floor(0.3 * damage);
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
		if (!this.m.Container.hasSkill("actives.legend_dropkick") && this.m.Container.hasSkill("perk.legend_kick"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_dropkick"));
		}
	}

	q.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.legend_dropkick");
	}

});
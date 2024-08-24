::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/hand_to_hand", function ( q ) {
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		__original( _skill, _targetEntity, _properties );
		local items = this.getContainer().getActor().getItems().getAllItems();
		local hasCestus = false;
		local hasWraps = false;
		foreach (item in items)
		{
			if (item.getID() == "accessory.legend_hand_wraps")
				hasWraps = true;
			if (item.getID() == "accessory.legend_cestus")
				hasCestus = true;
		}

		if (hasCestus)
		{
			_properties.DamageRegularMin += 6;
			_properties.DamageRegularMax += 12;
			_properties.DamageArmorMult = 0.2;
		}
		else if (hasWraps)
		{
			_properties.DamageRegularMin += 2;
			_properties.DamageRegularMax += 6;
		}
	};
});
::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_choke", function ( q ) {
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		__original( _skill, _targetEntity, _properties );
		local items = this.getContainer().getActor().getItems().getAllItems();
		local hasCestus = false;
		foreach (item in items)
		{
			if (item.getID() == "accessory.legend_cestus" || item.getID() == "accessory.legend_hand_wraps")
				_properties.DamageTotalMult *= 1.1;
				return;
		}
	};
});

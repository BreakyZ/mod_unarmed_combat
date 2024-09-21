::ModUnarmedCombat.HooksMod.hook("scripts/skills/actives/legend_choke", function ( q ) {
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		__original( _skill, _targetEntity, _properties );
		local items = this.getContainer().getActor().getItems().getAllItems();
		local hasCestus = false;
		if (_skill != this)
			return;
		foreach (item in items)
		{
			if (item.getID() == "accessory.legend_cestus" || item.getID() == "accessory.legend_hand_wraps")
				_properties.DamageTotalMult *= 1.1;
				return;
		}
	};
});

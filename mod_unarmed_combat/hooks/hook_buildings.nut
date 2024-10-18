foreach (marketplace in ["marketplace_building", "marketplace_oriental_building"])
{
	::ModUnarmedCombat.HooksMod.hook("scripts/entity/world/settlements/buildings/" + marketplace, function ( q ) {

		q.fillStash = @( __original ) function( _list, _stash, _priceMult, _allowDamagedEquipment = true )
		{
			_list.push({
				R = 60,
				P = 1.0,
				S = "accessory/legend_hand_wraps_item"
			});
			__original( _list, _stash, _priceMult, _allowDamagedEquipment = true );
		}
	});
}
::ModUnarmedCombat.HooksMod.hook("scripts/entity/world/settlements/buildings/weaponsmith_oriental_building", function ( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.push({
				R = 70,
				P = 1.0,
				S = "accessory/legend_cestus_item"
		});

		__original( _list, _stash, _priceMult, _allowDamagedEquipment = false );
	}

});
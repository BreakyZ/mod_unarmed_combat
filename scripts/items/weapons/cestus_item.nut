this.cestus_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.cestus";
		this.m.Name = "Gladiator\'s Cestus";
		this.m.Description = "A pair of gloves, made from studded leather straps, enclosing and protecting a fighter\'s lower arm and fist. Used to deal more powerful punches.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_scimitar_01";
		this.m.Icon = "accessory/cestus.png";
		this.m.Value = 2300;
		this.m.RegularDamage = 2;
		this.m.RegularDamageMax = 12;
	}

	function getTooltip()
	{
		result = this.weapon.getTooltip();

		result.extend(
		[
			{
				id = 15,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] more damage (multiplicative) on [color=#400080]Choke[/color]."
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] more armor damage on unarmed attacks."
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] more damage (multiplicative) on [color=#400080]Choke[/color]."
			}
		]);
		return result;
	}

	function onAnySkillUsed(  _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.hand_to_hand")
		{
			_properties.DamageArmorMult = 0.2;
		}
		if (_skill.getID() == "actives.legend_choke")
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_01.wav", this.Const.Sound.Volume.Inventory);
	}
});

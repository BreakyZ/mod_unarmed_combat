this.hand_wraps_item <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "weapon.hand_wraps";
		this.m.Name = "Pugilist Hand Wraps";
		this.m.Description = "Simple cloth wrapped around the hands, protects the wearer from the impact of his own punches and allows them to hit harder.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_scimitar_01";
		this.m.Icon = "accessory/hand_wraps.png";
		this.m.Value = 35;
		this.m.RegularDamage = 2;
		this.m.RegularDamageMax = 6;
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
			}
		]);
		return result;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/slash");
		skill.m.Icon = "skills/active_172.png";
		skill.m.IconDisabled = "skills/active_172_sw.png";
		skill.m.Overlay = "active_172";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/gash_skill");
		this.addSkill(skill);
	}

	function onAnySkillUsed(  _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.hand_to_hand")
		{
			_properties.DamageRegularMin += 2;
			_properties.DamageRegularMax += 6;
			_properties.DamageTotalMult *= 1.1;
		}
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}
});

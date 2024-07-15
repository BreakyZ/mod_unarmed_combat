this.cestus_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.cestus";
		this.m.Name = "Gladiator\'s Cestus";
		this.m.Description = "A pair of gloves, made from studded leather straps, enclosing and protecting a fighter\'s lower arm and fist. Used to deal more powerful punches.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/cestus.png";
		this.m.Value = 2300;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+6-12[/color] more damage on unarmed attacks."
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
		});
		return result;
	}

	function onAnySkillUsed(  _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.hand_to_hand")
		{
			_properties.DamageRegularMin += 6;
			_properties.DamageRegularMax += 12;
			_properties.DamageArmorMult = 0.2;
		}
		if (_skill.getID() == "actives.legend_choke")
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/armor_leather_impact_01.wav", this.Const.Sound.Volume.Inventory);
	}
});

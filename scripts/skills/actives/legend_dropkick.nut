this.legend_dropkick <- this.inherit("scripts/skills/skill", {
	m = {
		SoundOnAttack = [
			"sounds/combat/dlc2/lunge_attack_01.wav",
			"sounds/combat/dlc2/lunge_attack_02.wav",
			"sounds/combat/dlc2/lunge_attack_03.wav",
			"sounds/combat/dlc2/lunge_attack_04.wav"
		],
		Backgrounds = [
			"background.legend_commander_druid",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		]
	},
	function create()
	{
		this.m.ID = "actives.legend_dropkick";
		this.m.Name = "Dropkick";
		this.m.Description = "Jump towards a target 2 tiles away and kick them to break their balance and inflict injuries. Targets hit will receive damage and fatigue, get dazed and staggered. Shieldwall, Spearwall, Return Favor, and Riposte will be canceled for a target that is successfully hit.";
		this.m.KilledString = "Dropkicked";
		this.m.Icon = "skills/kick_square.png";
		this.m.IconDisabled = "skills/kick_square_bw.png";
		this.m.Overlay = "active_kick";
		this.m.SoundOnUse = [
			"sounds/combat/dlc2/lunge_move_01.wav",
			"sounds/combat/dlc2/lunge_move_02.wav",
			"sounds/combat/dlc2/lunge_move_03.wav",
			"sounds/combat/dlc2/lunge_move_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 2;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 33;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();

		if (this.m.Backgrounds.find(actor.getBackground()) != null)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Damage (from background)"
			});
		}

		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Moves the user next to the target, ignoring Zone of Control"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger and daze on a hit"
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFists)
		{
			ret.extend([
				{
					id = 6,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Costs [color=" + this.Const.UI.Color.PositiveValue + "]-1[/color] Action Point due to unarmed training"
				},
				{
					id = 7,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Will stun if the target is Staggered or Dazed"
				}
			]);
		}
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 4 + "[/color] fatigue on hit"
		});

		if (this.getContainer().hasSkill("perk.legend_tumble"))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Costs [color=" + this.Const.UI.Color.PositiveValue + "]-1[/color] Action Point due to Tumble"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local myTile = this.getContainer().getActor().getTile();
		local hasTile = false;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
				continue;
			}
			local tile = _targetTile.getNextTile(i);

			if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
			{
				hasTile = true;
				break;
			}
		}

		return hasTile;
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.SoundOnAttack )
		{
			this.Tactical.addResource(r);
		}
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInFists)
		{
			this.m.ActionPointCost -= 1;
		}
		if (this.getContainer().hasSkill("perk.legend_tumble"))
		{
			this.m.ActionPointCost -= 1;
		}
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local destTile;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
				continue;
			}

			local tile = _targetTile.getNextTile(i);

			if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
			{
				destTile = tile;
				break;
			}

		}

		if (destTile == null)
		{
			return false;
		}

		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};
		_user.spawnTerrainDropdownEffect(myTile);
		this.Tactical.getNavigator().teleport(_user, destTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);

		if (!_entity.isAlive() || _entity.isDying())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " jumps and drops " + this.Const.UI.getColorizedEntityName(victim));
			return;
		}
		return onAfterTeleportDone( _user, _targetTile);
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local ZOC = [];
		this.getContainer().setBusy(false);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
				continue;
			}

			local tile = myTile.getNextTile(i);

			if (!tile.IsOccupiedByActor)
			{
				continue;
			}

			local actor = tile.getEntity();

			if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned)
			{
				continue;
			}

			ZOC.push(actor);
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true))
			{
				continue;
			}

			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " jumps for a kick and is repelled");
				}

				if (!_entity.isAlive() || _entity.isDying())
				{
					return;
				}

				local dir = myTile.getDirectionTo(_tag.OldTile);

				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);

					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}
			}
		}

		this.spawnAttackEffect(_tag.TargetTile, this.Const.Tactical.AttackEffectThrust);
		local s = this.m.SoundOnUse;
		this.m.SoundOnUse = this.m.SoundOnAttack;
		this.attackEntity(_entity, _tag.TargetTile.getEntity());
		this.m.SoundOnUse = s;
	}

	function onAfterTeleportDone( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hasFistMastery = _user.getSkills().hasSkill("perk.mastery_fist");
		local skills = target.getSkills();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (this.Math.rand(1, 100) > this.getHitchance(target))
		{
			target.onMissed(this.getContainer().getActor(), this);
			return false;
		}

		this.applyFatigueDamage(target, 20);
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " inflicted 20 fatigue on " + this.Const.UI.getColorizedEntityName(target) + " with a kick");

		// Remove enemy stances
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		skills.removeByID("effects.return_favor");

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (hasFistMastery && !target.getCurrentProperties().IsImmuneToStun && (victim.getSkills().hasSkill("effects.staggered") || victim.getSkills().hasSkill("effects.dazed")))
		{
			target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
			if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " dropkicks and stuns " + this.Const.UI.getColorizedEntityName(victim));
		}
		else
		{
			target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
			target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has dazed " + this.Const.UI.getColorizedEntityName(target) + "for one turn");
		}
		return true;
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}
		local actor = this.getContainer().getActor();
		local mhand = actor.getMainhandItem();

		if (mhand != null)
		{
			_properties.DamageRegularMin -= mhand.m.RegularDamage;
			_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
		}
		_properties.DamageRegularMin += 20;
		_properties.DamageRegularMax += 30;
		_properties.DamageArmorMult += 0.2;

		if (this.m.Backgrounds.find(this.getContainer().getActor().getBackground()) != null)
		{
			_properties.DamageTotalMult *= 1.25;	
		}
	}

});


::Const.Strings.PerkDescription.LegendUnarmedTraining = "Focusing on technique, form, and stances has given you greater control over your unarmed strikes.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Increases damage of [color=#400080]Hand to Hand[/color] attack by max Hitpoints divided by 15.\n\n• This Damage increase is reduced by [color=" + ::Const.UI.Color.NegativeValue + "]50%[/color] (multiplicative) if you have an item in your offhand and is reduced by [color=" + ::Const.UI.Color.NegativeValue + "]80%[/color] (multiplicative) with an item in your mainhand.\n\n• If you have [color=#008060]Unarmed Specialization[/color] gain [color=" + ::Const.UI.Color.PositiveValue + "]+20%[/color] (multiplicative) effectiveness against Armor.\n\n• [color=#400080]Choke[/color] gains [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] chance to hit and deals [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] more damage.\n\n[color=" + ::Const.UI.Color.Passive + "][u]Active:[/u][/color]\n• Unlocks the [color=" + ::Const.UI.Color.Skill + "]Tackle Skill[/color].";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendUnarmedTraining].Tooltip = ::Const.Strings.PerkDescription.LegendUnarmedTraining;
::Const.Strings.PerkDescription.LegendSpecFists = "Master the martial arts of unarmed combat.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Reduces the Fatigue costs of [color=#400080]Hand to Hand[/color], [color=#400080]Kick[/color], [color=#400080]Grapple[/color], [color=#400080]Choke[/color], and [color=#400080]Tackle[/color] by [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color].\n\n• Lowers AP cost for [color=#400080]Hand to Hand[/color] by [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] and increases Fatigue inflicted by [color=" + this.Const.UI.Color.PositiveValue + "]5[/color].\n\n• [color=#400080]Kick[/color] has [color=#731f39]Daze[/color] chance increased to [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] and hit chance increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color].\n\n• [color=#400080]Choke[/color] damage is increased by [color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] when target is already [color=#731f39]Choked[/color] or [color=#731f39]Grappled[/color].\n\n• [color=#400080]Grapple[/color] now has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to be disarm on hit and hit chance is increased by [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color].\n\n• [color=#400080]Tackle[/color] gains [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] chance to hit.\n\n[color=" + ::Const.UI.Color.Passive + "][u]Active:[/u][/color]\n• Unlocks the [color=" + ::Const.UI.Color.Skill + "]Kick Skill[/color].";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Tooltip = ::Const.Strings.PerkDescription.LegendSpecFists;

::Const.Perks.FistsClassTree.Tree[0] = [::Const.Perks.PerkDefs.LegendAmbidextrous];
::Const.Perks.FistsClassTree.Tree[5] = [];
::Const.Perks.FistsClassTree.Tree[6] = [::Const.Perks.PerkDefs.LegendUnarmedTraining];
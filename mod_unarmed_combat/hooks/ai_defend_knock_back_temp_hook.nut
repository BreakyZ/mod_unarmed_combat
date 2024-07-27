::ModUnarmedCombat.HooksMod.hook("scripts/ai/tactical/behaviors/ai_defend_knock_back", function( q ) {
	local cleanedSkills = [];
	foreach (skill in q.m.PossibleSkills)
	{
		if (skill != "actives.legend_kick")
		{
			cleanedSkills.push(skill);
		}
	}
	q.m.PossibleSkills = cleanedSkills;
});

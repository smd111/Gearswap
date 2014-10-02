
	sets.bst = {}
	sets.bst.reward = {main="Zoraal Ja's Axe",sub="Zoraal Ja's Axe",hands="Ogre Gloves"} -- (hands can be Ogre Gloves or Ogre Gloves +1)
	sets.bst.charm = {main="Light Staff"} -- (main can be Light Staff or Apollo's Staff or Iridal Staff)

function sub_job_precast(spell)
	if spell.english == 'Reward' then
		equip_pre_cast = set_combine(equip_pre_cast, sets.bst.reward)
	end
	if spell.english == 'Charm' then
		equip_pre_cast = set_combine(equip_pre_cast, sets.bst.charm)
	end
end

    sets.bst_job = {}
    sets.bst_job.reward = {main="Zoraal Ja's Axe",sub="Zoraal Ja's Axe",hands="Ogre Gloves"} -- (hands can be Ogre Gloves or Ogre Gloves +1)
    sets.bst_job.charm = {main="Light Staff"} -- (main can be Light Staff or Apollo's Staff or Iridal Staff)

function SJi_precast(status,set_gear,event_type,spell)
    if spell.english == 'Reward' then
        set_gear = set_combine(set_gear, sets.bst_job.reward)
    end
    if spell.english == 'Charm' then
        set_gear = set_combine(set_gear, sets.bst_job.charm)
    end
    return set_gear
end
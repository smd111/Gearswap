    nin_tools = {
        ["Monomi"]={t='Sanjaku-Tenugui',tb="Toolbag (Sanja)",tb_id=5417,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},
        ["Aisha"]={t='Soshi',tb="Toolbag (Soshi)",tb_id=5734,ut="Chonofuda",utb="Toolbag (Cho)",utb_id=5869},
        ["Katon"]={t='Uchitake',tb="Toolbag (Uchi)",tb_id=5308,ut="Inoshishinofuda",utb="Toolbag (Ino)",utb_id=5867},
        ["Hyoton"]={t='Tsurara',tb="Toolbag (Tsura)",tb_id=5309,ut="Inoshishinofuda",utb="Toolbag (Ino)",utb_id=5867},
        ["Huton"]={t='Kawahori-Ogi',tb="Toolbag (Kawa)",tb_id=5310,ut="Inoshishinofuda",utb="Toolbag (Ino)",utb_id=5867},
        ["Doton"]={t='Makibishi',tb="Toolbag (Maki)",tb_id=5311,ut="Inoshishinofuda",utb="Toolbag (Ino)",utb_id=5867},
        ["Raiton"]={t='Hiraishin',tb="Toolbag (Hira)",tb_id=5312,ut="Inoshishinofuda",utb="Toolbag (Ino)",utb_id=5867},
        ["Suiton"]={t='Mizu-Deppo',tb="Toolbag (Mizu)",tb_id=5313,ut="Inoshishinofuda",utb="Toolbag (Ino)",utb_id=5867},
        ["Utsusemi"]={t='Shihei',tb="Toolbag (Shihe)",tb_id=5314,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},
        ["Jubaku"]={t='Jusatsu',tb="Toolbag (Jusa)",tb_id=5315,ut="Chonofuda",utb="Toolbag (Cho)",utb_id=5869},
        ["Hojo"]={t='Kaginawa',tb="Toolbag (Kagi)",tb_id=5316,ut="Chonofuda",utb="Toolbag (Cho)",utb_id=5869},
        ["Kurayami"]={t='Sairui-Ran',tb="Toolbag (Sai)",tb_id=5317,ut="Chonofuda",utb="Toolbag (Cho)",utb_id=5869},
        ["Dokumori"]={t='Kodoku',tb="Toolbag (Kodo)",tb_id=5318,ut="Chonofuda",utb="Toolbag (Cho)",utb_id=5869},
        ["Tonko"]={t='Shinobi-Tabi',tb="Toolbag (Shino)",tb_id=5319,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},
        ["Gekka"]={t='Ranka',tb="Toolbag (Ranka)",tb_id=6265,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},
        ["Yain"]={t='Furusumi',tb="Toolbag (Furu)",tb_id=6266,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},
        ["Myoshu"]={t='Kabenro',tb="Toolbg. (Kaben)",tb_id=5863,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},
        ["Yurin"]={t='Jinko',tb="Toolbag (Jinko)",tb_id=5864,ut="Chonofuda",utb="Toolbag (Cho)",utb_id=5869},
        ["Kakka"]={t='Ryuno',tb="Toolbag (Ryuno)",tb_id=5865,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},
        ["Migawari"]={t='Mokujin',tb="Toolbag (Moku)",tb_id=5866,ut="Shikanofuda",utb="Toolbag (Shika)",utb_id=5868},}

function nin_tool_check(typ,spell)
    if (player.inventory[nin_tools[typ].t] == nil  or player.inventory[nin_tools[typ].ut] == nil) 
    and (player.inventory[nin_tools[typ].tb] ~= nil or player.inventory[nin_tools[typ].utb] ~= nil) then
        return true
    elseif (player.inventory[nin_tools[typ].t] == nil  or player.inventory[nin_tools[typ].ut] == nil) 
    and (player.inventory[nin_tools[typ].tb] == nil or player.inventory[nin_tools[typ].utb] == nil) then
        add_to_chat(7,"No Tools Available To Cast "..spell.name)
    end
end
function nin_tool_open(typ)
    if player.inventory[nin_tools[typ].tb] ~= nil then
        return nin_tools[typ].tb
    elseif player.inventory[nin_tools[typ].utb] ~= nil then
        return nin_tools[typ].utb
    end
end
function nin_tool_rule(status,set_gear,spell)
    if spell.type == "Ninjutsu" then
        local typ = string.match(spell.en, '(%a+): %a+')
        if nin_tool_check(typ,spell) then
            status.end_spell=true
            status.end_event=true
            send_command('input /item "'..nin_tool_open(typ)..'" <me>')
        end
    end
end
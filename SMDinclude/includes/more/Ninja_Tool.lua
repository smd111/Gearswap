nin_tool = {}
function nin_tool.open(status,current_event,spell)
    local bag_id = {['Sanjaku-Tenugui']=5417,['Soshi']=5734,['Uchitake']=5308,['Tsurara']=5309,['Kawahori-Ogi']=5310,['Makibishi']=5311,['Hiraishin']=5312,
                    ['Mizu-Deppo']=5313,['Shihei']=5314,['Jusatsu']=5315,['Kaginawa']=5316,['Sairui-Ran']=5317,['Kodoku']=5318,['Shinobi-Tabi']=5319,['Ranka']=6265,
                    ['Furusumi']=6266,['Kabenro']=5863,['Jinko']=5864,['Ryuno']=5865,['Mokujin']=5866,["Chonofuda"]=5869,["Inoshishinofuda"]=5867,["Shikanofuda"]=5868}
    local t = gearswap.tool_map[spell.en][gearswap.language]
    local ut = gearswap.universal_tool_map[spell.en][gearswap.language]
    local tb = res.items[bag_id[t]][gearswap.language]
    local utb = res.items[bag_id[ut]][gearswap.language]
    if player.inventory[tb] ~= nil then
        return tb
    elseif player.inventory[utb] ~= nil then
        return utb
    else
        add_to_chat(cc.mc,"No Tools Available To Cast "..spell.name)
    end
end
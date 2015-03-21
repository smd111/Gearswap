include('includes/more/Ninja_Tool.lua')

function MJi_filtered_action(status,set_gear,event_type,spell)
    nin_tool_rule(spell,status,set_gear)
    return set_gear
end
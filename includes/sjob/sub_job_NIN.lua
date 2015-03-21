include('includes/more/Ninja_Tool.lua')

function SJi_filtered_action(status,set_gear,event_type,spell)
    nin_tool_rule(status,set_gear,event_type,spell)
    return set_gear
end
include('includes/more/Ninja_Tool.lua')

function SJi_filtered_action(spell,status,set_gear)
    nin_tool_rule(spell,status,set_gear)
    return set_gear
end
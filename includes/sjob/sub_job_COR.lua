include('includes/more/CorsairShot_Cards.lua')
    
function SJi_precast(spell,status,set_gear)
    card_rule(spell,status,set_gear)
    return set_gear
end
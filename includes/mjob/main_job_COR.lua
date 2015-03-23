include('includes/more/CorsairShot_Cards.lua')

function MJi_precast(status,set_gear,spell)
    card_rule(spell,status,set_gear)
    return set_gear
end
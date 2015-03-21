include('includes/more/CorsairShot_Cards.lua')
    
function SJi_precast(status,set_gear,event_type,spell)
    card_rule(status,set_gear,event_type,spell)
    return set_gear
end
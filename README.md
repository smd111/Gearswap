SMD's Gearswap Include files
2.50 Alpha
-------------------------------------------------------------------
Setup--------------------------------------------------------------

you need to use my basic.lua which has all the required info in the file
at the top are some toggles you can change on your own thay are self explanatory

to use display include requires Segoe UI Symbol font
this font is native to vista/win7/win8

--------------------------------------------------------------------
Features------------------------------------------------------------

--NIN tool unboxing included for main and sub job

--COR card uncasing included

--auto ammo unsacking included for jobs that can use the specific ammo

--save specific settings between jobs and play sessions

--display showing user settings based on jobs and includes in use

--it will automatically change your weaponskill if your using a weapon like Molva Maul to the 13th ws unlocked weaponskill

--------------------------------------------------------------------
Chat/Macro Commands-------------------------------------------------

all of the command can be input via chat, macro, or the windower console thay also exist in the display if you use it
chat: //gs c <command>
macro: /console gs c <command>
windower console: gs c <command>

----thes command need to be put in as you see them
reload_gearswap   - reloads geaswap(always works) and forces a write to your settings save file(only if using file write include)
toggledisplay     - hids and shows the display (only when using display include)

--- MJi and SJi include ---
---- only if main/sub job is dnc ----
tstopsteps        - enables and disables stop steps at the set amount of finishing moves
stepcount         - cycles from 1 to 5 finishing moves {used with tstopsteps to only allow a specific amount of finishing moves}
autohw            - enables Auto Healing Waltz {when you gain a buff that healing waltz can remove it will try to remove it}

---- only if using the debug include ----
tDebug            - turns on and off verbose debug mode
cDebugtype        - cycles through all the posible debug types

---- only if main job can equip and if using MSi include ----
tstavetouse       - toggles between Atk and Acc Magians staves in there compleated form
tchangemagestaff  - enables and disables auto switching of main hand to Magians staves in there compleated form

---- if using the Conquest Gear include and in a zone that has conquest ----
conquestneck      - cycles through the 3 types of conquest neck gear
conquestring      - cycles through the 3 types of conquest ring gear
conquestneckchange- enables and disables the changing of conquest neck gear
conquestringchange- enables and disables the changing of conquest ring gear

----the commands are to allow you to set a specific setting(these are all pregfixed with 'set')----

armor <type>      - there are 3 of these included in these files Normal, Acc, Att 
(note: you can add as many as you want by using the command in your gear_setup function -- add_gear_modes("<mode>","<mode2>",....))
example: set armor acc

range <switch>   - sets the range/ammo gear you want to use (if you do not have a set defined it will let you know)
r <switch>       - sets the range/ammo gear you want to use (if you do not have a set defined it will let you know)
example: set range bow

-switches-
archery / bow                 - sets range weapon to archery
marksmanship / xbow / gun     - sets range weapon to marksmanship
throwing / throw              - sets range weapon to throwing
fishing / fish                - sets range weapon to fishing
soultrapper / camera          - sets range weapon to soultrapper
wind_instruments / flute      - sets range weapon to wind instrument
string_instruments / harp     - sets range weapon to string instrument
handbells / bell              - sets range weapon to hand bell
other                         - sets range weapon to other

weapon <switch>  - sets the main/sub gear you want to use (if you do not have a set defined it will let you know)
w <switch>       - sets the main/sub gear you want to use (if you do not have a set defined it will let you know)
example: set weapon axe

-switches-
axe                  - sets weapon to axe
club                 - sets weapon to club
dagger               - sets weapon to dagger
great_axe / ga       - sets weapon to great axe
great_sword / gs     - sets weapon to great_sword
hand-to-hand / h2h   - sets weapon to hand-to-hand
polearm              - sets weapon to polearm
scythe               - sets weapon to scythe
staff                - sets weapon to staff
sword                - sets weapon to sword
great_katana / gk    - sets weapon to great katana
katana               - sets weapon to katana

---when using MJi or SJi include---
---- only if main/sub job is dnc ----
stepmax <number>  - will set max steps to the number you provide as long as it is 1 to 5
example: set stepmax 4

---when using the debug include---
debug <switch>   -
example: set debug status_change

-switches-
status_change / sc            - gives information when using spell/ability/item in status_change function
pet_change / pc               - gives information when you gain or lose a pet in pet_change function
filtered_action / fa          - gives information when using spell/ability/item that you can do in  filtered_action function
pretarget / pret              - gives information when using spell/ability/item in pretarget function
precast / prec                - gives information when using spell/ability/item in precast function
buff_change / bc              - gives information when you gain a buf or lose a buff in buff_change function
midcast / mc                  - gives information when using spell/ability/item in midcast function
pet_midcast / pmc             - gives information when a pet starts casting a spell/ability pet_midcast function
aftercast / ac                - gives information when using spell/ability/item in aftercast function
pet_aftercast / pac           - gives information when a pet finishes castins aspell/ability pet_aftercast function
indi_change / ic              - gives information when indi changes in indi_change function
self_command / command/scom   - gives information when sending a command with 'gs c' self_command function
all                           - gives information in all gearswap functions

--------------------------------------------------------------------
What the Display can do for you-------------------------------------
1. you can enably and disable all includes on the fly(except for the display)
2. you can see you current job lvl with out opening any menus
3. you can see your current skill lvl on any skill (combat/magic/automation) with out opening a menu
4. you can just use a mouse click to adjust settings no need to type in any commands
5. you can build your own display in to the display for info you wat to show(advanced users only)

--------------------------------------------------------------------
To do---------------------------------------------------------------
thf tracker so you can change out thf knife for better gear once it procs

--------------------------------------------------------------------
Requests------------------------------------------------------------

if there is something you would like me to add please send me a note

--------------------------------------------------------------------
Special Thanks------------------------------------------------------

Mote --for helping me with code that was bugged

Arcon --for helping me learn more about lua in windower

Byrth -- for creating Gearswap and helping me with code that i could not figure out on my own

Anybody else i missed --thanks for the help

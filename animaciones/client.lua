local anims = {
-- [#] = {SHOWN ANIM CATO, SHOWN ANIM NAME, BLOCK, ANIM}
[0] = {"Dancing", "Ddance", "DANCING", "dnce_M_d"},
[1] = {"Dancing", "Edance", "DANCING", "dnce_M_e"},
[2] = {"Dancing", "Adance", "DANCING", "dnce_M_a"},
[3] = {"Dancing", "Bdance", "DANCING", "dnce_M_b"},
[4] = {"Dancing", "Clap", "DANCING", "bd_clap1"},
[5] = {"Dancing", "Lopdance", "DANCING", "DAN_Loop_A"},
[6] = {"Relaxing", "Sunbathe1", "BEACH", "ParkSit_W_loop"},
[7] = {"Relaxing", "Sunbathe2", "BEACH", "SitnWait_loop_W"},
[8] = {"Relaxing", "SleepL", "INT_HOUSE", "BED_Loop_L"},
[9] = {"Relaxing", "SleepR", "INT_HOUSE", "BED_Loop_R"},
[10] = {"Relaxing", "SmokeL", "SMOKING", "M_smkstnd_loop"},
[11] = {"Relaxing", "SmokeA", "SMOKING", "M_smk_in"},
[12] = {"Relaxing", "SitTalk", "MISC", "Seat_talk_01"},
[13] = {"Relaxing", "SitWatch", "INT_OFFICE", "OFF_Sit_Watch"},
[14] = {"Emergency", "Policetactic1", "SWAT", "swt_breach_02"},
[15] = {"Emergency", "Policetactic2", "SWAT", "swt_breach_01"},
[16] = {"Emergency", "Watchleft", "SWAT", "swt_wllpk_L"},
[17] = {"Emergency", "Watchright", "SWAT", "swt_wllpk_R"},
[18] = {"Emergency", "Breach", "GANGS", "shake_carK"},
[19] = {"Emergency", "CPR", "MEDIC", "CPR"},
[20] = {"Emergency", "Handsup", "ROB_BANK", "SHP_HandsUp_Scr"},
[21] = {"Emergency", "JumpCover", "DODGE", "Crush_Jump"},
[22] = {"Illegal", "Accept", "GANGS", "Invite_Yes"},
[23] = {"Illegal", "Reject", "Gangs", "Invite_No"},
[24] = {"Illegal", "Gangsign1", "GHANDS", "gsign4"},
[25] = {"Illegal", "Gangsign2", "GHANDS", "gsign2LH"},
[26] = {"Illegal", "Weedsmoke", "GANGS", "smkcig_prtl_F"},
[27] = {"Illegal", "Gangtalk", "GANGS", "prtial_gngtlkC"},
[28] = {"Illegal", "Dealeridle", "GANGS", "DEALER_IDLE"},
[29] = {"Illegal", "Gangrap", "RAPPING", "RAP_A_Loop"},
[30] = {"Illegal", "Laugh" , "Rapping", "Laugh_01"},
[31] = {"Food", "eatjunk", "FOOD", "EAT_Vomit_P"},
[32] = {"Food", "Eat1", "FOOD", "EAT_Chicken"},
[33] = {"Food", "Eat2", "FOOD", "EAT_Pizza"},
[34] = {"Food", "SitEat1", "FOOD", "FF_Sit_Eat1"},
[35] = {"Food", "SitEat2", "FOOD", "FF_Sit_Eat2"},
[36] = {"Death", "Wounded", "CRACK", "crckdeth4"},
[37] = {"Death", "Insensible", "CRACK", "crckidle2"},
[38] = {"Death", "Dead", "CRACK", "crckidle1"},
[39] = {"Robbing", "Cracksafe1", "ROB_BANK", "CAT_Safe_Open"},
[40] = {"Robbing", "Plantbomb", "BOMBER", "BOM_Plant"},
[41] = {"18+", "Strip1", "STRIP", "STR_C1"},
[42] = {"18+", "Strip2", "STRIP", "STR_C2"},
[43] = {"18+", "Piss", "PAULNMAC", "Piss_in"},
[43] = {"18+", "Piss", "PAULNMAC", "Piss_in"},
[44] = {"Funny", "Riinn", "CHOPPA", "CHOPPA_pedal"},
[45] = {"Funny", "Marcianito 100% real", "DANCING", "dnce_M_b"},
}

local AnimationWindow = guiCreateWindow(584,226,262,421,"Animaciones",false)
local stop = guiCreateButton(9,387,122,25,"Parar Animacion",false,AnimationWindow)
local close = guiCreateButton(133,387,120,25,"Cerrar Panel",false,AnimationWindow)
local animgrid = guiCreateGridList(9,22,244,358,false,AnimationWindow)
local column1 = guiGridListAddColumn(animgrid,"Categorias",0.35)
local column2 = guiGridListAddColumn(animgrid,"Animacion",0.5)

for i=0,#anims do
	local cato, name = anims[i][1], anims[i][2]
	local row = guiGridListAddRow ( animgrid )
	guiGridListSetItemText ( animgrid, row, column1, cato, false, false )
	guiGridListSetItemText ( animgrid, row, column2, name, false, false )
end

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(AnimationWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(AnimationWindow,x,y,false)

guiWindowSetMovable (AnimationWindow, true)
guiWindowSetSizable (AnimationWindow, false)
guiSetVisible (AnimationWindow, false)

function toggleAnimationWindow ()
	if (guiGetVisible(AnimationWindow)) then
		guiSetVisible(AnimationWindow, false)
		showCursor(false)
	else
		guiSetVisible(AnimationWindow, true)
		showCursor(true)
	end
end
bindKey("F7", "down", toggleAnimationWindow)
addEventHandler("onClientGUIClick", close, toggleAnimationWindow, false)

function sendAnim()
	local row, column = guiGridListGetSelectedItem ( animgrid )
	if ( row ) and ( column ) then
		local animsID = guiGridListGetItemText ( animgrid, row, column2 )
		if ( animsID ) and ( animsID ~= "" ) then
			local block, anim = anims[row][3], anims[row][4]
			if not isPedInVehicle(localPlayer) then
				triggerServerEvent("startAnim", localPlayer, tostring(block), tostring(anim))
			end
		end
	end
end
addEventHandler("onClientGUIDoubleClick", animgrid, sendAnim)

function stopAnim ()
	triggerServerEvent ("stopAnim", localPlayer)
end
addEventHandler("onClientGUIClick", stop, stopAnim, false)
addCommandHandler("stopanim", stopAnim)

function handsup ()
	if not isPedInVehicle(localPlayer) then
		triggerServerEvent("startAnim", localPlayer, "ped", "handsup")
	end
end
addCommandHandler("handsup", handsup)
addCommandHandler("hu", handsup)

addEvent ( "onPlayerArrest", true )
function onPlayerGetArrest ()
	if ( source == localPlayer ) then
		triggerServerEvent ("stopAnim", localPlayer)
	end
end
addEventHandler ( "onPlayerArrest", root, onPlayerGetArrest )

/*
	Created by AlexALX (c) 2012
	Small settings tab
	For some functions what come from my addon
*/

function StarGate_Settings(Panel)
	local LAYOUT = "Convars/Limits/Language";
	local GREEN = Color(0,255,0,255);
	local ORANGE = Color(255,128,0,255);
	local RED = Color(255,0,0,255);
	local DGREEN = Color(0,192,0,255);

	if (LocalPlayer():IsAdmin()) then
		local convarsmenu = vgui.Create("DButton", Panel);
	    convarsmenu:SetText(SGLanguage.GetMessage("stargate_settings_01"));
	    convarsmenu:SetSize(150, 25);
		convarsmenu.DoClick = function ( btn )
			RunConsoleCommand("stargate_cap_convars");
		end
		Panel:AddPanel(convarsmenu);
		local convarsmenu = vgui.Create("DButton", Panel);
	    convarsmenu:SetText(SGLanguage.GetMessage("stargate_settings_02"));
	    convarsmenu:SetSize(150, 25);
		convarsmenu.DoClick = function ( btn )
			RunConsoleCommand("stargate_system_convars");
		end
		Panel:AddPanel(convarsmenu);
	end
	Panel:Help("");
	Panel:Help(SGLanguage.GetMessage("stargate_settings_06")):SetTextColor(DGREEN);
	local clientlang = vgui.Create("DMultiChoice",Panel);
	clientlang:SetSize(50,20);
	clientlang:SetText(SGLanguage.GetClientLanguage());
	clientlang.TextEntry:SetTooltip(SGLanguage.GetMessage("stargate_settings_07"));
	clientlang.TextEntry.OnTextChanged = function(TextEntry)
		local pos = TextEntry:GetCaretPos();
		local text = TextEntry:GetValue();
		local len = text:len();
		local letters = text:lower():gsub("[^a-z]",""); -- Lower, remove invalid chars and split!
		TextEntry:SetText(letters);
		TextEntry:SetCaretPos(math.Clamp(pos - (len-letters:len()),0,text:len())); -- Reset the caretpos!
		if (letters!="") then SGLanguage.SetClientLanguage(letters); end
	end
	clientlang.OnSelect = function(panel,index,value)
		if (value!="") then SGLanguage.SetClientLanguage(value); end
	end
	-- add exists languages
	local langstext = "";
	local _,langs = file.Find("lua/data/language/*","GAME");
	for i,lang in pairs(langs) do
		if (i!=1) then langstext = langstext..", "; end
		langstext = langstext..lang
		clientlang:AddChoice(lang);
	end
	Panel:AddPanel(clientlang);
	Panel:Help(SGLanguage.GetMessage("stargate_settings_03")):SetTextColor(DGREEN);
	Panel:Help(langstext.."."):SetTextColor(DGREEN);
	Panel:Help(SGLanguage.GetMessage("stargate_settings_04"));
	Panel:Help("");
	Panel:Help(SGLanguage.GetMessage("stargate_settings_05"));
	Panel:Help("");
	Panel:Help(SGLanguage.GetMessage("stargate_settings_08"));

end
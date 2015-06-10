CreateClientConVar("emenu_enabled", 1, true, false)


local frame
local htmlframe
local console
local spanel
local gradient = Material("gui/gradient.vtf")

local buttony = 35
local bb = buttony * 1.3

local button_click_sound = Sound("ui/csgo_buttonclick.wav")
local button_hover_sound = Sound("ui/csgo_buttonrollover.wav")
     
local w, h = EMenu.Wide, EMenu.Height
surface.CreateFont("ecsgo_menu", { font = "Stratum2 Medium", size = bb-5, additive = false})
surface.CreateFont("ecsgo_button", { font = "Stratum2 Medium", size = buttony, additive = false})
surface.CreateFont("escgo_servertitle", { font = "Stratum2 Medium", size = 24, additive = false})
surface.CreateFont("escgo_serverdesc", { font = "Stratum2 Medium", size = 20, additive = false})
surface.CreateFont("escgo_disable", { font = "Stratum2 Medium", size = 16, additive = false})
concommand.Add("emenu_servers", function()
if not IsValid(frame) or not EMenu.ServerListEnabled then return end
if IsValid(htmlframe) or IsValid(console) then return end
if IsValid(spanel) then return end
	spanel = vgui.Create( "DPanel", frame )
	local dist = 100
	spanel:SetSize(w, h)
	spanel:SetPos(dist+w+10, ScrH() - (dist*1.5) - h)
	spanel.Paint = function(self)	
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRect( 0, 0, 1000, 400 )
		
		surface.SetDrawColor(150, 150, 150, 30)
		surface.DrawOutlinedRect( 0, 0, self:GetSize())
		
		surface.SetDrawColor( 52, 71, 91, 150 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRect( 0, 0, w, bb)
		
		surface.SetDrawColor( 52, 71, 91, 150 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRectRotated(w/2, bb/2, w, bb, 180)
		
		
		surface.SetDrawColor(150, 150, 150, 30)
		surface.DrawOutlinedRect( 0, 0, w, bb)
	end
	
	local menutitle = vgui.Create( "DLabel", spanel )
	menutitle:SetText("SERVERS")
	menutitle:SetFont("ecsgo_menu")
	menutitle:SizeToContents()
	menutitle:Center()
	local mt, _ = menutitle:GetPos()
	menutitle:SetPos(mt, 2)
	menutitle:SetColor(Color(68, 103, 138, 200))
	
	local scroll = vgui.Create( "DScrollPanel", spanel )
	scroll:SetSize(w-2+20, h-bb-4)
	scroll:SetPos(2, bb+2)

	local serverlist = vgui.Create( "DIconLayout", scroll )
	serverlist:SetSize(scroll:GetWide()-22, scroll:GetTall()-8)
	serverlist:SetPos(0, 5)
	serverlist:SetSpaceY(5) 
	serverlist:SetSpaceX(5) 
	
	for _, info in pairs(EMenu.Servers) do
		dpanel = serverlist:Add( "DPanel" )
		dpanel:SetSize( serverlist:GetWide(), 60 )
		dpanel.Paint = function(self)
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.SetMaterial( gradient )
			surface.DrawTexturedRect( 0, 0, self:GetSize() )
			
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.SetMaterial( gradient )
			surface.DrawTexturedRectRotated( self:GetWide()/2, self:GetTall()/2, self:GetWide(), self:GetTall(), 180 )
			
			surface.SetDrawColor(150, 150, 150, 30)
			surface.DrawOutlinedRect( 0, 0, self:GetSize())
		end
		local img = vgui.Create("DImage", dpanel)
		img:SetPos(5, 5)
		img:SetSize(50, 50)		
		img:SetImage(info.icon)
		
			local servertitle = vgui.Create( "DLabel", dpanel )
			servertitle:SetText(info.title)
			servertitle:SetFont("escgo_servertitle")
			servertitle:SizeToContents()
			servertitle:SetPos(60, 5)
			servertitle:SetColor(Color(200, 200, 200, 200))
			if info.titlecolor != nil then
				servertitle:SetColor(info.titlecolor)
			end
			local serverdesc = vgui.Create( "DLabel", dpanel )
			serverdesc:SetText(info.desc)
			serverdesc:SetFont("escgo_serverdesc")
			serverdesc:SizeToContents()
			serverdesc:SetPos(60, 30)
			serverdesc:SetColor(Color(200, 200, 200, 200))
			if info.desccolor != nil then
				serverdesc:SetColor(info.desccolor)
			end
		local hovered = nil
		local go = vgui.Create( "DButton", dpanel )
		go:SetSize(60, 60)
		go:SetPos(w-60, 0)
		go:SetText("")
		go.DoClick = function()
			LocalPlayer():ConCommand("connect "..info.ip)
			surface.PlaySound(button_click_sound)
		end
		go.Paint = function(self)
			if self.Depressed then
				surface.SetFont( "ecsgo_button" )
				surface.SetTextColor( 230, 230, 230, 255 )
				surface.SetTextPos((60-buttony)/2, (60-buttony)/2) 
				surface.DrawText("GO")
			elseif self.Hovered then
				surface.SetFont( "ecsgo_button" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos((60-buttony)/2, (60-buttony)/2) 
				surface.DrawText("GO")
			else
				surface.SetFont( "ecsgo_button" )
				surface.SetTextColor( 150, 150, 150, 255 )
				surface.SetTextPos((60-buttony)/2, (60-buttony)/2) 
				surface.DrawText("GO")
			end
		end

	end
end)

function emenu_OpenConsole()
	console = vgui.Create( "DFrame" )
	console:SetSize(400, 60)
	console:Center()
	console:SetTitle("CONSOLE")
	console:SetDraggable(false)
	console:ShowCloseButton(false)
	console:SetSizable(false)
	console.OnClose = function()
		console = nil
	end
	console.Paint = function()
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRect( 0, 0, console:GetSize() )
		
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRectRotated( console:GetWide()/2, console:GetTall()/2, console:GetWide(), console:GetTall(), 180 )
		 
		surface.SetDrawColor( 100, 100, 100, 200)
		surface.DrawOutlinedRect( 0, 0, console:GetSize() )
	end
	
	local TextEntry = vgui.Create( "DTextEntry", console )
	TextEntry:SetPos( 10, 25 )
	TextEntry:SetSize( 380, 25 )
	TextEntry:SetText( "PRESS 'ENTER' TO RUN COMMAND..." )
	TextEntry.OnEnter = function( self )
		LocalPlayer():ConCommand(self:GetValue())
	end
	console:MakePopup()
	
	console.Think = function()
		if not console:IsActive() then
			console:MakePopup()
		end
	end
end

function emenu_OpenHTML(func)
if IsValid(htmlframe) then return end
local scrw, scrh = ScrW(), ScrH()
local w, h = ScrW()*0.8, ScrH()*0.8
local html = func()
	htmlframe = vgui.Create( "DFrame" )
	htmlframe:SetSize(w, h)
	htmlframe:Center()
	htmlframe:SetTitle("")
	htmlframe:SetDraggable(false)
	htmlframe:ShowCloseButton(false)
	htmlframe:SetSizable(false)
	htmlframe:MakePopup()
	htmlframe.OnClose = function()
		htmlframe = nil
	end
	htmlframe.Paint = function()
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRect( 0, 0, htmlframe:GetSize() )
		
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRectRotated( htmlframe:GetWide()/2, htmlframe:GetTall()/2, htmlframe:GetWide(), htmlframe:GetTall(), 180 )
	end
	
	local htmlp = vgui.Create( "DHTML" , htmlframe )
	htmlp:SetPos(5, 5)
	htmlp:SetSize(w-15, h-60)
	htmlp:SetHTML(html)
	
	local but = vgui.Create( "DButton", htmlframe )
	but:SetSize(100, 30)
	but:SetText("Close")
	but.DoClick = function() htmlframe:Close() end
	but:SetPos(w/2-50, h-40)
end

function emenu_OpenUI()
local menucvar = GetConVar("emenu_enabled"):GetInt()
	frame = vgui.Create( "DFrame" )
	frame:SetSize(ScrW(), ScrH())
	frame:SetPos(0, 0)
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetSizable(false)
	frame.Paint = function(self) end
	
	frame.Think = function()
		
	end
	
	local panel = vgui.Create( "DPanel", frame)
	panel:SetSize(w, h)
	local dist = 100
	panel:SetPos(dist, ScrH() - (dist*1.5) - h)
	panel.Paint = function(self)
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRect( 0, 0, 1000, 400 )
		
		surface.SetDrawColor(150, 150, 150, 30)
		surface.DrawOutlinedRect( 0, 0, self:GetSize())
	end
	
	local anim = Derma_Anim("SlowlyAppears", panel, function(pnl, anim, delta, data)
		pnl:SetAlpha(255 * delta)
	end)
	
	panel.Think = function(self)
		if anim:Active() then
			anim:Run()
		end
	end
	anim:Start(0.25)
	
	frame.OnClose = function()
		frame = nil
	end
	
	local tpanel = vgui.Create( "DPanel", panel )
	tpanel:SetSize(w - 6, bb)
	tpanel:SetPos(3, 3)
	tpanel.Paint = function(self)
		surface.SetDrawColor( 52, 71, 91, 150 )
		surface.SetMaterial( gradient )
		surface.DrawTexturedRect( 0, 0, w + 10, 400 )
	end
	local menutitle = vgui.Create( "DLabel", tpanel )
	menutitle:SetText("MENU")
	menutitle:SetFont("ecsgo_menu")
	menutitle:SizeToContents()
	menutitle:Center()
	local _, mt = menutitle:GetPos()
	menutitle:SetPos(8, mt)
	menutitle:SetColor(Color(68, 103, 138, 200))
	
	local btbl = {}
	local d = 10
	for k, v in pairs(EMenu.Buttons) do
		btbl[v.title] = vgui.Create( "DButton", panel )
		local button = btbl[v.title]
		button:SetSize(w-10, buttony)
		button:SetPos(5, (bb+d+3) + (k*buttony + k*d) - buttony - d)
		button:SetText("")
		button.DoClick = function()
			if v.html == true then
				emenu_OpenHTML(v.func)
			else
				local result = v.func()
				if result == true then
					v.func()
				else
					v.func()
					surface.PlaySound(button_click_sound)
				end
			end
		end
		button.OnCursorEntered = function(self)
			surface.PlaySound(button_hover_sound)
		end
		button.Paint = function(self)
			if self.Depressed then
				surface.SetFont( "ecsgo_button" )
				surface.SetTextColor( 230, 230, 230, 255 )
				surface.SetTextPos(8, 0) 
				surface.DrawText(v.title)
				
				surface.SetDrawColor( 100, 100, 100, 100 )
				surface.SetMaterial( gradient )
				surface.DrawTexturedRect( 0, 0, self:GetSize() )
			elseif self.Hovered then
				surface.SetFont( "ecsgo_button" )
				surface.SetTextColor( 255, 255, 255, 255 )
				surface.SetTextPos(8, 0) 
				surface.DrawText(v.title)
				
				surface.SetDrawColor( 100, 100, 100, 100 )
				surface.SetMaterial( gradient )
				surface.DrawTexturedRect( 0, 0, self:GetSize() )
			else
				surface.SetFont( "ecsgo_button" )
				surface.SetTextColor( 150, 150, 150, 255 )
				surface.SetTextPos(8, 0) 
				surface.DrawText(v.title)
			end
		end
	
	
	end
	
	frame:MakePopup()
	local t = 0
	local ready = false
	local cvar_button = vgui.Create( "DButton", frame )
	cvar_button:SetPos( ScrW()-20, 0 )
	cvar_button:SetText( "" )
	cvar_button:SetSize( 20, 20 )
	
	local disable_label = vgui.Create( "DLabel", cvar_button )
	disable_label:SetText("Disable")
	disable_label:SetFont("escgo_disable")
	disable_label:SetAlpha(0)
	disable_label:SetPos(5, 0)
	disable_label:SetColor(Color(0, 0, 0))
	
	local anim = Derma_Anim("cvar_button_slide", main, function(pnl, anim, delta, data)
		local size = 4
		local dsize = size*delta
		local bsize = cvar_button:GetWide() + dsize
		cvar_button:SetSize(bsize, 20)
		cvar_button:SetPos(ScrW()-bsize, 0)
		disable_label:SetAlpha(255*delta)
		if delta == 1 then
			ready = true
		end
	end)
	cvar_button.Think = function(self)
		if anim:Active() then
			anim:Run()
		end
	end 

	cvar_button.DoClick = function()
		if t == 0 then 
			t = 1
			anim:Start(1)
		elseif ready then
			RunConsoleCommand("emenu_enabled", "0")
			frame:Close()
		end
	end
	cvar_button.Paint = function(self)
		if self.Hovered then
			surface.SetDrawColor(Color(210, 0, 0))
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall()*0.3)
			
			surface.SetDrawColor(Color(200, 0, 0))
			surface.DrawRect(0, 0, self:GetSize())
		else
			surface.SetDrawColor(Color(190, 0, 0))
			surface.DrawRect(0, 0, self:GetWide(), self:GetTall()*0.3)
		
			surface.SetDrawColor(Color(180, 0, 0))
			surface.DrawRect(0, 0, self:GetSize())
		end
	end
	if EMenu.ShowDisableButton == false then
		cvar_button:Remove()
	end

	concommand.Add("emenu_close", function(ply, _, arg)
		if IsValid(frame) then
			gui.HideGameUI()
			frame:Close()
			if arg[1] == "true" then
				surface.PlaySound("ui/csgo_ui_button_rollover_large.wav")
			end
		end
		if IsValid(console) then
			console:Close()
		end
	end)
end
  
hook.Add("PreRender", "emenu_render", function()
	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
		if IsValid(frame) then
			gui.HideGameUI()
			frame:Close()
			surface.PlaySound("ui/csgo_ui_button_rollover_large.wav")
		else
			if GetConVar("emenu_enabled"):GetInt() == 0 and EMenu.CanPlayerDisable then return end
			gui.HideGameUI()
			emenu_OpenUI()
			surface.PlaySound("ui/csgo_ui_button_rollover_large.wav")
		end
		if IsValid(console) then
			console:Close()
		end
	elseif input.IsKeyDown(KEY_BACKQUOTE) and gui.IsConsoleVisible() and EMenu.ConsoleDisabled then
		if GetConVar("emenu_enabled"):GetInt() == 0 and EMenu.CanPlayerDisable then return end
		gui.HideGameUI()
		if EMenu.CustomConsole == true then
			if IsValid(frame) then
				if not IsValid(console) then
					emenu_OpenConsole()
				end
			else
				emenu_OpenUI()
				if not IsValid(console) then
					emenu_OpenConsole()
				end
			end
		end
	end
end) 

concommand.Add("emenu_original", function()
	gui.ActivateGameUI()
end)


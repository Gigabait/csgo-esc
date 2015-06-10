
EMenu = {}

// http:// is neccesary
EMenu.Site = "http://google.com"

EMenu.Rules = "http://google.com"

EMenu.PSConCommand = "say", "!shop"


EMenu.ConsoleDisabled = false // false
EMenu.CustomConsole = false // false // Enables custom console field, if original disabled

EMenu.CanPlayerDisable = true // Allows player to disable custom menu
EMenu.ShowDisableButton = true // Set false if player can't disable

EMenu.ServerListEnabled = true
EMenu.Servers = {
 {title = "Trouble in Terrorist Town", ip = "127.0.1.1:27019", desc = "Remastered! HD", icon = "faction_mark.vtf", titlecolor = Color(200, 0, 0), desccolor = Color(150, 0, 0)},
 {title = "Murder", ip = "127.0.1.1:27019", desc = "Best Murder!", icon = "faction_mark.vtf", titlecolor = Color(51, 153, 255), desccolor = Color(0, 128, 255)},
 {title = "Zombie Survival", ip = "127.0.1.1:27019", desc = "Brains!!!", icon = "faction_mark.vtf"},
 {title = "Sandbox", ip = "127.0.1.1:27019", desc = "Build your own rocket!", icon = "faction_mark.vtf", desccolor = Color(0, 204, 0)}
}
EMenu.HTMLMotd = [[
	<h1 style = "font-family: Verdana; text-align: center; color: rgb(150, 150, 150)"> Welcome to our server, %s!</h1>
		<h3 style = "font-family: Verdana; text-align: center; color: rgb(150, 150, 150)"> Please, follow the rules and be respectful to another players.</h3>
		<h3 style = "font-family: Verdana; text-align: center; color: rgb(150, 150, 150)"> With much thanks, Administration. </h3>
			<h2 style = "font-family: Verdana; text-align: center; color: rgb(150, 150, 150)"> Have fun! </h2>
			<div style = "text-align: center"><img src = "http://www.welikeviral.com/files/2014/12/8325_8_site.jpeg" align = "middle" /> </div>
]]
---Buttons
if SERVER then return end
/*
 -----
 Table structure:
 {title = *, func = *, html = bool(true/false)}
 ----- 
 html example:
 { title = "Example", func = function()
	local htmltext = "<p> Test text </p>"	
	return htmltext
 end, html = true }
 -----
Close custom menu - RunConsoleCommand("emenu_close")
Open original menu - RunConsoleCommand("emenu_original")
Open server list - RunConsoleCommand("emenu_servers")
 -----
*/

EMenu.Wide = 400 //px
EMenu.Height = 370 //px

EMenu.Buttons = {
	{ title = "RESUME GAME", func = function() RunConsoleCommand("emenu_close", "true"); return true end },

	{ title = "MOTD", func = function() RunConsoleCommand("emenu_close") return Format(EMenu.HTMLMotd, LocalPlayer():Nick()) end, html = true },
	
	{ title = "BROWSE SERVERS", func = function() RunConsoleCommand("emenu_servers") end},
	
	{ title = "VISIT SITE", func = function() gui.OpenURL(EMenu.Site); RunConsoleCommand("emenu_close") end },
	
	{ title = "RULES", func = function() gui.OpenURL(EMenu.Rules); RunConsoleCommand("emenu_close") end },
	
	{ title = "POINTSHOP", func = function() RunConsoleCommand("emenu_close"); RunConsoleCommand(EMenu.PSConCommand);end },
	
	{ title = "EXIT TO MAIN MENU", func = function() RunConsoleCommand("disconnect") end }
}

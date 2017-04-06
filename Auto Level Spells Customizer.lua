class "AutoLevelSpells"

lol = 7.7
ver = 0.7

function AutoLevelSpells:__init()
	self:LoadSpellOrder()
	self:LoadMenu()
	Callback.Add("Tick", function() self:Tick() end)
end

function AutoLevelSpells:LoadSpellOrder()
	SpellOrder = {
		[1]= {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},  	-- QWE
		[2]= {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},	-- QEW
		[3]= {2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},	-- WQE
		[4]= {2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1},	-- WEQ
		[5]= {3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},	-- EWQ
		[6]= {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2}	-- EQW
	}
	
	DefaultSpellsOrders = {		
		["Aatrox"]          =   {2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["AurelionSol"]     =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Ahri"]            =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Akali"]           =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Alistar"]         =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Amumu"]           =   {2, 3, 1, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Anivia"]          =   {1, 3, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Annie"]           =   {2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Ashe"]            =   {1, 2, 1, 2, 3, 4, 1, 1, 2, 1, 4, 2, 2, 3, 3, 4, 3, 3},
		["Azir"]            =   {2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Bard"]            =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Blitzcrank"]      =   {1, 3, 2, 3, 2, 4, 3, 2, 3, 2, 4, 3, 2, 1, 1, 4, 1, 1},
		["Brand"]           =   {2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Braum"]           =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Caitlyn"]         =   {2, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Cassiopeia"]      =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Chogath"]         =   {3, 1, 2, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1},
		["Corki"]           =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 2, 3, 2, 4, 2, 2},
		["Darius"]          =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Diana"]           =   {2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["DrMundo"]         =   {2, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 3, 2, 2, 2, 2},
		["Draven"]          =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Ekko"]            =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Elise"]           =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Evelynn"]         =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Ezreal"]          =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["FiddleSticks"]    =   {2, 3, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Fiora"]           =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Fizz"]            =   {3, 1, 2, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},
		["Galio"]           =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 3, 3, 2, 2, 4, 3, 3},
		["Gnar"]            =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Gangplank"]       =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Garen"]           =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Gragas"]          =   {2, 3, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},
		["Graves"]          =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Hecarim"]         =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Heimerdinger"]    =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Illaoi"]          =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Irelia"]          =   {1, 3, 2, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1},
		["Janna"]           =   {3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},
		["JarvanIV"]        =   {3, 1, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Jax"]             =   {3, 2, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Jayce"]           =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Jinx"]            =   {1, 2, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Jhin"]            =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Kalista"]         =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Karma"]           =   {1, 3, 2, 1, 1, 4, 1, 3, 3, 1, 4, 3, 3, 2, 2, 4, 2, 2},
		["Karthus"]         =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Kassadin"]        =   {1, 2, 3, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Katarina"]        =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Kayle"]           =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Kennen"]          =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Khazix"]          =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Kindred"]         =   {2, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["KogMaw"]          =   {2, 3, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Leblanc"]         =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 3, 2, 3, 4, 3, 3},
		["LeeSin"]          =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Leona"]           =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Lissandra"]       =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Lucian"]          =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Lulu"]            =   {3, 2, 1, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Lux"]             =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Malphite"]        =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Malzahar"]        =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},
		["Maokai"]          =   {3, 1, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["MasterYi"]        =   {3, 1, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["MissFortune"]     =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["MonkeyKing"]      =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Mordekaiser"]     =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Morgana"]         =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Nami"]            =   {1, 2, 3, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1},
		["Nasus"]           =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 3, 2, 3, 4, 3, 3},
		["Nautilus"]        =   {2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1},
		["Nidalee"]         =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Nocturne"]        =   {2, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Nunu"]            =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Olaf"]            =   {1, 3, 2, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},
		["Orianna"]         =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Pantheon"]        =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 2, 3, 2, 4, 2, 2},
		["Poppy"]           =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Quinn"]           =   {3, 1, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Rammus"]          =   {2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["RekSai"]          =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Renekton"]        =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Rengar"]          =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Riven"]           =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Rumble"]          =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Ryze"]            =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Sejuani"]         =   {2, 1, 3, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Shaco"]           =   {2, 3, 1, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Shen"]            =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Shyvana"]         =   {2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Singed"]          =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Sion"]            =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Sivir"]           =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Skarner"]         =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Sona"]            =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Soraka"]          =   {1, 2, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Swain"]           =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Syndra"]          =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Taliyah"]         =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["TahmKench"]       =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Talon"]           =   {2, 3, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Taric"]           =   {3, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Teemo"]           =   {1, 3, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Thresh"]          =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Tristana"]        =   {3, 2, 1, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Trundle"]         =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Tryndamere"]      =   {1, 3, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["TwistedFate"]     =   {2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Twitch"]          =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 1, 2, 2},
		["Udyr"]            =   {1, 3, 2, 1, 1, 4, 1, 4, 1, 3, 3, 3, 3, 2, 4, 4, 4, 4},
		["Urgot"]           =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Varus"]           =   {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Vayne"]           =   {1, 2, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3},
		["Veigar"]          =   {1, 2, 3, 3, 1, 4, 1, 2, 1, 2, 4, 2, 2, 2, 3, 4, 3, 3},
		["Velkoz"]          =   {2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Vi"]              =   {2, 3, 1, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Viktor"]          =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2},
		["Vladimir"]        =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Volibear"]        =   {2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1},
		["Warwick"]         =   {2, 1, 3, 2, 1, 4, 2, 1, 2, 1, 4, 2, 1, 3, 3, 4, 3, 3},
		["Xerath"]          =   {1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["XinZhao"]         =   {2, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Yorick"]          =   {3, 2, 3, 1, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},
		["Zac"]             =   {2, 1, 3, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 3, 3, 4, 3, 3},
		["Zed"]             =   {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Ziggs"]           =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Zilean"]          =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Zyra"]            =   {1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
		["Yasuo"]           =   {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2}
	}	
end

function AutoLevelSpells:ToString(spellNum)
	local Key
	if  spellNum == 1 then
		Key = "Q"
	elseif spellNum == 2 then
		Key = "W"
	elseif spellNum == 3 then
		Key = "E"
	elseif spellNum == 4 then
		Key = "R"
	end
	return Key
end

function AutoLevelSpells:ToHK(spellNum)
	local HK
	if  spellNum == 1 then
		HK = HK_Q
	elseif spellNum == 2 then
		HK = HK_W
	elseif spellNum == 3 then
		HK = HK_E
	elseif spellNum == 4 then
		HK = HK_R
	end
	return HK
end

function AutoLevelSpells:LoadMenu()
	local MenuIcons			=	"http://vignette1.wikia.nocookie.net/getsetgames/images/8/82/Level_up_icon.png"
	local EnableIcons		=	"http://www.myiconfinder.com/uploads/iconsets/256-256-da4555b24380d442df41fc883fbe3411.png"
	local SequenceIcons		=	"http://www.swiftpcoptimizer.com/wp-content/uploads/2016/10/workflow.png"
	local lvlIcons			=	"https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Circle-icons-arrow-up.svg/600px-Circle-icons-arrow-up.svg.png"
	local RIcons			= 	"https://lh5.ggpht.com/PA3Hy0O1KPzWA4nnWgI5MKfunyNGR66iTO8kugvNir-n1Zdfzlxm_fYOX6_beQPq=w170"
	local HumanizerIcons		=	"https://www.leasevillenocredit.com/skin/frontend/rwd/shine/images/ppc-pay-per-click-icon.png"
	local InfoIcons			=	"https://i.stack.imgur.com/qOXqp.png"
	local Priority1			=	self:ToString(DefaultSpellsOrders[myHero.charName][1])
	local Priority2			=	self:ToString(DefaultSpellsOrders[myHero.charName][2])
	local firstMax			=	self:ToString(DefaultSpellsOrders[myHero.charName][7])
	local SecondMax			=	self:ToString(DefaultSpellsOrders[myHero.charName][12])
	local ThirdMax			=	self:ToString(DefaultSpellsOrders[myHero.charName][18])

	--Main Menu
	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Auto Level Spells: Customizer", leftIcon = MenuIcons})
	self.Menu:MenuElement({id = "UseAutoLvSpell", name = "Enable", value = false , leftIcon = EnableIcons })

	--Auto Menu
	self.Menu:MenuElement({type = MENU, id = "Auto", name = myHero.charName, leftIcon = "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/champion/"..myHero.charName..".png"})
	self.Menu.Auto:MenuElement({type = MENU, id = "SpellsOrder", name = "Spells Order", leftIcon = SequenceIcons})
	self.Menu.Auto.SpellsOrder:MenuElement({id = "spell1",name = "Priority 1st Max : ", key = string.byte("Q")})
	self.Menu.Auto.SpellsOrder:MenuElement({id = "spell2",name = "Priority 2nd Max : ", key = string.byte("W")})
	self.Menu.Auto.SpellsOrder:MenuElement({type = SPACE, name = "Recommend : Max "..firstMax.." > "..SecondMax.." > "..ThirdMax})
	self.Menu.Auto.SpellsOrder:MenuElement({id = "Recommend", name = "Use Recommend Spells Order", value = false})
	self.Menu.Auto:MenuElement({id = "Disablelvl1", name = "Disable on First Level", value = true, leftIcon = lvlIcons })
	self.Menu.Auto:MenuElement({id = "lvROnly", name = "Level R Spell Only", value = true, leftIcon = RIcons })
	self.Menu.Auto:MenuElement({id = "UseHumanizer", name = "Humanizer", value = true, leftIcon = HumanizerIcons})
	self.Menu.Auto:MenuElement({id = "Delay", name = "Adjust Level Spell for X second", value = 1, min = 0, max = 2.5, step = 0.1, leftIcon = HumanizerIcons})

	----Info Menu
	self.Menu:MenuElement({type = MENU, id = "info", name = "Script Info", leftIcon = InfoIcons })
	self.Menu.info:MenuElement({type = SPACE, name = "Script Version: "..ver})
	self.Menu.info:MenuElement({type = SPACE, name = "Support LoL: "..lol})
	self.Menu.info:MenuElement({type = SPACE, name = "Author: JarKao"})
	
	--config
	self.Menu.Auto.SpellsOrder.spell1:Key(string.byte(Priority1))
	self.Menu.Auto.SpellsOrder.spell2:Key(string.byte(Priority2))

end

function AutoLevelSpells:OrderSelect()
	local order
	if string.byte("Q") == self.Menu.Auto.SpellsOrder.spell1:Key() and string.byte("W") == self.Menu.Auto.SpellsOrder.spell2:Key() then
		order = 1 -- QWE
	elseif string.byte("Q") == self.Menu.Auto.SpellsOrder.spell1:Key() and string.byte("E") == self.Menu.Auto.SpellsOrder.spell2:Key() then
		order = 2 -- QEW
	elseif string.byte("W") == self.Menu.Auto.SpellsOrder.spell1:Key() and string.byte("Q") == self.Menu.Auto.SpellsOrder.spell2:Key() then
		order = 3 -- WQE
	elseif string.byte("W") == self.Menu.Auto.SpellsOrder.spell1:Key() and string.byte("E") == self.Menu.Auto.SpellsOrder.spell2:Key() then
		order = 4 -- WEQ
	elseif string.byte("E") == self.Menu.Auto.SpellsOrder.spell1:Key() and string.byte("W") == self.Menu.Auto.SpellsOrder.spell2:Key() then
		order = 5 -- EWQ
	elseif string.byte("E") == self.Menu.Auto.SpellsOrder.spell1:Key() and string.byte("Q") == self.Menu.Auto.SpellsOrder.spell2:Key() then
		order = 6 -- EQW
	else
		order = 0
	end
	return order
end

function AutoLevelSpells:Tick()
	if not self.Menu.UseAutoLvSpell:Value() then return end
	
	local level = myHero.levelData.lvl
	local levelpts = myHero.levelData.lvlPts
	if self.Menu.Auto.Disablelvl1:Value() and level <= 1 then return end
	
	if self.Menu.Auto.UseHumanizer:Value() then
		if self.Menu.Auto.lvROnly:Value() then
			if (level + 1 - levelpts) ==  (level == 6 or level == 11 or level == 16) then
				DelayAction(function()
					if self.Menu.Auto.lvROnly:Value() and (level + 1 - levelpts) ==  (level == 6 or level == 11 or level == 16) then
						Control.KeyDown(HK_LUS)
						Control.CastSpell(HK_R)
						Control.KeyUp(HK_LUS)	
					end
				end, self.Menu.Auto.Delay: Value())
			end
		elseif not self.Menu.Auto.lvROnly:Value() then
			if level >= 1 and levelpts >= 1 and (level + 1 - levelpts) then
				local order = self:OrderSelect()
				DelayAction(function()
					Control.KeyDown(HK_LUS)
					if order == 0 or self.Menu.Auto.SpellsOrder.Recommend:Value() then
						Control.CastSpell(self:ToHK(DefaultSpellsOrders[myHero.charName][(level + 1 - levelpts)]))
					else
						Control.CastSpell(self:ToHK(SpellOrder[order][(level + 1 - levelpts)]))
					end
					Control.KeyUp(HK_LUS)	
				end, self.Menu.Auto.Delay: Value())
			end
		end
	elseif not self.Menu.Auto.UseHumanizer:Value() then
		if self.Menu.Auto.lvROnly:Value() then
			if (level + 1 - levelpts) ==  (level == 6 or level == 11 or level == 16) then
				Control.KeyDown(HK_LUS)
				Control.CastSpell(HK_R)
				Control.KeyUp(HK_LUS)
			end
		elseif not self.Menu.Auto.lvROnly:Value() then
			if level >= 1 and levelpts >= 1 and (level + 1 - levelpts) then
				local order = self:OrderSelect()
				Control.KeyDown(HK_LUS)
				if order == 0 or self.Menu.Auto.SpellsOrder.Recommend:Value() then
					Control.CastSpell(self:ToHK(DefaultSpellsOrders[myHero.charName][(level + 1 - levelpts)]))
				else
					Control.CastSpell(self:ToHK(SpellOrder[order][(level + 1 - levelpts)]))
				end
				Control.KeyUp(HK_LUS)
			end
		end
	end
	
end

function OnLoad()
	AutoLevelSpells()
end

class "AutoLevelSpells"

lol = 7.7
ver = 0.8

function AutoLevelSpells:__init()
	currentLvPts = 0
	LvSpellTimer = nil
	self:LoadSpellOrder()
	self:LoadMenu()
	Callback.Add("Tick", function() self:Tick() end)
end

function AutoLevelSpells:LoadSpellOrder()
	SpellOrder = {
		[1]= {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},  	-- Order: Q>W>E>Q>Q (Max Q > W)
		[2]= {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},	-- Order: Q>E>W>Q>Q (Max Q > E)
		[3]= {1, 0, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},	-- Order: W>Q>E>W>W (Max W > Q)
		[4]= {1, 2, 0, 1, 1, 3, 1, 2, 1, 2, 3, 2, 2, 0, 0, 3, 0, 0},	-- Order: W>E>Q>W>W (Max W > E)
		[5]= {2, 1, 0, 2, 2, 3, 2, 1, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0},	-- Order: E>W>Q>E>E (Max E > W)
		[6]= {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1}		-- Order: E>Q>W>E>E (Max E > Q)
	}
	
	DefaultSpellsOrders = {		
		["Aatrox"]          =   {1, 0, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["AurelionSol"]     =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Ahri"]            =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Akali"]           =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Alistar"]         =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Amumu"]           =   {1, 2, 0, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Anivia"]          =   {0, 2, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Annie"]           =   {1, 0, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Ashe"]            =   {0, 1, 0, 1, 2, 3, 0, 0, 1, 0, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Azir"]            =   {1, 0, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Bard"]            =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Blitzcrank"]      =   {0, 2, 1, 2, 1, 3, 2, 1, 2, 1, 3, 2, 1, 0, 0, 3, 0, 0},
        ["Brand"]           =   {1, 0, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Braum"]           =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Caitlyn"]         =   {1, 0, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Cassiopeia"]      =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Chogath"]         =   {2, 0, 1, 1, 1, 3, 1, 2, 1, 2, 3, 2, 2, 0, 0, 3, 0, 0},
        ["Corki"]           =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 1, 2, 1, 3, 1, 1},
        ["Darius"]          =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Diana"]           =   {1, 0, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["DrMundo"]         =   {1, 0, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 2, 1, 1, 1, 1},
        ["Draven"]          =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Ekko"]            =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Elise"]           =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Evelynn"]         =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Ezreal"]          =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["FiddleSticks"]    =   {1, 2, 0, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Fiora"]           =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Fizz"]            =   {2, 0, 1, 2, 2, 3, 2, 1, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0},
        ["Galio"]           =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 2, 2, 1, 1, 3, 2, 2},
        ["Gnar"]            =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Gangplank"]       =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Garen"]           =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Gragas"]          =   {1, 2, 0, 2, 2, 3, 2, 1, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0},
        ["Graves"]          =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Hecarim"]         =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Heimerdinger"]    =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Illaoi"]          =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Irelia"]          =   {0, 2, 1, 1, 1, 3, 1, 2, 1, 2, 3, 2, 2, 0, 0, 3, 0, 0},
        ["Janna"]           =   {2, 1, 0, 2, 2, 3, 2, 1, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0},
        ["JarvanIV"]        =   {2, 0, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Jax"]             =   {2, 1, 0, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Jayce"]           =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Jinx"]            =   {0, 1, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Jhin"]            =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Kalista"]         =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Karma"]           =   {0, 2, 1, 0, 0, 3, 0, 2, 2, 0, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Karthus"]         =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Kassadin"]        =   {0, 1, 2, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Katarina"]        =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Kayle"]           =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Kennen"]          =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Khazix"]          =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Kindred"]         =   {1, 0, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["KogMaw"]          =   {1, 2, 0, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Leblanc"]         =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 2, 1, 2, 3, 2, 2},
        ["LeeSin"]          =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Leona"]           =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Lissandra"]       =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Lucian"]          =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Lulu"]            =   {2, 1, 0, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Lux"]             =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Malphite"]        =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Malzahar"]        =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0},
        ["Maokai"]          =   {2, 0, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["MasterYi"]        =   {2, 0, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["MissFortune"]     =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["MonkeyKing"]      =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Mordekaiser"]     =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Morgana"]         =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Nami"]            =   {0, 1, 2, 1, 1, 3, 1, 2, 1, 2, 3, 2, 2, 0, 0, 3, 0, 0},
        ["Nasus"]           =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 2, 1, 2, 3, 2, 2},
        ["Nautilus"]        =   {1, 2, 0, 1, 1, 3, 1, 2, 1, 2, 3, 2, 2, 0, 0, 3, 0, 0},
        ["Nidalee"]         =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Nocturne"]        =   {1, 0, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Nunu"]            =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Olaf"]            =   {0, 2, 1, 2, 2, 3, 2, 1, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0},
        ["Orianna"]         =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Pantheon"]        =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 1, 2, 1, 3, 1, 1},
        ["Poppy"]           =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Quinn"]           =   {2, 0, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Rammus"]          =   {1, 0, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["RekSai"]          =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Renekton"]        =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Rengar"]          =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Riven"]           =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Rumble"]          =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Ryze"]            =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Sejuani"]         =   {1, 0, 2, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Shaco"]           =   {1, 2, 0, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Shen"]            =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Shyvana"]         =   {1, 0, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Singed"]          =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Sion"]            =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Sivir"]           =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Skarner"]         =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Sona"]            =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Soraka"]          =   {0, 1, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Swain"]           =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Syndra"]          =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Taliyah"]         =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["TahmKench"]       =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Talon"]           =   {1, 2, 0, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Taric"]           =   {2, 0, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Teemo"]           =   {0, 2, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Thresh"]          =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Tristana"]        =   {2, 1, 0, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Trundle"]         =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Tryndamere"]      =   {0, 2, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["TwistedFate"]     =   {1, 0, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Twitch"]          =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 0, 1, 1},
        ["Udyr"]            =   {0, 2, 1, 0, 0, 3, 0, 3, 0, 2, 2, 2, 2, 1, 3, 3, 3, 3},
        ["Urgot"]           =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Varus"]           =   {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Vayne"]           =   {0, 1, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2},
        ["Veigar"]          =   {0, 1, 2, 2, 0, 3, 0, 1, 0, 1, 3, 1, 1, 1, 2, 3, 2, 2},
        ["Velkoz"]          =   {1, 0, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Vi"]              =   {1, 2, 0, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Viktor"]          =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1},
        ["Vladimir"]        =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Volibear"]        =   {1, 2, 0, 1, 1, 3, 1, 2, 1, 2, 3, 2, 2, 0, 0, 3, 0, 0},
        ["Warwick"]         =   {1, 0, 2, 1, 0, 3, 1, 0, 1, 0, 3, 1, 0, 2, 2, 3, 2, 2},
        ["Xerath"]          =   {0, 2, 1, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["XinZhao"]         =   {1, 0, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Yorick"]          =   {2, 1, 2, 0, 2, 3, 2, 1, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0},
        ["Zac"]             =   {1, 0, 2, 2, 2, 3, 2, 1, 2, 1, 3, 1, 1, 2, 2, 3, 2, 2},
        ["Zed"]             =   {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Ziggs"]           =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Zilean"]          =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Zyra"]            =   {0, 1, 2, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1},
        ["Yasuo"]           =   {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1}
}	
end

function AutoLevelSpells:ToString(spellNum)
	local Key
	if  spellNum == 0 then
		Key = "Q"
	elseif spellNum == 1 then
		Key = "W"
	elseif spellNum == 2 then
		Key = "E"
	elseif spellNum == 3 then
		Key = "R"
	end
	return Key
end

function AutoLevelSpells:ToHK(spellNum)
	local HK
	if  spellNum == 0 then
		HK = HK_Q
	elseif spellNum == 1 then
		HK = HK_W
	elseif spellNum == 2 then
		HK = HK_E
	elseif spellNum == 3 then
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
	local HumanizerIcons	=	"https://www.leasevillenocredit.com/skin/frontend/rwd/shine/images/ppc-pay-per-click-icon.png"
	local InfoIcons			=	"https://i.stack.imgur.com/qOXqp.png"
	local order1			=	self:ToString(DefaultSpellsOrders[myHero.charName][1])
	local order2			=	self:ToString(DefaultSpellsOrders[myHero.charName][2])
	local order3			=	self:ToString(DefaultSpellsOrders[myHero.charName][3])
	local order4			=	self:ToString(DefaultSpellsOrders[myHero.charName][4])
	local order5			=	self:ToString(DefaultSpellsOrders[myHero.charName][5])

	--Main Menu
	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Auto Level Spells: Customizer", leftIcon = MenuIcons})
	self.Menu:MenuElement({id = "UseAutoLvSpell", name = "Enable", value = false , leftIcon = EnableIcons })

	--Auto Menu
	self.Menu:MenuElement({type = MENU, id = "Auto", name = myHero.charName, leftIcon = "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/champion/"..myHero.charName..".png"})
	self.Menu.Auto:MenuElement({type = MENU, id = "SpellsOrder", name = "Spells Order", leftIcon = SequenceIcons})
	self.Menu.Auto.SpellsOrder:MenuElement({id = "spell1",name = "Priority 1st Max : ", key = string.byte("Q")})
	self.Menu.Auto.SpellsOrder:MenuElement({id = "spell2",name = "Priority 2nd Max : ", key = string.byte("W")})
	self.Menu.Auto.SpellsOrder:MenuElement({type = SPACE, name = "Recommend : "..order1..">"..order2..">"..order3..">"..order4..">"..order5})
	self.Menu.Auto.SpellsOrder:MenuElement({id = "Recommend", name = "Use Recommend Spells Order", value = false})
	self.Menu.Auto:MenuElement({id = "Start", name = "Start Above Level X", value = 2, min = 1, max = 18, step = 1, leftIcon = lvlIcons })
	self.Menu.Auto:MenuElement({id = "lvROnly", name = "R Spell Only", value = true, leftIcon = RIcons })
	self.Menu.Auto:MenuElement({id = "Delay", name = "Level Up Delay For X Second", value = 1, min = 0, max = 2.5, step = 0.1, leftIcon = HumanizerIcons})

	----Info Menu
	self.Menu:MenuElement({type = MENU, id = "info", name = "Script Info", leftIcon = InfoIcons })
	self.Menu.info:MenuElement({type = SPACE, name = "Script Version: "..ver})
	self.Menu.info:MenuElement({type = SPACE, name = "Support LoL: "..lol})
	self.Menu.info:MenuElement({type = SPACE, name = "Author: JarKao"})
	
	--config
	self.Menu.Auto.SpellsOrder.spell1:Key(string.byte(order1))
	self.Menu.Auto.SpellsOrder.spell2:Key(string.byte(order2))

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

function AutoLevelSpells:ForceQWE()
	if self.Menu.Auto.SpellsOrder.spell1:Key() ~= string.byte("Q") and self.Menu.Auto.SpellsOrder.spell1:Key() ~= string.byte("W") and self.Menu.Auto.SpellsOrder.spell1:Key() ~= string.byte("E") and self.Menu.Auto.SpellsOrder.spell1:Key() ~= -1 then
		self.Menu.Auto.SpellsOrder.spell1:Key(string.byte("Q"))
	elseif self.Menu.Auto.SpellsOrder.spell2:Key() ~= string.byte("Q") and self.Menu.Auto.SpellsOrder.spell2:Key() ~= string.byte("W") and self.Menu.Auto.SpellsOrder.spell2:Key() ~= string.byte("E") and self.Menu.Auto.SpellsOrder.spell2:Key() ~= -1 then
		self.Menu.Auto.SpellsOrder.spell2:Key(string.byte("W"))
	elseif self.Menu.Auto.SpellsOrder.spell1:Key() == self.Menu.Auto.SpellsOrder.spell2:Key() then
		if self.Menu.Auto.SpellsOrder.spell1:Key() == string.byte("Q") then
			self.Menu.Auto.SpellsOrder.spell2:Key(string.byte("E"))
		elseif self.Menu.Auto.SpellsOrder.spell1:Key() == string.byte("W") then
			self.Menu.Auto.SpellsOrder.spell2:Key(string.byte("Q"))
		elseif self.Menu.Auto.SpellsOrder.spell1:Key() == string.byte("E") then
			self.Menu.Auto.SpellsOrder.spell2:Key(string.byte("Q"))
		end
	end
end

function AutoLevelSpells:Tick()
	if not self.Menu.UseAutoLvSpell:Value() then return end
	
	self:ForceQWE()
	
	local level = myHero.levelData.lvl
	local levelpts = myHero.levelData.lvlPts
	
	if level < self.Menu.Auto.Start:Value() then return end
	
	if levelpts ~= currentLvPts then
		currentLvPts = levelpts
		LvSpellTimer = Game.Timer()
	end
	
	if self.Menu.Auto.lvROnly:Value() then
		if (level + 1 - levelpts) ==  6 or (level + 1 - levelpts) == 11 or (level + 1 - levelpts) == 16 then
			if Game.Timer() > LvSpellTimer + self.Menu.Auto.Delay: Value() then
				Control.KeyDown(HK_LUS)
				Control.CastSpell(HK_R)
				Control.KeyUp(HK_LUS)	
			end	
		end
	elseif not self.Menu.Auto.lvROnly:Value() then
		if level >= 1 and levelpts >= 1 then
			local order = self:OrderSelect()
			if Game.Timer() > LvSpellTimer + self.Menu.Auto.Delay: Value() then
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

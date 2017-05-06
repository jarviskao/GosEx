class "AutoLevelSpells"

lol = 7.9
ver = 1.0

function AutoLevelSpells:__init()
	currentLvPts = 0
	LvSpellTimer = nil
	self:LoadSpellOrder()
	self:LoadMenu()
	Callback.Add("Tick", function() self:Tick() end)
end

function AutoLevelSpells:LoadSpellOrder()
	-- 1 is "Q", 2 is "W", 3 is "E", 4 is "R"
	DefaultOrders = {		
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
        ["Rakan"]           =   {3, 2, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1},
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
        ["Xayah"]         	=   {1, 3, 2, 1, 1, 4, 3, 1, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2},
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
	local spells = {"Q", "W", "E", "R"}
	return spells[spellNum]
end

function AutoLevelSpells:ToHK(spellNum)
	local HK = {HK_Q, HK_W, HK_E, HK_R}
	return HK[spellNum]
end

function AutoLevelSpells:LoadMenu()
	local MenuIcons			=	"https://lh3.ggpht.com/N6pVC84qnooEsOCJ15dijaOIfiZwBi1t0z6IDwczm_xKO1E_y9NGaogv5jhjQDx3YRIF=w300"
	local EnableIcons		=	"http://www.myiconfinder.com/uploads/iconsets/256-256-da4555b24380d442df41fc883fbe3411.png"
	local SequenceIcons		=	"http://www.basistechnologies.com/sites/default/files/04_Sequence.png"
	local lvlIcons			=	"http://plainicon.com/download-icons/54895/plainicon.com-54895-a56c-512px.png"
	local HumanizerIcons	=	"https://cdn4.iconfinder.com/data/icons/small-n-flat/24/clock-128.png"
	local KeyQ				= 	"http://www.mobafire.com/images/key-q.png"
	local KeyW				= 	"http://www.mobafire.com/images/key-w.png"
	local KeyE				= 	"http://www.mobafire.com/images/key-e.png"
	local KeyR				= 	"http://www.mobafire.com/images/key-r.png"
	local DefaultIcons		=	"http://findicons.com/files/icons/1700/2d/512/star.png"
	local order = {}
	for i = 1, 8 do
		order[i] = self:ToString(DefaultOrders[myHero.charName][i])
	end
	--Main Menu
	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Auto Level Spells: Customizer", leftIcon = MenuIcons})
	self.Menu:MenuElement({id = "UseAutoLvSpell", name = "Enable", value = true , leftIcon = EnableIcons })
	--Main Menu --Spells Order
	self.Menu:MenuElement({type = MENU, id = "SpellsOrder", name = "Spells Order", leftIcon = SequenceIcons})
	--Main Menu --Spells Order -- Q
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "Q", name = " Q First", leftIcon = KeyQ})
	self.Menu.SpellsOrder.Q:MenuElement({id = "QW", name = "Q > W > E > Q > Q (Max Q > W)", value = false, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)  
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)  
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false) end})
	self.Menu.SpellsOrder.Q:MenuElement({id = "QE", name = "Q > E > W > Q > Q (Max Q > E)", value = false, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QW:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)  
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)  
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false) end})
	--Main Menu --Spells Order -- W
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "W", name = " W First", leftIcon = KeyW})
	self.Menu.SpellsOrder.W:MenuElement({id = "WQ", name = "W > Q > E > W > W (Max W > Q)", value = false, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.Q.QW:Value(false)  
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)  
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false) end})
	self.Menu.SpellsOrder.W:MenuElement({id = "WE", name = "W > E > Q > W > W (Max W > E)", value = false, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)  
				self.Menu.SpellsOrder.Q.QW:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)  
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false) end})
	--Main Menu --Spells Order -- E
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "E", name = " E First", leftIcon = KeyE})
	self.Menu.SpellsOrder.E:MenuElement({id = "EQ", name = "E > Q > W > E > E (Max E > Q)", value = false, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)  
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.Q.QW:Value(false)  
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false) end})
	self.Menu.SpellsOrder.E:MenuElement({id = "EW", name = "E > W > Q > E > E (Max E > W)", value = false, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)  
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)  
				self.Menu.SpellsOrder.Q.QW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false) end})
	--Main Menu --Spells Order -- R
	self.Menu.SpellsOrder:MenuElement({id = "ROnly", name = " R Only", value = false, leftIcon = KeyR, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)  
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)  
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.Q.QW:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false) end})
	--Main Menu --Spells Order -- Recommend
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "Default", name = myHero.charName.." - Default", leftIcon = DefaultIcons})
	self.Menu.SpellsOrder.Default:MenuElement({id = "Order", name = order[1].." > "..order[2].." > "..order[3].." > "..order[4].." > "..order[5].." > "..order[6].." > "..order[7].." > "..order[8], value = false, onclick = 
	function() 	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)  
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)  
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Q.QW:Value(false) end})
	--Main Menu --Spells Order
	self.Menu:MenuElement({id = "Start", name = "Start Above Level", value = 2, min = 1, max = 18, step = 1, leftIcon = lvlIcons })
	self.Menu:MenuElement({id = "Delay", name = "Level Up Spell Delay (seconds)", value = 0.8, min = 0, max = 2.5, step = 0.1, leftIcon = HumanizerIcons})
end


function AutoLevelSpells:OrderSelected()
	if self.Menu.SpellsOrder.Q.QW:Value() then
		SpellOrder = {1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3}  	-- Order: Q>W>E>Q>Q (Max Q > W)
	elseif self.Menu.SpellsOrder.Q.QE:Value() then
		SpellOrder = {1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2}		-- Order: Q>E>W>Q>Q (Max Q > E)
	elseif self.Menu.SpellsOrder.W.WQ:Value() then
		SpellOrder = {2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3}		-- Order: W>Q>E>W>W (Max W > Q)
	elseif self.Menu.SpellsOrder.W.WE:Value() then
		SpellOrder = {2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1}		-- Order: W>E>Q>W>W (Max W > E)
	elseif self.Menu.SpellsOrder.E.EQ:Value() then
		SpellOrder = {3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2}		-- Order: E>Q>W>E>E (Max E > Q)
	elseif self.Menu.SpellsOrder.E.EW:Value() then
		SpellOrder = {3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1}		-- Order: E>W>Q>E>E (Max E > W)
	else
		SpellOrder = nil
	end
end

function AutoLevelSpells:Tick()

	if not self.Menu.UseAutoLvSpell:Value() then return end
	
	if not self.Menu.SpellsOrder.Q.QW:Value() and not self.Menu.SpellsOrder.Q.QE:Value() and not self.Menu.SpellsOrder.W.WQ:Value() and not self.Menu.SpellsOrder.W.WE:Value() and not self.Menu.SpellsOrder.E.EQ:Value() and not self.Menu.SpellsOrder.E.EW:Value() and not self.Menu.SpellsOrder.ROnly:Value() and not  self.Menu.SpellsOrder.Default.Order:Value() then return end
	
	local level = myHero.levelData.lvl
	local levelpts = myHero.levelData.lvlPts
	
	if level < self.Menu.Start:Value() then return end
	
	if levelpts ~= currentLvPts then
		currentLvPts = levelpts
		LvSpellTimer = Game.Timer()
	end
	
	if self.Menu.SpellsOrder.ROnly:Value() then
		if (level + 1 - levelpts) ==  6 or (level + 1 - levelpts) == 11 or (level + 1 - levelpts) == 16 then
			if Game.Timer() > LvSpellTimer + self.Menu.Delay: Value() then
				Control.KeyDown(HK_LUS)
				Control.CastSpell(HK_R)
				Control.KeyUp(HK_LUS)	
			end	
		end
	elseif not self.Menu.SpellsOrder.ROnly:Value() then
		if level >= 1 and levelpts >= 1 then
			if Game.Timer() > LvSpellTimer + self.Menu.Delay: Value() then
				self:OrderSelected()
				Control.KeyDown(HK_LUS)
				if self.Menu.SpellsOrder.Default.Order:Value() then
					Control.CastSpell(self:ToHK(DefaultOrders[myHero.charName][(level + 1 - levelpts)]))
				elseif SpellOrder ~= nil then
					Control.CastSpell(self:ToHK(SpellOrder[(level + 1 - levelpts)]))
				end				
				Control.KeyUp(HK_LUS)	
			end
		end
	end

end

function OnLoad()
	AutoLevelSpells()
end

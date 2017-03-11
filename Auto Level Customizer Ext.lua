	local DefaultSpellsOrders = {		
		["Aatrox"]          =   {HK_W, HK_Q, HK_E, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["AurelionSol"]     =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Ahri"]            =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_W, HK_W},
        ["Akali"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Alistar"]         =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Amumu"]           =   {HK_W, HK_E, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Anivia"]          =   {HK_Q, HK_E, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Annie"]           =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Ashe"]            =   {HK_Q, HK_W, HK_Q, HK_W, HK_E, HK_R, HK_Q, HK_Q, HK_W, HK_Q, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Azir"]            =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Bard"]            =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Blitzcrank"]      =   {HK_Q, HK_E, HK_W, HK_E, HK_W, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Brand"]           =   {HK_W, HK_Q, HK_E, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Braum"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Caitlyn"]         =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Cassiopeia"]      =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Chogath"]         =   {HK_E, HK_Q, HK_W, HK_W, HK_W, HK_R, HK_W, HK_E, HK_W, HK_E, HK_R, HK_E, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Corki"]           =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W},
        ["Darius"]          =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Diana"]           =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["DrMundo"]         =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_E, HK_W, HK_W, HK_W, HK_W},
        ["Draven"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Ekko"]            =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Elise"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Evelynn"]         =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Ezreal"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["FiddleSticks"]    =   {HK_W, HK_E, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Fiora"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Fizz"]            =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Galio"]           =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_E, HK_E},
        ["Gnar"]            =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Gangplank"]       =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Garen"]           =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Gragas"]          =   {HK_W, HK_E, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Graves"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Hecarim"]         =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Heimerdinger"]    =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Illaoi"]          =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Irelia"]          =   {HK_Q, HK_E, HK_W, HK_W, HK_W, HK_R, HK_W, HK_E, HK_W, HK_E, HK_R, HK_E, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Janna"]           =   {HK_E, HK_W, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["JarvanIV"]        =   {HK_E, HK_Q, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Jax"]             =   {HK_E, HK_W, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Jayce"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Jinx"]            =   {HK_Q, HK_W, HK_E, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Jhin"]            =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Kalista"]         =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Karma"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_E, HK_Q, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Karthus"]         =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Kassadin"]        =   {HK_Q, HK_W, HK_E, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Katarina"]        =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Kayle"]           =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Kennen"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Khazix"]          =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Kindred"]         =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["KogMaw"]          =   {HK_W, HK_E, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Leblanc"]         =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_E, HK_W, HK_E, HK_R, HK_E, HK_E},
        ["LeeSin"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Leona"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Lissandra"]       =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Lucian"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Lulu"]            =   {HK_E, HK_W, HK_Q, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Lux"]             =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Malphite"]        =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Malzahar"]        =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_W, HK_R, HK_W, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Maokai"]          =   {HK_E, HK_Q, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["MasterYi"]        =   {HK_E, HK_Q, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["MissFortune"]     =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["MonkeyKing"]      =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Mordekaiser"]     =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Morgana"]         =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Nami"]            =   {HK_Q, HK_W, HK_E, HK_W, HK_W, HK_R, HK_W, HK_E, HK_W, HK_E, HK_R, HK_E, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Nasus"]           =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_E, HK_W, HK_E, HK_R, HK_E, HK_E},
        ["Nautilus"]        =   {HK_W, HK_E, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_E, HK_W, HK_E, HK_R, HK_E, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Nidalee"]         =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Nocturne"]        =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Nunu"]            =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Olaf"]            =   {HK_Q, HK_E, HK_W, HK_E, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Orianna"]         =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Pantheon"]        =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W},
        ["Poppy"]           =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Quinn"]           =   {HK_E, HK_Q, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Rammus"]          =   {HK_W, HK_Q, HK_E, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["RekSai"]          =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Renekton"]        =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Rengar"]          =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Riven"]           =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Rumble"]          =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Ryze"]            =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Sejuani"]         =   {HK_W, HK_Q, HK_E, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Shaco"]           =   {HK_W, HK_E, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Shen"]            =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Shyvana"]         =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Singed"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Sion"]            =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Sivir"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Skarner"]         =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Sona"]            =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Soraka"]          =   {HK_Q, HK_W, HK_E, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Swain"]           =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Syndra"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Taliyah"]         =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["TahmKench"]       =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Talon"]           =   {HK_W, HK_E, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Taric"]           =   {HK_E, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Teemo"]           =   {HK_Q, HK_E, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Thresh"]          =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Tristana"]        =   {HK_E, HK_W, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Trundle"]         =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Tryndamere"]      =   {HK_Q, HK_E, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["TwistedFate"]     =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Twitch"]          =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_Q, HK_W, HK_W},
        ["Udyr"]            =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_R, HK_Q, HK_E, HK_E, HK_E, HK_E, HK_W, HK_R, HK_R, HK_R, HK_R},
        ["Urgot"]           =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Varus"]           =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Vayne"]           =   {HK_Q, HK_W, HK_E, HK_W, HK_W, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_Q, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Veigar"]          =   {HK_Q, HK_W, HK_E, HK_E, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_W, HK_E, HK_R, HK_E, HK_E},
        ["Velkoz"]          =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Vi"]              =   {HK_W, HK_E, HK_Q, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Viktor"]          =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Vladimir"]        =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Volibear"]        =   {HK_W, HK_E, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_E, HK_W, HK_E, HK_R, HK_E, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Warwick"]         =   {HK_W, HK_Q, HK_E, HK_W, HK_Q, HK_R, HK_W, HK_Q, HK_W, HK_Q, HK_R, HK_W, HK_Q, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Xerath"]          =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_W, HK_Q, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["XinZhao"]         =   {HK_W, HK_Q, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Yorick"]          =   {HK_E, HK_W, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_Q},
        ["Zac"]             =   {HK_W, HK_Q, HK_E, HK_E, HK_E, HK_R, HK_E, HK_W, HK_E, HK_W, HK_R, HK_W, HK_W, HK_E, HK_E, HK_R, HK_E, HK_E},
        ["Zed"]             =   {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Ziggs"]           =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Zilean"]          =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Zyra"]            =   {HK_Q, HK_W, HK_E, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W},
        ["Yasuo"]           =   {HK_E, HK_Q, HK_W, HK_E, HK_E, HK_R, HK_E, HK_Q, HK_E, HK_Q, HK_R, HK_Q, HK_Q, HK_W, HK_W, HK_R, HK_W, HK_W}
    }

	local support = false
	for key,value in pairs(DefaultSpellsOrders) do
		if myHero.charName == key then
			support = true
		end
	end
	
	if not support then return end
	
	--local
	local lol = 7.5
	local ver = 1.0
	local tickCount = 0
	local sequence = 0
	
	PrintChat ("[Auto Level Spell]  Loaded : "..myHero.charName.." || Version: "..ver," ", "|| LoL Support : "..lol)

local SpellsSequence = {
    [1]= { HK_Q,HK_W,HK_E,HK_Q,HK_Q,HK_R,HK_Q,HK_W,HK_Q,HK_W,HK_R,HK_W,HK_W,HK_E,HK_E,HK_R,HK_E,HK_E},  -- QWE
    [2]= { HK_Q,HK_W,HK_E,HK_Q,HK_Q,HK_R,HK_Q,HK_E,HK_Q,HK_E,HK_R,HK_E,HK_E,HK_W,HK_W,HK_R,HK_W,HK_W},	-- QEW
    [3]= { HK_W,HK_E,HK_Q,HK_W,HK_W,HK_R,HK_W,HK_Q,HK_W,HK_Q,HK_R,HK_Q,HK_Q,HK_E,HK_E,HK_R,HK_E,HK_E},	-- WQE
    [4]= { HK_W,HK_E,HK_Q,HK_W,HK_W,HK_R,HK_W,HK_E,HK_W,HK_E,HK_R,HK_E,HK_E,HK_Q,HK_Q,HK_R,HK_Q,HK_Q},	-- WEQ
    [5]= { HK_E,HK_Q,HK_W,HK_E,HK_E,HK_R,HK_E,HK_W,HK_E,HK_W,HK_R,HK_W,HK_W,HK_Q,HK_Q,HK_R,HK_Q,HK_Q},	-- EWQ
    [6]= { HK_E,HK_Q,HK_W,HK_E,HK_E,HK_R,HK_E,HK_Q,HK_E,HK_Q,HK_R,HK_Q,HK_Q,HK_W,HK_W,HK_R,HK_W,HK_W},	-- EQW
}

local MenuIcons = "http://vignette1.wikia.nocookie.net/getsetgames/images/8/82/Level_up_icon.png"

 --Main Menu
local AMenu = MenuElement({type = MENU, id = "AMenu", name = "Auto Level Spell - "..myHero.charName, leftIcon = MenuIcons})
--AMenu:MenuElement({id = "Enabled", name = "Enabled", value = true})

--Auto Menu
AMenu:MenuElement({type = MENU, id = "SpellsOrder", name = "Spells Order"})
AMenu.SpellsOrder:MenuElement({type = SPACE, name = "Suggest: Max Q -> E -> W"})
AMenu.SpellsOrder:MenuElement({id = "spell1",name = "Piority: 1st spell max : ", key = string.byte("Q")})
AMenu.SpellsOrder:MenuElement({id = "spell2",name = "Piority: 2nd spell max : ", key = string.byte("W")})
--AMenu.SpellsOrder:MenuElement({id = "spell3",name = "Piority: 3rd spell max : ", key = string.byte("E")})
AMenu:MenuElement({id = "UseAutoLvSpell", name = "Use Auto Level Spell", value = false})
AMenu:MenuElement({id = "UseHumanizer", name = "Humanizer", value = true})


function Spells()
	--PrintChat (AMenu.SpellsOrder["key"])
	if  string.byte("Q") == AMenu.SpellsOrder.spell1:Key()  and string.byte("E") == AMenu.SpellsOrder.spell2:Key() then
		sequence = 1
	elseif string.byte("Q") == AMenu.SpellsOrder.spell1:Key()  and string.byte("W") == AMenu.SpellsOrder.spell2:Key() then
		sequence = 2
	elseif string.byte("W") == AMenu.SpellsOrder.spell1:Key()  and string.byte("E") == AMenu.SpellsOrder.spell2:Key() then
		sequence = 3
	elseif string.byte("W") == AMenu.SpellsOrder.spell1:Key()  and string.byte("Q") == AMenu.SpellsOrder.spell2:Key() then
		sequence = 4
	elseif string.byte("E") == AMenu.SpellsOrder.spell1:Key()  and string.byte("Q") == AMenu.SpellsOrder.spell2:Key() then
		sequence = 5
	elseif string.byte("E") == AMenu.SpellsOrder.spell1:Key()  and string.byte("W") == AMenu.SpellsOrder.spell2:Key() then
		sequence = 6
	else
		sequence = 0
	end
end


function OnTick()
if not AMenu.UseAutoLvSpell:Value() then return end
	--PrintChat(SpellsSequence[3][1])
	--PrintChat(sequence)
	Spells()
	if myHero.levelData.lvl > 0 and myHero.levelData.lvlPts > 0 and AMenu.UseAutoLvSpell:Value() then
		if (myHero.levelData.lvl + 1 - myHero.levelData.lvlPts) then
			if AMenu.UseHumanizer:Value() then
				tickCount = tickCount + 1
					if tickCount >=30 then
						--PrintChat ("lv = "..myHero.levelData.lvl)
						--PrintChat ("lvPoint = "..myHero.levelData.lvlPts)
						--PrintChat (DefaultSpellsOrders[myHero.charName][(myHero.levelData.lvl + 1 - myHero.levelData.lvlPts)])
						Control.KeyDown(HK_LUS)
						Control.CastSpell(SpellsSequence[sequence][(myHero.levelData.lvl + 1 - myHero.levelData.lvlPts)])
						Control.KeyUp(HK_LUS)	
						tickCount = 0
					elseif not AMenu.UseHumanizer:Value() then
						Control.KeyDown(HK_LUS)
						Control.CastSpell(SpellsSequence[sequence][(myHero.levelData.lvl + 1 - myHero.levelData.lvlPts)])
						Control.KeyUp(HK_LUS)	
					end
			end
		end
	end
end



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
	local ver = 0.3
	local tickCountA = 0
	local sequence = 0
	local spellMaxfirst = string.char(DefaultSpellsOrders[myHero.charName][4])
	local spellMaxSecond = string.char(DefaultSpellsOrders[myHero.charName][13])
	local spellMaxThird = string.char(DefaultSpellsOrders[myHero.charName][18])
	local ScriptLoadTime = Game.Timer()
	
	PrintChat ("[Auto Level Spell]  Loaded : "..myHero.charName.." || Version: "..ver," ", "|| LoL Support : "..lol)

local SpellsSequence = {
    [1]= { HK_Q,HK_W,HK_E,HK_Q,HK_Q,HK_R,HK_Q,HK_W,HK_Q,HK_W,HK_R,HK_W,HK_W,HK_E,HK_E,HK_R,HK_E,HK_E},  -- QWE
    [2]= { HK_Q,HK_W,HK_E,HK_Q,HK_Q,HK_R,HK_Q,HK_E,HK_Q,HK_E,HK_R,HK_E,HK_E,HK_W,HK_W,HK_R,HK_W,HK_W},	-- QEW
    [3]= { HK_W,HK_E,HK_Q,HK_W,HK_W,HK_R,HK_W,HK_Q,HK_W,HK_Q,HK_R,HK_Q,HK_Q,HK_E,HK_E,HK_R,HK_E,HK_E},	-- WQE
    [4]= { HK_W,HK_E,HK_Q,HK_W,HK_W,HK_R,HK_W,HK_E,HK_W,HK_E,HK_R,HK_E,HK_E,HK_Q,HK_Q,HK_R,HK_Q,HK_Q},	-- WEQ
    [5]= { HK_E,HK_Q,HK_W,HK_E,HK_E,HK_R,HK_E,HK_W,HK_E,HK_W,HK_R,HK_W,HK_W,HK_Q,HK_Q,HK_R,HK_Q,HK_Q},	-- EWQ
    [6]= { HK_E,HK_Q,HK_W,HK_E,HK_E,HK_R,HK_E,HK_Q,HK_E,HK_Q,HK_R,HK_Q,HK_Q,HK_W,HK_W,HK_R,HK_W,HK_W},	-- EQW
}

--http://i65.tinypic.com/23w1jes.png
local MenuIcons = "http://vignette1.wikia.nocookie.net/getsetgames/images/8/82/Level_up_icon.png"

 --Main Menu
local AMenu = MenuElement({type = MENU, id = "AMenu", name = "Auto Level Spells: Customizer", leftIcon = MenuIcons})
AMenu:MenuElement({id = "UseAutoLvSpell", name = "Enable", value = false})

--Auto Menu
AMenu:MenuElement({type = MENU, id = "Auto", name = myHero.charName, leftIcon = "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/champion/"..myHero.charName..".png"})
AMenu.Auto:MenuElement({type = MENU, id = "SpellsOrder", name = "Spells Sequence", leftIcon = "http://www.swiftpcoptimizer.com/wp-content/uploads/2016/10/workflow.png"})
AMenu.Auto.SpellsOrder:MenuElement({id = "spell1",name = "Priority : 1st Spells Max", key = string.byte("Q")})
AMenu.Auto.SpellsOrder:MenuElement({id = "spell2",name = "Priority : 2nd Spells Max", key = string.byte("W")})
AMenu.Auto.SpellsOrder:MenuElement({type = SPACE, name = "Recommend : Max "..spellMaxfirst.." > "..spellMaxSecond.." > "..spellMaxThird})
AMenu.Auto:MenuElement({id = "lvROnly", name = "R Spells Only", value =true, leftIcon =  "https://az691558.vo.msecnd.net/themes/m15106_usaca_5c54bec2/rossignol_r2.png"})
AMenu.Auto:MenuElement({id = "Disablelvl1", name = "Disable on First Level", value =true, leftIcon =  "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/1_green.svg/480px-1_green.svg.png"})
AMenu.Auto:MenuElement({id = "UseHumanizer", name = "Humanizer", value = true, leftIcon = "http://www.freeiconspng.com/uploads/-human-male-man-people-person-profile-red-user-icon--icon--23.png"})

----Info Menu
AMenu:MenuElement({type = MENU, id = "info", name = "Script Info", leftIcon = "http://www.freeiconspng.com/uploads/information-icon-5.png"})
AMenu.info:MenuElement({type = SPACE, name = "Script Version: "..ver})
AMenu.info:MenuElement({type = SPACE, name = "Support LoL: "..lol})
AMenu.info:MenuElement({type = SPACE, name = "Author: JarKao"})

function SpellsSelect()
	if	Game.Timer() - ScriptLoadTime >= 240 then return end
	--PrintChat (Game.Timer() - ScriptLoadTime )
	if string.byte("Q") == AMenu.Auto.SpellsOrder.spell1:Key()  and string.byte("E") == AMenu.Auto.SpellsOrder.spell2:Key() then
		sequence = 1
	elseif string.byte("Q") == AMenu.Auto.SpellsOrder.spell1:Key()  and string.byte("W") == AMenu.Auto.SpellsOrder.spell2:Key() then
		sequence = 2
	elseif string.byte("W") == AMenu.Auto.SpellsOrder.spell1:Key()  and string.byte("E") == AMenu.Auto.SpellsOrder.spell2:Key() then
		sequence = 3
	elseif string.byte("W") == AMenu.Auto.SpellsOrder.spell1:Key()  and string.byte("Q") == AMenu.Auto.SpellsOrder.spell2:Key() then
		sequence = 4
	elseif string.byte("E") == AMenu.Auto.SpellsOrder.spell1:Key()  and string.byte("Q") == AMenu.Auto.SpellsOrder.spell2:Key() then
		sequence = 5
	elseif string.byte("E") == AMenu.Auto.SpellsOrder.spell1:Key()  and string.byte("W") == AMenu.Auto.SpellsOrder.spell2:Key() then
		sequence = 6
	else
		sequence = 0
	end

end

function OnTick()
if not AMenu.UseAutoLvSpell:Value() then return end
	SpellsSelect()
	AutoLevelSpell()
end

function AutoLevelSpell()
	if AMenu.Auto.Disablelvl1:Value() and myHero.levelData.lvl == 1 then return end
	if myHero.levelData.lvl > 0 and myHero.levelData.lvlPts > 0 and AMenu.UseAutoLvSpell:Value() then
		if (myHero.levelData.lvl + 1 - myHero.levelData.lvlPts) then
			if AMenu.Auto.UseHumanizer:Value() then
				tickCountA = tickCountA + 1
			end
			if AMenu.Auto.UseHumanizer:Value() and tickCountA >= 35 then
				tickCountA = 0
				if AMenu.Auto.lvROnly:Value() and myHero.levelData.lvl == (6 or 11 or 16)  then 
					LevelRSpell()
				elseif not AMenu.Auto.lvROnly:Value() then 
					LevelSpell() 
				end
			elseif not AMenu.Auto.UseHumanizer:Value() then
				if AMenu.Auto.lvROnly:Value() and myHero.levelData.lvl == (6 or 11 or 16) then 
					LevelRSpell()
				elseif not AMenu.Auto.lvROnly:Value() then 
					LevelSpell() 
				end
			end		
		end
	end
end

function LevelSpell()
		Control.KeyDown(HK_LUS)
		if sequence == 0 then
			Control.CastSpell (DefaultSpellsOrders[myHero.charName][(myHero.levelData.lvl + 1 - myHero.levelData.lvlPts)])
		else
			Control.CastSpell(SpellsSequence[sequence][(myHero.levelData.lvl + 1 - myHero.levelData.lvlPts)])
		end
		Control.KeyUp(HK_LUS)	
end

function LevelRSpell()
	Control.KeyDown(HK_LUS)
	Control.CastSpell(HK_R)
	Control.KeyUp(HK_LUS)	
end

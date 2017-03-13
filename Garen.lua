--Hero
if myHero.charName ~= "Garen" then return end

--Locals
local LoL = "7.5"
local ver = "2.0"

--icon
local MenuIcons = "http://static.lolskill.net/img/champions/64/garen.png"
local SpellIcons = { Q = "http://vignette3.wikia.nocookie.net/leagueoflegends/images/1/17/Decisive_Strike.png",
					 W = "http://vignette1.wikia.nocookie.net/leagueoflegends/images/2/25/Courage.png",
					 E = "http://vignette2.wikia.nocookie.net/leagueoflegends/images/1/15/Judgment.png",
					 R = "http://vignette1.wikia.nocookie.net/leagueoflegends/images/c/ce/Demacian_Justice.png"
}
local BlockIcons = "https://www.richters.com/Issues/whitelist/nowhitelist.png"
local RangeIcons = "http://wfarm2.dataknet.com/static/resources/icons/set51/4004fa57.png"

--Main Menu
local GMenu = MenuElement({type = MENU, id = "GMenu", name = "Garen", leftIcon = MenuIcons})
GMenu:MenuElement({id = "Enabled", name = "Enabled", value = true})

--Main Menu-- Key Setting
GMenu:MenuElement({type = MENU, id = "Key", name = "Key Settings"})
GMenu.Key:MenuElement({id = "Combo",name = "Combo HotKey", key = 32})
GMenu.Key:MenuElement({id = "Harass",name = "Harass HotKey", key = string.byte("C")})
GMenu.Key:MenuElement({id = "Clear",name = "Clear HotKey", key = string.byte("V")})
GMenu.Key:MenuElement({id = "LastHit",name = "Last Hit HotKey", key = string.byte("X")})

--Main Menu-- Mode Setting
GMenu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})
--Main Menu-- Mode Setting-- Combo
GMenu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
GMenu.Mode.Combo:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
GMenu.Mode.Combo:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
GMenu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
GMenu.Mode.Combo:MenuElement({id = "R", name = "Use R", value = true, leftIcon = SpellIcons.R})
--Main Menu-- Mode Setting-- Harass
GMenu.Mode:MenuElement({type = MENU, id = "Harass", name = "Harass"})
GMenu.Mode.Harass:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
GMenu.Mode.Harass:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
GMenu.Mode.Harass:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- Clear 
GMenu.Mode:MenuElement({type = MENU, id = "Clear", name = "Clear"})
GMenu.Mode.Clear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
GMenu.Mode.Clear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- LastHit
GMenu.Mode:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
GMenu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})

--Main Menu-- KillSteal Setting
GMenu:MenuElement({type = MENU, id = "KillSteal", name = "KillSteal Settings"})
GMenu.KillSteal:MenuElement({id = "R", name = "Use R to KS", value = true})
GMenu.KillSteal:MenuElement({id = "ksUnder", name = "KS unter enemy Turret", value = true})
GMenu.KillSteal:MenuElement({type = MENU, id = "black", name = "KillSteal White List"})
DelayAction(function()
	for i = 1, Game.HeroCount() do
		local hero = Game.Hero(i)
		if hero.isEnemy then
			GMenu.KillSteal.black:MenuElement({id = hero.networkID, name = "Use R On: "..hero.charName, value = true})
		end
	end
end, 1)

--Main Menu-- Drawing 
GMenu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
GMenu.Drawing:MenuElement({id = "E", name = "Draw E Range", value = true})
GMenu.Drawing:MenuElement({id = "R", name = "Draw R Range", value = true})


local comboQ = GMenu.Mode.Combo.Q:Value()
local comboW = GMenu.Mode.Combo.W:Value()
local comboE = GMenu.Mode.Combo.E:Value()
local comboR = GMenu.Mode.Combo.R:Value()
local harassQ = GMenu.Mode.Harass.Q:Value()
local harassW = GMenu.Mode.Harass.W:Value()
local harassE = GMenu.Mode.Harass.E:Value()
local clearQ = GMenu.Mode.Clear.Q:Value()
local clearW = GMenu.Mode.Clear.E:Value()
local lastHitQ = GMenu.Mode.Harass.Q:Value()
local killStealR = GMenu.KillSteal.R:Value()

local GarenQ = { range = 380 }
local GarenW = { range = 200 }
local GarenE = { range = 300 }
local GarenR = { range = 400 }

function castQ()
	Control.CastSpell(HK_Q)
end

function castW()
	Control.CastSpell(HK_W)
end

function castE()
	Control.CastSpell(HK_E)
end

function castR(target)
	Control.CastSpell(HK_R,target)
end

function isReady (spell)
	return Game.CanUseSpell(spell) == 0 
end

function canCast(spell)
	return  myHero:GetSpellData(spell).mana <= myHero.mana
end

function isCasting(spell)
	if Game.CanUseSpell(spell) == 8 or myHero:GetSpellData(_E).name == "GarenECancel" then
		return  true
	else
		return false
	end
end


function GetTarget(range)
    local target
    for i = 1,Game.HeroCount() do
        local hero = Game.Hero(i)
        if IsValidTarget(hero, range) and hero.team ~= myHero.team then
            target = hero
            break
        end
    end
    return target
end

function IsValidTarget(unit, range)
    return unit ~= nil and unit.valid and unit.visible and not unit.dead and unit.isTargetable and not unit.isImmortal and unit.distance <= range
end

local function getMode()
	if GMenu.Key.Combo:Value() then return "Combo" end
	if GMenu.Key.Harass:Value() then return "Harass" end
	if GMenu.Key.Clear:Value() then return "Clear" end
	if GMenu.Key.LastHit:Value() then return "LastHit" end
    return ""
end

function OnDraw()
	--Draw Range
	if myHero.dead then return end
	if GMenu.Drawing.E:Value() then Draw.Circle(myHero.pos,325,1,Draw.Color(255, 255, 255, 255)) end			
	if GMenu.Drawing.R:Value() then Draw.Circle(myHero.pos,400,1,Draw.Color(255, 255, 255, 255)) end	
end

--Start
function OnTick()
	if not GMenu.Enabled:Value() then return end
	if myHero.dead then return end
	local target = GetTarget(600)
	if getMode() == "Combo" then
		OnCombo(target)
	elseif getMode() == "Harass" then
		onHarass()
	elseif getMode() == "Clear" then
		--OnClear()
	elseif getMode() == "LastHit" then
		--OnLastHit()
	end	
	KillSteal()
end

function OnCombo(target)
	local target = GetTarget(600)
	if target == nil then return end

	--PrintChat (target.health)
	if comboQ and isReady(_Q) and not isCasting(_E) and IsValidTarget(target,GarenQ.range)  then
		--PrintChat("Q Cast")
		castQ()
	end

	if comboW and isReady(_W) and (isCasting(_Q) or isCasting(_E)) and IsValidTarget(target,GarenW.range) then
		castW()
		--PrintChat("W Cast")
	end

	if comboE and isReady(_E) and not isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" and IsValidTarget(target,GarenE.range) then
		castE()
		--PrintChat("E Cast")
	end

	if comboR and isReady(_R) and IsValidTarget(target,GarenR.range) and GetRdmg() > target.health  then
		castR(target)
		--PrintChat("R Cast")
	end
	
end

function onHarass(target)

	local target = GetTarget(600)
	if target == nil then return end

	--PrintChat (target.health)
	if harassQ and isReady(_Q) and not isCasting(_E) and IsValidTarget(target,GarenQ.range)  then
		--PrintChat("Q Cast")
		castQ()
	end

	if harassW and isReady(_W) and (isCasting(_Q) or isCasting(_E)) and IsValidTarget(target,GarenW.range) then
		castW()
		--PrintChat("W Cast")
	end

	if harassE and isReady(_E) and not isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" and IsValidTarget(target,GarenE.range) then
		castE()
		--PrintChat("E Cast")
	end

end

function KillSteal()
	local target = GetTarget(600)
	if target == nil then return end
	for i = 1, Game.HeroCount() do
		local target = Game.Hero(i)
		local Rdmg = (GetRdmg())
		--PrintChat (" "..target.charName.." HP "..target.health.."R damage= "..Rdmg)
		if killStealR and isReady(_R) and IsValidTarget(target, GarenR.range) and Rdmg > target.health then 
			castR(target)
		end
	end

end

function GetRdmg()
	local target = GetTarget(600)
	if target == nil then return end
	local level = myHero:GetSpellData(_R).level
	if level == nil then return 0 end
	--PrintChat(level)
	local Rdmg = ({175, 350, 525})[level] + ({8, 13, 20})[level] / 100 * (target.maxHealth - target.health)
	return Rdmg
end


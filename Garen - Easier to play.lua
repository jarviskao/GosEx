--Hero
if myHero.charName ~= "Garen" then return end

--Locals
local LoL = "7.5"
local ver = "2.3"

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
--Main Menu-- Mode Setting-- LandClear 
GMenu.Mode:MenuElement({type = MENU, id = "LaneClear", name = "Lane Clear"})
GMenu.Mode.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
GMenu.Mode.LaneClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
GMenu.Mode.LaneClear:MenuElement({id = "EKillMinion", name = "Use E when X minions", value = 3,min = 0, max = 5, step = 1})
--Main Menu-- Mode Setting-- Jungle 
GMenu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "Jungle Clear"})
GMenu.Mode.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
GMenu.Mode.JungleClear:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
GMenu.Mode.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- LastHit
GMenu.Mode:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
GMenu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})

--Main Menu-- KillSteal Setting
GMenu:MenuElement({type = MENU, id = "KillSteal", name = "KillSteal Settings"})
GMenu.KillSteal:MenuElement({id = "R", name = "Use R to KS", value = true})
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

local GarenQ = { range = 600 }
local GarenW = { range = 250 }
local GarenE = { range = 300 }
local GarenR = { range = 400 }
local EOrbWalking = false
local ICOrbWalking = false
local GOSOrbWalking = false

DelayAction(function()
	if EOW then 
		PrintChat ("[Info] Garen Script is intergreted with the eXternal Orbwalker")
		EOrbWalking = true
		if _G.Orbwalker then
			_G.Orbwalker.Enabled:Value(false)
			_G.Orbwalker.Drawings.Enabled:Value(false)
		end
	elseif _G.SDK then
		PrintChat ("[Info] Garen Script is intergreted with the IC's Orbwalker")
		ICOrbWalking = true
	elseif _G.Orbwalker then
		PrintChat ("[Info] Garen Script is intergreted with the in-built GOS Orbwalker")
		GOSOrbWalking = true
	end
end, 1)

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

function getTarget(range)
    local target
    for i = 1,Game.HeroCount() do
        local hero = Game.Hero(i)
        if hero.team ~= myHero.team and IsValidTarget(hero, range) then
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
	if EOW then 
		if EOW:Mode() == "Combo"  then return "Combo" end
		if EOW:Mode() == "Harass" then return "Harass" end
		if EOW:Mode() == "LaneClear" then return "Clear" end
		if EOW:Mode() == "LastHit" then return "LastHit" end
	elseif _G.SDK then
		if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] then return "Combo" end
		if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] then return "Harass" end
		if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR] then return "Clear" end
		if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] then return "LastHit" end
	elseif _G.Orbwalker then
		if GMenu.Key.Combo:Value() then return "Combo" end
		if GMenu.Key.Harass:Value() then return "Harass" end
		if GMenu.Key.Clear:Value() then return "Clear" end
		if GMenu.Key.LastHit:Value() then return "LastHit" end
	end
	return ""
end

function getEnemyMinions(range)
	local target
    for i = 1,Game.MinionCount() do
        local minion = Game.Minion(i)
        if  minion.team ~= myHero.team and IsValidTarget(minion, range) then
            target = minion
            break
        end
    end
    return target
end

function CountEnemyMinions(range)
	local minionsCount = 0
    for i = 1,Game.MinionCount() do
        local minion = Game.Minion(i)
        if  minion.team ~= myHero.team and IsValidTarget(minion, range) then
            minionsCount = minionsCount + 1
        end
    end
    --PrintChat (minionsCount)
    return minionsCount
end

function OnDraw()
	--Draw Range
	if myHero.dead then return end
	if GMenu.Drawing.E:Value() then Draw.Circle(myHero.pos,325,1,Draw.Color(255, 0, 0, 220)) end			
	if GMenu.Drawing.R:Value() then Draw.Circle(myHero.pos,400,1,Draw.Color(220,255,0,0)) end	
end

--Start
function OnTick()
	if not GMenu.Enabled:Value() then return end
	if myHero.dead then return end
	
	if getMode() == "Combo" then
		OnCombo()
	elseif getMode() == "Harass" then
		onHarass()
	elseif getMode() == "Clear" then
		OnClear()
	elseif getMode() == "LastHit" then
		OnLastHit()
	end	
	KillSteal()
end

function OnCombo()
	local comboQ = GMenu.Mode.Combo.Q:Value()
	local comboW = GMenu.Mode.Combo.W:Value()
	local comboE = GMenu.Mode.Combo.E:Value()
	local comboR = GMenu.Mode.Combo.R:Value()
	local target = getTarget(800)
	if target == nil then return end
	
	if ICOrbWalking then
		target = _G.SDK.TargetSelector:GetTarget(800)
	end
	
	if IsValidTarget(target,GarenQ.range) and comboQ and isReady(_Q) and not isCasting(_E) then
		castQ()
	end

	if IsValidTarget(target,GarenW.range) and comboW and isReady(_W) then
		castW()
	end

	if IsValidTarget(target,GarenE.range) and comboE and isReady(_E) and not isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" then
		castE()
	end

	if IsValidTarget(target,GarenR.range) and comboR and isReady(_R) then
		local level = myHero:GetSpellData(_R).level
		local Rdmg = ({175, 350, 525})[level] + ({8, 13, 20})[level] / 100 * (target.maxHealth - target.health)
		if  Rdmg >= target.health then
			castR(target)
		end
	end
	
end

function onHarass()
	local harassQ = GMenu.Mode.Harass.Q:Value()
	local harassW = GMenu.Mode.Harass.W:Value()
	local harassE = GMenu.Mode.Harass.E:Value()
	local target = getTarget(800)
	if target == nil then return end

	if ICOrbWalking then
		target = _G.SDK.TargetSelector:GetTarget(800)
	end
	
	if IsValidTarget(target,GarenQ.range) and harassQ and isReady(_Q) and not isCasting(_E) then
		castQ()
	end

	if IsValidTarget(target,GarenW.range) and harassW and isReady(_W) then
		castW()
	end

	if IsValidTarget(target,GarenE.range) and harassE and isReady(_E) and not isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" then
		castE()
	end

end

function OnClear()
	local LaneClearQ = GMenu.Mode.LaneClear.Q:Value()
	local LaneClearE = GMenu.Mode.LaneClear.E:Value()
	local LaneClearEminion = GMenu.Mode.LaneClear.EKillMinion:Value()
	local JungleClearQ = GMenu.Mode.JungleClear.Q:Value()
	local JungleClearW = GMenu.Mode.JungleClear.W:Value()
	local JungleClearE = GMenu.Mode.JungleClear.E:Value()

	local minion = getEnemyMinions(350)
	if minion == nil then return end
	
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if  minion.team == 200 then
			if IsValidTarget(minion,200) and LaneClearQ and isReady(_Q) and not isCasting(_E) then
				castQ()
				Control.Attack(minion)
			end
			
			if IsValidTarget(minion,GarenE.range) and LaneClearE and isReady(_E) and not isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" and  CountEnemyMinions(GarenE.range) >= LaneClearEminion then
				castE()
			end
		elseif minion.team == 300 then
			if IsValidTarget(minion,320) and JungleClearQ and isReady(_Q) and not isCasting(_E) then
				castQ()
				Control.Attack(minion)
			end
			
			if IsValidTarget(minion,320) and JungleClearW and isReady(_W) then
				castW()
			end
			
			if IsValidTarget(minion,GarenE.range) and JungleClearE and isReady(_E) and not isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" then
				castE()
			end
		end
	end
end

function OnLastHit()
	local lastHitQ = GMenu.Mode.LastHit.Q:Value()
	local minion = getEnemyMinions(300)
	if minion == nil then return end
	
	local level = myHero:GetSpellData(_Q).level
	if level == nil or level == 0 then return end
	
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		local Qdmg = ({30, 55, 80, 105, 130})[level] + (1.4 * myHero.totalDamage)
		if minion.team ~= myHero.team and IsValidTarget(minion, 200)   then
			if Qdmg >= minion.health and lastHitQ and isReady(_Q) and not isCasting(_E) then
				castQ()
				Control.Attack(minion)
			end
		end
	end
	
end

function KillSteal()
	local killStealR = GMenu.KillSteal.R:Value()
	local target = getTarget(800)
	if target == nil then return end
	
	local level = myHero:GetSpellData(_R).level
	if level == nil or level == 0 then return end
	
	for i = 1, Game.HeroCount() do
		local target = Game.Hero(i)
		local Rdmg = ({175, 350, 525})[level] + ({8, 13, 20})[level] / 100 * (target.maxHealth - target.health)
		if target.team ~= myHero.team and IsValidTarget(target, GarenR.range) then
			if Rdmg >= target.health and killStealR and isReady(_R) then 
				if GMenu.KillSteal.black[target.networkID]:Value()  then
					castR(target)
				end
			end
		end
	end
	
end
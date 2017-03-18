--Hero
if myHero.charName ~= "Pantheon" then return end

--Locals
local LoL = "7.5"
local ver = "1.3"

--icon
local MenuIcons = "http://static.lolskill.net/img/champions/64/pantheon.png"
local SpellIcons = { Q = "http://static.lolskill.net/img/abilities/64/Pantheon_SpearShot.png",
					 W = "http://static.lolskill.net/img/abilities/64/Pantheon_LeapBash.png",
					 E = "http://static.lolskill.net/img/abilities/64/Pantheon_HSS.png",
}

--Main Menu
local PMenu = MenuElement({type = MENU, id = "PMenu", name = "Pantheon", leftIcon = MenuIcons})
PMenu:MenuElement({id = "Enabled", name = "Enabled", value = true})

--Main Menu-- Key Setting
PMenu:MenuElement({type = MENU, id = "Key", name = "Key Settings"})
PMenu.Key:MenuElement({id = "Combo",name = "Combo HotKey", key = 32})
PMenu.Key:MenuElement({id = "Harass",name = "Harass HotKey", key = string.byte("C")})
PMenu.Key:MenuElement({id = "Clear",name = "Clear HotKey", key = string.byte("V")})
PMenu.Key:MenuElement({id = "LastHit",name = "Last Hit HotKey", key = string.byte("X")})

--Main Menu-- Mode Setting
PMenu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})
--Main Menu-- Mode Setting-- Combo
PMenu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
PMenu.Mode.Combo:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
PMenu.Mode.Combo:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
PMenu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- Harass
PMenu.Mode:MenuElement({type = MENU, id = "Harass", name = "Harass"})
PMenu.Mode.Harass:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
PMenu.Mode.Harass:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
PMenu.Mode.Harass:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- LandClear 
PMenu.Mode:MenuElement({type = MENU, id = "LaneClear", name = "Lane Clear"})
PMenu.Mode.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
PMenu.Mode.LaneClear:MenuElement({id = "QMana", name = "Min Mana to use Q (%)", value = 80, min = 0, max = 100, step = 1})
PMenu.Mode.LaneClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
PMenu.Mode.LaneClear:MenuElement({id = "EMana", name = "Min Mana to use E (%)", value = 80, min = 0, max = 100, step = 1})
PMenu.Mode.LaneClear:MenuElement({id = "EKillMinion", name = "Use E when X minions", value = 3,min = 0, max = 5, step = 1})
--Main Menu-- Mode Setting-- Jungle 
PMenu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "Jungle Clear"})
PMenu.Mode.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
PMenu.Mode.JungleClear:MenuElement({id = "QMana", name = "Min Mana to use Q (%)", value = 80, min = 0, max = 100, step = 1})
PMenu.Mode.JungleClear:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
PMenu.Mode.JungleClear:MenuElement({id = "WMana", name = "Min Mana to use W (%)", value = 80, min = 0, max = 100, step = 1})
PMenu.Mode.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
PMenu.Mode.JungleClear:MenuElement({id = "EMana", name = "Min Mana to use E (%)", value = 80, min = 0, max = 100, step = 1})
--Main Menu-- Mode Setting-- LastHit
PMenu.Mode:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
PMenu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})

--Main Menu-- KillSteal Setting
PMenu:MenuElement({type = MENU, id = "KillSteal", name = "KillSteal Settings"})
PMenu.KillSteal:MenuElement({id = "Q", name = "Use Q to KS", value = true})
--PMenu.KillSteal:MenuElement({id = "ksUnder", name = "KS unter enemy Turret", value = true})

--Main Menu-- Auto Setting
PMenu:MenuElement({type = MENU, id = "Auto", name = "Auto Settings"})
PMenu.Auto:MenuElement({id = "Q", name = "Auto Q When Target in Range", value = true})
PMenu.Auto:MenuElement({id = "QMana", name = "Min Mana to auto Q (%)", value = 80,min = 0, max = 100, step = 1})
--PMenu.Auto:MenuElement({id = "DonQ", name = "Don't Auto Q in Enemy Turret Range" , value = true})

--Main Menu-- Drawing 
PMenu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
PMenu.Drawing:MenuElement({id = "Q", name = "Draw Q Range", value = true})
PMenu.Drawing:MenuElement({id = "W", name = "Draw W Range", value = true})
PMenu.Drawing:MenuElement({id = "E", name = "Draw E Range", value = true})

local PantheonQ = { range = 600 }
local PantheonW = { range = 600 }
local PantheonE = { range = 400 ,  channels = 0.75}
local EOrbWalking = false
local ICOrbWalking = false
local GOSOrbWalking = false
local StopOrbWalking = false
local isCastingE = false
local ticker = 0

DelayAction(function()
	if EOW then 
		PrintChat ("[Info] Pantheon Script is intergreted with the eXternal Orbwalker")
		EOrbWalking = true
		if _G.Orbwalker then
			_G.Orbwalker.Enabled:Value(false)
			_G.Orbwalker.Drawings.Enabled:Value(false)
		end
	elseif _G.SDK then
		PrintChat ("[Info] Pantheon Script is intergreted with the IC's Orbwalker")
		ICOrbWalking = true
	elseif _G.Orbwalker then
		PrintChat ("[Info] Pantheon Script is intergreted with the in-built GOS Orbwalker")
		GOSOrbWalking = true
	end
end, 1)

function castQ(target)
	Control.CastSpell(HK_Q,target.pos)
end

function castW(target)
	Control.CastSpell(HK_W,target.pos)
end

function castE() 
	Control.CastSpell(HK_E)
end


function isReady (spell)
	return Game.CanUseSpell(spell) == 0 
end

function canCast(spell)
	return  myHero.mana > myHero:GetSpellData(spell).mana
end

function isCasting(spell)
	if Game.CanUseSpell(spell) == 8  then
		return  true
	else
		return false
	end
end

function isCD(spell)
	if Game.CanUseSpell(spell) == 32  then
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
		if PMenu.Key.Combo:Value() then return "Combo" end
		if PMenu.Key.Harass:Value() then return "Harass" end
		if PMenu.Key.Clear:Value() then return "Clear" end
		if PMenu.Key.LastHit:Value() then return "LastHit" end
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
	if PMenu.Drawing.Q:Value() or PMenu.Drawing.W:Value() then Draw.Circle(myHero.pos,600,1,Draw.Color(255, 255, 255, 255)) end
	if PMenu.Drawing.E:Value() then Draw.Circle(myHero.pos,400,1,Draw.Color(255, 255, 255, 255)) end			
end

--Start
function OnTick()
	--PrintChat ("Gime Time : "..Game.Timer().." cast : "..(myHero:GetSpellData(_E).castTime - myHero:GetSpellData(_E).cd + 1))
	if not PMenu.Enabled:Value() then return end
	if myHero.dead then return end
	check()
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

function check()

	if isCastingE then
		if GOSOrbWalking then
			_G.Orbwalker.Enabled:Value(false)
		elseif EOrbWalking then
			_G.EOW:MovementsEnabled(false)
			_G.EOW:AttacksEnabled(false)
		end
	end
	
	if GetTickCount() >= ticker + 900 then
		if GOSOrbWalking and StopOrbWalking then
				_G.Orbwalker.Enabled:Value(true)
				isCastingE = false
				StopOrbWalking = false
		elseif EOrbWalking and StopOrbWalking then
				_G.EOW:MovementsEnabled(true)
				_G.EOW:AttacksEnabled(true)
				isCastingE = false
				StopOrbWalking = false
		end
	end		

end

function OnCombo()
	local comboQ = PMenu.Mode.Combo.Q:Value()
	local comboW = PMenu.Mode.Combo.W:Value()
	local comboE = PMenu.Mode.Combo.E:Value()
	local target = getTarget(800)
	if target == nil then return end

	if ICOrbWalking then
		target = _G.SDK.TargetSelector:GetTarget(800)
	end
	
	if IsValidTarget(target,PantheonQ.range) and comboQ and isReady(_Q) and not myHero.isChanneling then
		castQ(target)
	end

	if IsValidTarget(target,PantheonW.range) and comboW and isReady(_W) and not myHero.isChanneling and not isReady(_Q) then
		castW(target)
	end

	if IsValidTarget(target,PantheonE.range) and comboE and isReady(_E) and not myHero.isChanneling then
		local Epos = target:GetPrediction(myHero:GetSpellData(_E).speed, myHero:GetSpellData(_E).delay)
		Control.SetCursorPos(Epos)
		Control.KeyDown(HK_E)
		Control.KeyUp(HK_E)
		isCastingE = true
		StopOrbWalking = true
		ticker = GetTickCount()
	end
	
end

function onHarass()
	local harassQ = PMenu.Mode.Harass.Q:Value()
	local harassW = PMenu.Mode.Harass.W:Value()
	local harassE = PMenu.Mode.Harass.E:Value()
	local target = getTarget(800)
	if target == nil then return end

	if ICOrbWalking then
		target = _G.SDK.TargetSelector:GetTarget(800)
	end

	if IsValidTarget(target,PantheonQ.range) and harassQ and isReady(_Q) then
		castQ(target)
	end

	if IsValidTarget(target,PantheonW.range) and harassW and isReady(_W) then
		castW(target)
	end

end

function OnClear()
	local LaneClearQ = PMenu.Mode.LaneClear.Q:Value()
	local LaneClearE = PMenu.Mode.LaneClear.E:Value()
	local LaneClearEminion = PMenu.Mode.LaneClear.EKillMinion:Value()
	local JungleClearQ = PMenu.Mode.JungleClear.Q:Value()
	local JungleClearW = PMenu.Mode.JungleClear.W:Value()
	local JungleClearE = PMenu.Mode.JungleClear.E:Value()
	local JungleClearQMana = PMenu.Mode.JungleClear.QMana:Value()
	local JungleClearWMana = PMenu.Mode.JungleClear.WMana:Value()
	local JungleClearEMana = PMenu.Mode.JungleClear.EMana:Value()

	local minion = getEnemyMinions(600)
	if minion == nil then return end
	
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if  minion.team == 200 then
			--Q
			if IsValidTarget(minion,550) and LaneClearQ and isReady(_Q) and not myHero.isChanneling then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_Q)
				Control.KeyUp(HK_Q)
			end
			--E
			if IsValidTarget(minion,350) and LaneClearE and isReady(_E) and not myHero.isChanneling and CountEnemyMinions(350) >= LaneClearEminion then
				local Epos = minion:GetPrediction(myHero:GetSpellData(_E).speed, myHero:GetSpellData(_E).delay)
				Control.SetCursorPos(Epos)
				Control.KeyDown(HK_E)
				Control.KeyUp(HK_E)
				isCastingE = true
				StopOrbWalking = true
				ticker = GetTickCount()
			end
		elseif minion.team == 300 then
			--Q
			if IsValidTarget(minion,550) and JungleClearQ and isReady(_Q) and not myHero.isChanneling and myHero.mana > JungleClearQMana then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_Q)
				Control.KeyUp(HK_Q)
			end
			--W
			if IsValidTarget(minion,500) and JungleClearW and isReady(_W) and not myHero.isChanneling and myHero.mana > JungleClearEMana then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_W)
				Control.KeyUp(HK_W)
			end
			--E
			if IsValidTarget(minion,350) and JungleClearE and isReady(_E) and not myHero.isChanneling and myHero.mana > JungleClearWMana then
				local Epos = minion:GetPrediction(myHero:GetSpellData(_E).speed, myHero:GetSpellData(_E).delay)
				Control.SetCursorPos(Epos)
				Control.KeyDown(HK_E)
				Control.KeyUp(HK_E)
				isCastingE = true
				StopOrbWalking = true
				ticker = GetTickCount()
			end
		end
	end
end

function OnLastHit()
	local lastHitQ = PMenu.Mode.Harass.Q:Value()
	local minion = getEnemyMinions(800)
	if minion == nil then return end
	
	local level = myHero:GetSpellData(_Q).level
	if level == nil or level == 0 then return end
	
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		local Qdmg = (({65, 105, 145, 185, 225})[level] + 1.4 * minion.totalDamage) * ((minion.health / minion.maxHealth < 0.15) and 2 or 1)
		 if  minion.team ~= myHero.team and IsValidTarget(minion, PantheonQ.range) then
			if Qdmg >= minion.health and lastHitQ and isReady(_Q) then
				castQ(minion)
			end
		end
	end
	
end

function KillSteal()
	local killStealQ = PMenu.KillSteal.Q:Value()
	local target = getTarget(800)
	if target == nil then return end
	
	local level = myHero:GetSpellData(_R).level
	if level == nil or level == 0 then return end
	
	for i = 1, Game.HeroCount() do
		local target = Game.Hero(i)
		local Qdmg = (({65, 105, 145, 185, 225})[level] + 1.4 * target.totalDamage) * ((target.health / target.maxHealth < 0.15) and 2 or 1)
		if target.team ~= myHero.team and IsValidTarget(target, PantheonQ.range) then
			if Qdmg >= target.health and killStealQ and isReady(_Q) then 
				castQ(target)
			end
		end
	end
end

--Hero
if myHero.charName ~= "MonkeyKing" then return end

--Locals
local LoL = "7.5"
local ver = "0.2"

--icon
local MenuIcons = "http://static.lolskill.net/img/champions/64/MonkeyKing.png"
local SpellIcons = { Q = "http://static.lolskill.net/img/abilities/64/MonkeyKingCrushingBlow.png",
					 W = "http://static.lolskill.net/img/abilities/64/MonkeyKingDecoy.png",
					 E = "http://static.lolskill.net/img/abilities/64/MonkeyKingNimbusStrike.png",
					 R = "http://static.lolskill.net/img/abilities/64/MonkeyKingCyclone.png",
}

--Main Menu
local WMenu = MenuElement({type = MENU, id = "WMenu", name = "MonkeyKing", leftIcon = MenuIcons})
WMenu:MenuElement({id = "Enabled", name = "Enabled", value = true})

--Main Menu-- Key Setting
WMenu:MenuElement({type = MENU, id = "Key", name = "Key Settings"})
WMenu.Key:MenuElement({id = "Combo",name = "Combo HotKey", key = 32})
WMenu.Key:MenuElement({id = "Harass",name = "Harass HotKey", key = string.byte("C")})
WMenu.Key:MenuElement({id = "Clear",name = "Clear HotKey", key = string.byte("V")})
WMenu.Key:MenuElement({id = "LastHit",name = "Last Hit HotKey", key = string.byte("X")})

--Main Menu-- Mode Setting
WMenu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})
--Main Menu-- Mode Setting-- Combo
--[[
WMenu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
WMenu.Mode.Combo:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
WMenu.Mode.Combo:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
WMenu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
--]]
--Main Menu-- Mode Setting-- Harass
WMenu.Mode:MenuElement({type = MENU, id = "Harass", name = "Harass"})
WMenu.Mode.Harass:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
WMenu.Mode.Harass:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
WMenu.Mode.Harass:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- LandClear 
WMenu.Mode:MenuElement({type = MENU, id = "LaneClear", name = "Lane Clear"})
WMenu.Mode.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
WMenu.Mode.LaneClear:MenuElement({id = "QMana", name = "Min Mana to use Q (%)", value = 80, min = 0, max = 100, step = 1, leftIcon = SpellIcons.Q})
WMenu.Mode.LaneClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
WMenu.Mode.LaneClear:MenuElement({id = "EMana", name = "Min Mana to use E (%)", value = 80, min = 0, max = 100, step = 1, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- Jungle 
WMenu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "Jungle Clear"})
WMenu.Mode.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
WMenu.Mode.JungleClear:MenuElement({id = "QMana", name = "Min Mana to use Q (%)", value = 30, min = 0, max = 100, step = 1, leftIcon = SpellIcons.Q})
WMenu.Mode.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
WMenu.Mode.JungleClear:MenuElement({id = "EMana", name = "Min Mana to use E (%)", value = 30, min = 0, max = 100, step = 1, leftIcon = SpellIcons.E})
--Main Menu-- Mode Setting-- LastHit
WMenu.Mode:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
WMenu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})

--Main Menu-- KillSteal Setting
WMenu:MenuElement({type = MENU, id = "KillSteal", name = "KillSteal Settings"})
WMenu.KillSteal:MenuElement({id = "Q", name = "Use Q to KS", value = true})
WMenu.KillSteal:MenuElement({id = "E", name = "Use E to KS", value = true})

--Main Menu-- Drawing 
WMenu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
WMenu.Drawing:MenuElement({id = "E", name = "Draw E Range", value = true})
WMenu.Drawing:MenuElement({id = "R", name = "Draw R Range", value = true})

local WukongQ = { range = 300 }
local WukongW = { range = 175 }
local WukongE = { range = 625 }
local WukongR = { range = 162.5 }
local EOrbWalking = false
local ICOrbWalking = false
local GOSOrbWalking = false
local StopOrbWalking = false
local isCastingE = false
local ticker = 0

DelayAction(function()
	if EOW then 
		PrintChat ("[Info] WuKong Script is intergreted with the eXternal Orbwalker")
		EOrbWalking = true
		if _G.Orbwalker then
			_G.Orbwalker.Enabled:Value(false)
			_G.Orbwalker.Drawings.Enabled:Value(false)
		end
	elseif _G.SDK then
		PrintChat ("[Info] WuKong Script is intergreted with the IC's Orbwalker")
		ICOrbWalking = true
	elseif _G.Orbwalker then
		PrintChat ("[Info] WuKong Script is intergreted with the built-in GOS Orbwalker")
		GOSOrbWalking = true
	end
end, 1)

function castQ()
	Control.CastSpell(HK_Q)
end

function castW()
	Control.CastSpell(HK_W)
end

function castE(target) 
	Control.CastSpell(HK_E,target.pos)
end

function castR() 
	Control.CastSpell(HK_R)
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
		if WMenu.Key.Combo:Value() then return "Combo" end
		if WMenu.Key.Harass:Value() then return "Harass" end
		if WMenu.Key.Clear:Value() then return "Clear" end
		if WMenu.Key.LastHit:Value() then return "LastHit" end
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
    return minionsCount
end

function OnDraw()
	--Draw Range
	if myHero.dead then return end
	if WMenu.Drawing.E:Value() then Draw.Circle(myHero.pos,650,1,Draw.Color(255, 0, 0, 220)) end
	if WMenu.Drawing.R:Value() then Draw.Circle(myHero.pos,315,1,Draw.Color(220,255,0,0)) end			
end

--Start
function OnTick()
	if not WMenu.Enabled:Value() then return end
	if myHero.dead then return end
	
	if getMode() == "Combo" then
		--OnCombo()
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
	local comboQ = WMenu.Mode.Combo.Q:Value()
	local comboW = WMenu.Mode.Combo.W:Value()
	local comboE = WMenu.Mode.Combo.E:Value()
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
	local harassQ = WMenu.Mode.Harass.Q:Value()
	local harassE = WMenu.Mode.Harass.E:Value()
	if not (harassQ and harassW and harassE) then return end
	
	local target = getTarget(800)
	if target == nil then return end

	if ICOrbWalking then
		target = _G.SDK.TargetSelector:GetTarget(800)
		if target == nil then return end
	end

	if IsValidTarget(target,WukongQ.range) and harassQ and isReady(_Q) then
		castQ()
		Control.Attack(target)
	end

	if IsValidTarget(target,WukongE.range) and harassW and isReady(_E) then
		castE(target)
	end

end

function OnClear()
	local LaneClearQ = WMenu.Mode.LaneClear.Q:Value()
	local LaneClearE = WMenu.Mode.LaneClear.E:Value()
	local LaneClearQMana = WMenu.Mode.LaneClear.QMana:Value()
	local LaneClearEMana = WMenu.Mode.LaneClear.EMana:Value()
	local JungleClearQ = WMenu.Mode.JungleClear.Q:Value()
	local JungleClearE = WMenu.Mode.JungleClear.E:Value()
	local JungleClearQMana = WMenu.Mode.JungleClear.QMana:Value()
	local JungleClearEMana = WMenu.Mode.JungleClear.EMana:Value()

	if not (LaneClearQ and LaneClearE and JungleClearQ and JungleClearE) then return end

	local minion = getEnemyMinions(800)
	if minion == nil then return end
	
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if  minion.team == 200 then
			--Q
			if IsValidTarget(minion,WukongQ.range) and LaneClearQ and isReady(_Q) and not myHero.isChanneling and (myHero.mana/myHero.maxMana > LaneClearQMana / 100) then
				castQ()
				Control.Attack(minion)
			end
			--E
			if IsValidTarget(minion,WukongE.range) and LaneClearE and isReady(_E) and not myHero.isChanneling and (myHero.mana / myHero.maxMana > LaneClearEMana / 100) then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_E)
				Control.KeyUp(HK_E)
			end
		elseif minion.team == 300 then
			--Q
			if IsValidTarget(minion,WukongQ.range) and JungleClearQ and isReady(_Q) and not myHero.isChanneling and (myHero.mana/myHero.maxMana > JungleClearQMana / 100) then
				castQ()
				Control.Attack(minion)
			end
			--E
			if IsValidTarget(minion,WukongE.range) and JungleClearE and isReady(_E) and not myHero.isChanneling and (myHero.mana/myHero.maxMana > JungleClearEMana / 100) then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_E)
				Control.KeyUp(HK_E)
			end
		end
	end
end

function OnLastHit()
	local lastHitQ = WMenu.Mode.LastHit.Q:Value()
	if not lastHitQ then return end
	
	local minion = getEnemyMinions(800)
	if minion == nil then return end
	
	local level = myHero:GetSpellData(_Q).level
	if level == nil or level == 0 then return end
	
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		local Qdmg = ({30, 60, 90, 120, 150})[level] + 0.1 * myHero.totalDamage
		 if  minion.team ~= myHero.team and IsValidTarget(minion, WukongQ.range) then
			if Qdmg >= minion.health and lastHitQ and isReady(_Q) then
				castQ()
				Control.Attack(minion)
			end
		end
	end
	
end

function KillSteal()
	local killStealQ = WMenu.KillSteal.Q:Value()
	local killStealE = WMenu.KillSteal.E:Value()
	if not (killStealQ and killStealE)then return end
	
	local target = getTarget(800)
	if target == nil then return end
	
	local levelQ = myHero:GetSpellData(_Q).level
	local levelE = myHero:GetSpellData(_E).level
	if levelQ == nil or levelQ == 0 or levelE == nil or levelE == 0 then return end

	for i = 1, Game.HeroCount() do
		local target = Game.Hero(i)
		local Qdmg = ({30, 60, 90, 120, 150})[levelQ] + 0.1 * myHero.totalDamage
		local Edmg = ({60, 105, 150, 195, 240})[levelE] + 0.8 * myHero.bonusDamage
		local QEdmg = Qdmg + Edmg + target.hpRegen * 2.5
		--PrintChat(Qdmg.."  E = "..Edmg.."  E lv = "..levelE)
		if target.team ~= myHero.team and IsValidTarget(target, WukongE.range)  then
			if QEdmg >= target.health and killStealE and isReady(_E) and killStealQ and isReady(_Q) then 
					castE(target)
			elseif Edmg >= target.health and killStealE and isReady(_E) then 
				castE(target)
			elseif Qdmg >= target.health and killStealQ and isReady(_Q) and IsValidTarget(target, WukongQ.range + 50) then
					castQ()
					Control.Attack(target)
			end
		end
	end
end

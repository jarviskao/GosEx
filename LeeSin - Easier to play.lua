--Hero
if myHero.charName ~= "LeeSin" then return end

--Locals
local LoL = "7.6"
local ver = "1.0"


--icon
local MenuIcons = "http://static.lolskill.net/img/champions/64/leesin.png"
local SpellIcons = { Q1 = "http://static.lolskill.net/img/abilities/64/LeeSin_Q1.png",
					 Q2 = "http://static.lolskill.net/img/abilities/64/LeeSin_Q2.png",
					 W1 = "http://static.lolskill.net/img/abilities/64/LeeSin_W1.png",
					 W2 = "http://static.lolskill.net/img/abilities/64/LeeSin_W2.png",
					 E1 = "http://static.lolskill.net/img/abilities/64/LeeSin_E1.png",
					 E2 = "http://static.lolskill.net/img/abilities/64/LeeSin_E2.png",
					 R = "http://static.lolskill.net/img/abilities/64/LeeSin_R.png"
}

--Main Menu
local Menu = MenuElement({type = MENU, id = "Menu", name = "LeeSin", leftIcon = MenuIcons})
Menu:MenuElement({id = "Enabled", name = "Enabled", value = true})

--Main Menu-- Mode Setting
Menu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})
--Main Menu-- Mode Setting-- Combo
Menu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
Menu.Mode.Combo:MenuElement({id = "Q1", name = "Use Q1", value = true, leftIcon = SpellIcons.Q1})
Menu.Mode.Combo:MenuElement({id = "Q2", name = "Use Q2", value = true, leftIcon = SpellIcons.Q2})
Menu.Mode.Combo:MenuElement({id = "W1", name = "Use W1", value = true, leftIcon = SpellIcons.W1})
--Menu.Mode.Combo:MenuElement({id = "W2", name = "Use W2", value = true, leftIcon = SpellIcons.W2})
Menu.Mode.Combo:MenuElement({id = "E1", name = "Use E1", value = true, leftIcon = SpellIcons.E1})
--Menu.Mode.Combo:MenuElement({id = "E2", name = "Use E2", value = true, leftIcon = SpellIcons.E2})
Menu.Mode.Combo:MenuElement({id = "R", name = "Use R", value = true, leftIcon = SpellIcons.R})
--Main Menu-- Mode Setting-- JungleClear
Menu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "JungleClear"})
Menu.Mode.JungleClear:MenuElement({id = "Q1", name = "Use Q1", value = true, leftIcon = SpellIcons.Q1})
Menu.Mode.JungleClear:MenuElement({id = "Q2", name = "Use Q2", value = true, leftIcon = SpellIcons.Q2})
Menu.Mode.JungleClear:MenuElement({id = "W1", name = "Use W1", value = true, leftIcon = SpellIcons.W1})
Menu.Mode.JungleClear:MenuElement({id = "E1", name = "Use E1", value = true, leftIcon = SpellIcons.E1})
--Main Menu-- Mode Setting-- Flee
Menu.Mode:MenuElement({type = MENU, id = "Flee", name = "Flee"})
Menu.Mode.Flee:MenuElement({id = "W1", name = "Use W1", value = true, leftIcon = SpellIcons.W1})

--Main Menu-- Drawing 
Menu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
Menu.Drawing:MenuElement({id = "Q1", name = "Draw Q1 Range", value = true, leftIcon = SpellIcons.Q1})
Menu.Drawing:MenuElement({id = "Q2", name = "Draw Q2 Range", value = true, leftIcon = SpellIcons.Q2})
Menu.Drawing:MenuElement({id = "W1", name = "Draw W1 Range", value = true, leftIcon = SpellIcons.W1})
Menu.Drawing:MenuElement({id = "E1", name = "Draw E1 Range", value = true, leftIcon = SpellIcons.E1})
Menu.Drawing:MenuElement({id = "E2", name = "Draw E2 Range", value = true, leftIcon = SpellIcons.E2})
Menu.Drawing:MenuElement({id = "R", name = "Draw R Range", value = true, leftIcon = SpellIcons.R})

local LeeSinQ1 = 	{ name = "BlindMonkQOne" , range = 1000, 	speed = myHero:GetSpellData(_Q).speed, delay = 0.2, width = myHero:GetSpellData(_Q).width }
local LeeSinQ2 = 	{ name = "BlindMonkQTwo" , range = 1250, 	speed = myHero:GetSpellData(_Q).speed, delay = 0.2, width = myHero:GetSpellData(_Q).width }
local LeeSinW1 = 	{ name = "BlindMonkWOne" , range = 700, 	speed = myHero:GetSpellData(_W).speed, delay = 0.2, width = myHero:GetSpellData(_W).width }
local LeeSinW2 = 	{ name = "BlindMonkWTwo" , range = 300, 	speed = myHero:GetSpellData(_W).speed, delay = 0.2, width = myHero:GetSpellData(_W).width }
local LeeSinE1 = 	{ name = "BlindMonkEOne" , range = 420, 	speed = myHero:GetSpellData(_E).speed, delay = 0.2, width = myHero:GetSpellData(_E).width }
local LeeSinE2 = 	{ name = "BlindMonkETwo" , range = 575, 	speed = myHero:GetSpellData(_E).speed, delay = 0.2, width = myHero:GetSpellData(_E).width }
local LeeSinR = 	{ name = "BlindMonkRKick" , range = 375, 	speed = myHero:GetSpellData(_R).speed, delay = 0.2, width = myHero:GetSpellData(_R).width }

local function getMode()
	if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] then return "Combo" end
	if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] then return "Harass" end
	if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR] then return "LaneClear" end
	if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR] then return "JungleClear" end
	if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT] then return "LastHit" end
	if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_FLEE] then return "Flee" end
	return ""
end

function isReady (spell)
	return Game.CanUseSpell(spell) == 0 
end

function castQ1(pos)
	Control.CastSpell(HK_Q,pos)
end

function castQ2()
	Control.CastSpell(HK_Q)
end

function castW(target)
	Control.CastSpell(HK_W,target.pos)
end

function castE1() 
	Control.CastSpell(HK_E)
end

function castR(target) 
	Control.CastSpell(HK_R,target.pos)
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

function IsValidTarget(unit, range)
    return unit ~= nil and unit.valid and unit.visible and not unit.dead and unit.isTargetable and not unit.isImmortal and unit.distance <= range
end

function OnTick()

	if not Menu.Enabled:Value() then return end
	
	if myHero.dead then return end
	
	if getMode() == "Combo" then
		OnCombo()
	elseif getMode() == "Harass" then
		--onHarass()
	elseif getMode() == "LaneClear" or getMode() == "JungleClear" then
		OnClear()
	elseif getMode() == "LastHit" then
		--OnLastHit()
	elseif getMode() == "Flee" then
		OnFlee()
	end	
	
end

function OnCombo()
	local comboQ1 = Menu.Mode.Combo.Q1:Value()
	local comboQ2 = Menu.Mode.Combo.Q2:Value()
	local comboW1 = Menu.Mode.Combo.W1:Value()
	local comboE1 = Menu.Mode.Combo.E1:Value()
	local comboR = Menu.Mode.Combo.R:Value()

	target = _G.SDK.TargetSelector:GetTarget(1300)
	
	if IsValidTarget(target,LeeSinQ1.range-50) and comboQ1 and isReady(_Q) and myHero:GetSpellData(_Q).name == LeeSinQ1.name  then
		if target:GetCollision(LeeSinQ1.width,LeeSinQ1.speed,LeeSinQ1.delay) == 0 then
			local Q1pos = target:GetPrediction(LeeSinQ1.speed, LeeSinQ1.delay)
			castQ1(Q1pos)
		end
	end

	if IsValidTarget(target,LeeSinQ2.range) and comboQ2 and isReady(_Q) and myHero:GetSpellData(_Q).name == LeeSinQ2.name then
		local levelQ2 = myHero:GetSpellData(_Q).level
		local Q2dmg = ({50, 80, 110, 140, 170})[levelQ2] + 0.9 * target.totalDamage 
		if  Q2dmg >= target.health + target.hpRegen * 2 then
			castQ2()
		end
		DelayAction(function()
			if getMode() == "Combo" and myHero:GetSpellData(_Q).name == LeeSinQ2.name then
				castQ2()
			end
		end,2.8)
	end
	
	if IsValidTarget(target,LeeSinE1.range-50) and comboE1 and isReady(_E) and myHero:GetSpellData(_E).name == LeeSinE1.name then
			castE1()
	end
	
	if IsValidTarget(target,LeeSinW1.range) and myHero.health / myHero.maxHealth * 100  <= 35 and comboW1 and isReady(_W) and myHero:GetSpellData(_W).name == LeeSinW1.name then
        Control.CastSpell(HK_W, myHero)
    end
    
    if IsValidTarget(target,LeeSinR.range) and comboR and isReady(_R) and not isReady(_Q) and not isReady(_E) then
		local levelR = myHero:GetSpellData(_R).level
		local Rdmg = ({150, 300, 450})[levelR] + 2 * target.totalDamage
		if  Rdmg >= target.health + target.hpRegen * 2 then
			castR(target)
		end
	end
    
end

function OnClear()
	local JungleClearQ1 = Menu.Mode.JungleClear.Q1:Value()
	local JungleClearQ2 = Menu.Mode.JungleClear.Q2:Value()
	local JungleClearW1 = Menu.Mode.JungleClear.W1:Value()
	local JungleClearE1 = Menu.Mode.JungleClear.E1:Value()
	
	local minion = getEnemyMinions(1200)
	if minion == nil then return end
	
	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if minion.team == 300 then
			--Q1
			if IsValidTarget(minion,LeeSinQ1.range-50) and JungleClearQ1 and isReady(_Q) and myHero:GetSpellData(_Q).name == LeeSinQ1.name  then
				local Q1pos = minion:GetPrediction(LeeSinQ1.speed, LeeSinQ1.delay)
				Control.SetCursorPos(Q1pos)
				Control.CastSpell(HK_Q)
			end
			--Q2
			if IsValidTarget(minion,LeeSinQ2.range) and JungleClearQ2 and isReady(_Q) and myHero:GetSpellData(_Q).name == LeeSinQ2.name then
				DelayAction(function()
					if (getMode() == "JungleClear" or getMode() == "LaneClear") and myHero:GetSpellData(_Q).name == LeeSinQ2.name then
						castQ2()
					end
				end,2.8)
			end
			--W
			if IsValidTarget(minion,LeeSinW1.range) and myHero.health / myHero.maxHealth * 100  <= 80 and JungleClearW1 and isReady(_W) and myHero:GetSpellData(_W).name == LeeSinW1.name then
				Control.SetCursorPos(myHero)
				Control.CastSpell(HK_W)
			end
			--E
			if IsValidTarget(minion,LeeSinE1.range-50) and JungleClearE1 and isReady(_E) and myHero:GetSpellData(_E).name == LeeSinE1.name then
					castE1()
			end
		end
	end
	
end

function OnFlee()
	local fleeW1 = Menu.Mode.Flee.W1:Value()
	if  fleeW1 and isReady(_W) and myHero:GetSpellData(_W).name == LeeSinW1.name then
		for i = 1, Game.ObjectCount() do
			local target = Game.Object(i)
			if not target.isMe and IsValidTarget(target,LeeSinW1.range) and target.team == myHero.team  then
				if target.pos:DistanceTo(mousePos) <= 100 then
					Control.CastSpell(HK_W, target)
				end
			end
		end
	end
end

function OnDraw()
	--Draw Range
	if myHero.dead then return end
	if Menu.Drawing.Q1:Value() and myHero:GetSpellData(_Q).name == LeeSinQ1.name then Draw.Circle(myHero.pos,LeeSinQ1.range,1,Draw.Color(255, 0, 0, 220)) end			
	if Menu.Drawing.Q2:Value() and myHero:GetSpellData(_Q).name == LeeSinQ2.name then Draw.Circle(myHero.pos,LeeSinQ2.range,1,Draw.Color(255, 0, 0, 220)) end	
	if Menu.Drawing.W1:Value() and myHero:GetSpellData(_W).name == LeeSinW1.name then Draw.Circle(myHero.pos,LeeSinW1.range,1,Draw.Color(255, 255, 220, 0)) end			
	if Menu.Drawing.E1:Value() and myHero:GetSpellData(_E).name == LeeSinE1.name then Draw.Circle(myHero.pos,LeeSinE1.range,1,Draw.Color(220,0,255,0)) end	
	if Menu.Drawing.E2:Value() and myHero:GetSpellData(_E).name == LeeSinE2.name then Draw.Circle(myHero.pos,LeeSinE2.range,1,Draw.Color(220,0,255,0)) end	
	if Menu.Drawing.R:Value() then Draw.Circle(myHero.pos,LeeSinR.range,1,Draw.Color(220,255,0,0)) end	
end
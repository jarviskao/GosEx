class "Pantheon"

lol = 7.7
ver = 1.6

function Pantheon:__init()
	self:LoadSpells()
	self:LoadMenu()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
end

function Pantheon:LoadSpells()
	Q = { range = 600 ,speed = myHero:GetSpellData(_Q).speed, delay = 0.2, width = myHero:GetSpellData(_Q).width }
	W = { range = 600 ,speed = myHero:GetSpellData(_W).speed, delay = 0.2, width = myHero:GetSpellData(_Q).width }
	E = { range = 400 ,speed = myHero:GetSpellData(_E).speed, delay = 0.2, width = myHero:GetSpellData(_Q).width}
	R = { range = 5500 ,speed = myHero:GetSpellData(_R).speed, delay = 0.2, width = myHero:GetSpellData(_Q).width}
end

function Pantheon:LoadMenu()
	local MenuIcons = "http://static.lolskill.net/img/champions/64/pantheon.png"
	local SpellIcons = { Q = "http://static.lolskill.net/img/abilities/64/Pantheon_SpearShot.png",
						 W = "http://static.lolskill.net/img/abilities/64/Pantheon_LeapBash.png",
						 E = "http://static.lolskill.net/img/abilities/64/Pantheon_HSS.png",
	}

	--Main Menu
	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Pantheon", leftIcon = MenuIcons})

	--Main Menu-- Mode Setting
	self.Menu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})
	--Main Menu-- Mode Setting-- Combo
	self.Menu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	self.Menu.Mode.Combo:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	self.Menu.Mode.Combo:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
	self.Menu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	--Main Menu-- Mode Setting-- Harass
	self.Menu.Mode:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	self.Menu.Mode.Harass:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	self.Menu.Mode.Harass:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
	self.Menu.Mode.Harass:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	--Main Menu-- Mode Setting-- LandClear 
	self.Menu.Mode:MenuElement({type = MENU, id = "LaneClear", name = "Lane Clear"})
	self.Menu.Mode.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	self.Menu.Mode.LaneClear:MenuElement({id = "QMana", name = "Min Mana to use Q (%)", value = 80, min = 0, max = 100, step = 1, leftIcon = SpellIcons.Q})
	self.Menu.Mode.LaneClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	self.Menu.Mode.LaneClear:MenuElement({id = "EMana", name = "Min Mana to use E (%)", value = 80, min = 0, max = 100, step = 1, leftIcon = SpellIcons.E})
	--Main Menu-- Mode Setting-- Jungle 
	self.Menu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "Jungle Clear"})
	self.Menu.Mode.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	self.Menu.Mode.JungleClear:MenuElement({id = "QMana", name = "Min Mana to use Q (%)", value = 30, min = 0, max = 100, step = 1, leftIcon = SpellIcons.Q})
	self.Menu.Mode.JungleClear:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
	self.Menu.Mode.JungleClear:MenuElement({id = "WMana", name = "Min Mana to use W (%)", value = 30, min = 0, max = 100, step = 1, leftIcon = SpellIcons.W})
	self.Menu.Mode.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	self.Menu.Mode.JungleClear:MenuElement({id = "EMana", name = "Min Mana to use E (%)", value = 30, min = 0, max = 100, step = 1, leftIcon = SpellIcons.E})
	--Main Menu-- Mode Setting-- LastHit
	self.Menu.Mode:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
	self.Menu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})

	--Main Menu-- KillSteal Setting
	self.Menu:MenuElement({type = MENU, id = "KillSteal", name = "KillSteal Settings"})
	self.Menu.KillSteal:MenuElement({id = "Q", name = "Use Q to KS", value = true})

	--Main Menu-- Drawing 
	self.Menu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
	self.Menu.Drawing:MenuElement({id = "Q", name = "Draw Q Range", value = true})
	self.Menu.Drawing:MenuElement({id = "W", name = "Draw W Range", value = true})
	self.Menu.Drawing:MenuElement({id = "E", name = "Draw E Range", value = true})
	self.Menu.Drawing:MenuElement({id = "R", name = "Draw R Range (MiniMap)", value = true})

end

function Pantheon:Tick()
	local Combo = (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO]) or (_G.GOS and _G.GOS:GetMode() == "Combo") 
	local Harass = (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS]) or (_G.GOS and _G.GOS:GetMode() == "Harass") 
	local Clear = (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]) or (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR]) or (_G.GOS and _G.GOS:GetMode() == "Clear") 
	local LastHit = (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT]) or (_G.GOS and _G.GOS:GetMode() == "Lasthit") 
	if Combo then
		self:Combo()
	elseif Harass then
		self:Harass()
	elseif Clear then
		self:Clear()
	elseif LastHit then
		self:LastHit()
	end
	self:KillSteal()
end

function Pantheon:HasBuff(unit, buffname)
	for i = 0, unit.buffCount do
	local buff = unit:GetBuff(i)
		if buff.name == buffname and buff.count > 0 then 
			return true
		end
	end
	return false
end

function  Pantheon:isCasting(spell)
	if Game.CanUseSpell(spell) == 8 or myHero:GetSpellData(_E).name == "PantheonECancel" then
		return  true
	end
	return false
end

function Pantheon:GetValidEnemy(range)
    for i = 1,Game.HeroCount() do
        local enemy = Game.Hero(i)
        if  enemy.team ~= myHero.team and enemy.valid and enemy.pos:DistanceTo(myHero.pos) < range then
            return true
        end
    end
    return false
end

function Pantheon:GetValidMinion(range)
    for i = 1,Game.MinionCount() do
        local minion = Game.Minion(i)
        if  minion.team ~= myHero.team and minion.valid and minion.pos:DistanceTo(myHero.pos) < range then
            return true
        end
    end
    return false
end

function Pantheon:CountEnemyMinions(range)
	local minionsCount = 0
    for i = 1,Game.MinionCount() do
        local minion = Game.Minion(i)
        if  minion.team ~= myHero.team and minion.valid and minion.pos:DistanceTo(myHero.pos) < range then
            minionsCount = minionsCount + 1
        end
    end
    return minionsCount
end

function Pantheon:isReady (spell)
	return Game.CanUseSpell(spell) == 0 
end

function Pantheon:IsValidTarget(unit,range)
    return unit ~= nil and unit.valid and unit.visible and not unit.dead and unit.isTargetable and not unit.isImmortal and unit.pos:DistanceTo(myHero.pos) <= range
end

function Pantheon:IsImmobileTarget(unit)
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff and (buff.type == 5 or buff.type == 11 or buff.type == 29 or buff.type == 24 or buff.name == "recall") and buff.count > 0 then
			return true
		end
	end
	return false	
end

function Pantheon:GetPred(unit,speed,delay)
	if self:IsImmobileTarget(unit) then
		return unit.pos
	end
	return unit:GetPrediction(speed,delay)
end

function Pantheon:Combo()

	if self:GetValidEnemy(800) == false then return end
	
	if (not _G.SDK and not _G.GOS) then return end
	
	local target =  (_G.SDK and _G.SDK.TargetSelector:GetTarget(800, _G.SDK.DAMAGE_TYPE_PHYSICAL)) or (_G.GOS and _G.GOS:GetTarget(800,"AD"))
	
	if self:IsValidTarget(target, Q.range) and self.Menu.Mode.Combo.Q:Value() and self:isReady(_Q) and not myHero.isChanneling then
		Control.CastSpell(HK_Q, target.pos)
	end

	if self:IsValidTarget(target, W.range) and self.Menu.Mode.Combo.W:Value() and self:isReady(_W) and not myHero.isChanneling and not self:isReady(_Q) then
		Control.CastSpell(HK_W, target.pos)
	end

	if self:IsValidTarget(target, E.range) and self.Menu.Mode.Combo.E:Value() and self:isReady(_E) and not myHero.isChanneling then
		local Epos = target:GetPrediction(myHero:GetSpellData(_E).speed, 0.2)
		Control.CastSpell(HK_E,Epos)
	end
	
end

function Pantheon:Harass()

	if self:GetValidEnemy(800) == false then return end
	
	if (not _G.SDK and not _G.GOS) then return end
	
	local target =  (_G.SDK and _G.SDK.TargetSelector:GetTarget(800, _G.SDK.DAMAGE_TYPE_PHYSICAL)) or (_G.GOS and _G.GOS:GetTarget(800,"AD"))
	
	if self:IsValidTarget(target, Q.range) and self.Menu.Mode.Combo.Q:Value() and self:isReady(_Q) and not myHero.isChanneling and not self:isReady(_W) then
		Control.CastSpell(HK_Q, target.pos)
	end

	if self:IsValidTarget(target, W.range) and self.Menu.Mode.Combo.W:Value() and self:isReady(_W) and not myHero.isChanneling  then
		Control.CastSpell(HK_W, target.pos)
	end

	if self:IsValidTarget(target, E.range) and self.Menu.Mode.Combo.E:Value() and self:isReady(_E) and not myHero.isChanneling then
		local Epos = self:GetPred(target,E.speed,E.delay)
		Control.CastSpell(HK_E,Epos)
	end
	
end

function Pantheon:Clear()

	if self:GetValidMinion(600) == false then return end

	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if  minion.team == 200 then
			--Q
			if self:IsValidTarget(minion, Q.range) and self.Menu.Mode.LaneClear.Q:Value() and self:isReady(_Q) and not myHero.isChanneling and (myHero.mana/myHero.maxMana > self.Menu.Mode.LaneClear.QMana:Value() / 100) then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_Q)
				Control.KeyUp(HK_Q)
				break
			end 
			--E
			if self:IsValidTarget(minion,E.range) and self.Menu.Mode.LaneClear.E:Value() and self:isReady(_E) and not myHero.isChanneling and (myHero.mana / myHero.maxMana > self.Menu.Mode.LaneClear.EMana:Value() / 100) then
				local Epos = self:GetPred(minion, E.speed, E.delay + Game.Latency()/1000)
				Control.SetCursorPos(Epos)
				Control.KeyDown(HK_E)
				Control.KeyUp(HK_E)
				break
			end
	
		elseif minion.team == 300 then
			--Q
			if self:IsValidTarget(minion, Q.range) and self.Menu.Mode.JungleClear.Q:Value() and self:isReady(_Q) and not myHero.isChanneling and (myHero.mana/myHero.maxMana > self.Menu.Mode.JungleClear.QMana:Value() / 100) then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_Q)
				Control.KeyUp(HK_Q)
				break
			end 
			--W
			if self:IsValidTarget(minion,W.range) and self.Menu.Mode.JungleClear.W:Value() and self:isReady(_W) and not myHero.isChanneling and (myHero.mana / myHero.maxMana > self.Menu.Mode.JungleClear.EMana:Value() / 100) then
				Control.SetCursorPos(minion)
				Control.KeyDown(HK_W)
				Control.KeyUp(HK_W)
				break
			end
			--E
			if self:IsValidTarget(minion,E.range) and self.Menu.Mode.JungleClear.E:Value() and self:isReady(_E) and not myHero.isChanneling and (myHero.mana / myHero.maxMana > self.Menu.Mode.JungleClear.EMana:Value() / 100) then
				local Epos = self:GetPred(minion, E.speed, E.delay + Game.Latency()/1000)
				Control.SetCursorPos(Epos)
				Control.KeyDown(HK_E)
				Control.KeyUp(HK_E)
				break
			end

		end

	end
	
end

function Pantheon:LastHit()
	if self.Menu.Mode.LastHit.Q:Value() == false then return end
	
	local level = myHero:GetSpellData(_Q).level
	if level == nil or level == 0 then return end
	
	if self:GetValidMinion(400) == false then return end

	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		local Qdmg = (({65, 105, 145, 185, 225})[level] + 1.4 * myHero.totalDamage) * ((minion.health / minion.maxHealth < 0.15) and 2 or 1)
		if minion.isEnemy and self:IsValidTarget(minion,Q.range) then
			if Qdmg >= minion.health and self:isReady(_Q) then
				Control.CastSpell(HK_Q, minion.pos)
				break
			end
		end
	end
	
end

function Pantheon:KillSteal()
	if self.Menu.KillSteal.Q:Value() == false then return end
	
	if self:GetValidEnemy(600) == false then return end
	
	local level = myHero:GetSpellData(_Q).level
	if level == nil or level == 0 then return end
	
	for i = 1, Game.HeroCount() do
		local target = Game.Hero(i)
		local Qdmg = (({65, 105, 145, 185, 225})[level] + 1.4 * myHero.totalDamage) * ((target.health / target.maxHealth < 0.15) and 2 or 1)
		if target.team ~= myHero.team and  self:IsValidTarget(target,Q.range) and self:isReady(_Q)then
			if Qdmg >= target.health + target.hpRegen * 1.5 then 
				Control.CastSpell(HK_Q,target)
				break
			end
		end
	end

end

function Pantheon:Draw()
	--Draw Range
	if myHero.dead then return end
	if self.Menu.Drawing.Q:Value() or self.Menu.Drawing.W:Value() then Draw.Circle(myHero.pos,600,1,Draw.Color(255, 255, 255, 255)) end
	if self.Menu.Drawing.E:Value() then Draw.Circle(myHero.pos,600,1,Draw.Color(255, 255, 255, 255)) end		
	if self.Menu.Drawing.R:Value() then Draw.CircleMinimap(Vector(myHero.pos),R.range,1,Draw.Color(255, 255, 255, 255)) end	
end

function OnLoad()
	if myHero.charName ~= "Pantheon" then return end
	Pantheon()
end

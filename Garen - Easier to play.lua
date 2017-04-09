class "Garen"

lol = 7.7
ver = 2.5

function Garen:__init()
	self:LoadSpells()
	self:LoadMenu()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
end

function Garen:LoadSpells()
	Q = { range = 600 }
	W = { range = 250 }
	E = { range = 300 }
	R = { range = 400 }
end

function Garen:LoadMenu()
	local MenuIcons = "http://static.lolskill.net/img/champions/64/garen.png"
	local SpellIcons = { Q = "http://vignette3.wikia.nocookie.net/leagueoflegends/images/1/17/Decisive_Strike.png",
						 W = "http://vignette1.wikia.nocookie.net/leagueoflegends/images/2/25/Courage.png",
						 E = "http://vignette2.wikia.nocookie.net/leagueoflegends/images/1/15/Judgment.png",
						 R = "http://vignette1.wikia.nocookie.net/leagueoflegends/images/c/ce/Demacian_Justice.png"
	}
	local BlockIcons = "https://www.richters.com/Issues/whitelist/nowhitelist.png"
	local RangeIcons = "http://wfarm2.dataknet.com/static/resources/icons/set51/4004fa57.png"

	--Main Menu
	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Garen", leftIcon = MenuIcons})
	
	--Main Menu-- Mode Setting
	self.Menu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})
	--Main Menu-- Mode Setting-- Combo
	self.Menu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	self.Menu.Mode.Combo:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	self.Menu.Mode.Combo:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
	self.Menu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	self.Menu.Mode.Combo:MenuElement({id = "R", name = "Use R", value = true, leftIcon = SpellIcons.R})
	--Main Menu-- Mode Setting-- LandClear 
	self.Menu.Mode:MenuElement({type = MENU, id = "LaneClear", name = "Lane Clear"})
	self.Menu.Mode.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	self.Menu.Mode.LaneClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	self.Menu.Mode.LaneClear:MenuElement({id = "EKillMinion", name = "Use E when X minions", value = 3,min = 0, max = 5, step = 1, leftIcon = SpellIcons.E})
	--Main Menu-- Mode Setting-- Jungle 
	self.Menu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "Jungle Clear"})
	self.Menu.Mode.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	self.Menu.Mode.JungleClear:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
	self.Menu.Mode.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	--Main Menu-- Mode Setting-- LastHit
	self.Menu.Mode:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
	self.Menu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})

	--Main Menu-- KillSteal Setting
	self.Menu:MenuElement({type = MENU, id = "KillSteal", name = "KillSteal Settings"})
	self.Menu.KillSteal:MenuElement({id = "R", name = "Use R to KS", value = true})
	self.Menu.KillSteal:MenuElement({type = MENU, id = "black", name = "KillSteal White List"})
	DelayAction(function()
		for i = 1, Game.HeroCount() do
			local hero = Game.Hero(i)
			if hero.isEnemy then
				self.Menu.KillSteal.black:MenuElement({id = hero.networkID, name = "Use R On: "..hero.charName, value = true})
			end
		end
	end, 15)

	--Main Menu-- Drawing 
	self.Menu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
	self.Menu.Drawing:MenuElement({id = "E", name = "Draw E Range", value = true})
	self.Menu.Drawing:MenuElement({id = "R", name = "Draw R Range", value = true})

end

function Garen:Tick()
	local Combo = (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO]) or (_G.GOS and _G.GOS:GetMode() == "Combo") 
	local Clear = (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR]) or (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_JUNGLECLEAR]) or (_G.GOS and _G.GOS:GetMode() == "Clear") 
	local LastHit = (_G.SDK and _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LASTHIT]) or (_G.GOS and _G.GOS:GetMode() == "Lasthit") 
	if Combo then
		self:Combo()
	elseif Clear then
		self:Clear()
	elseif LastHit then
		self:LastHit()
	end
	self:KillSteal()
end

function Garen:HasBuff(unit, buffname)
	for i = 0, unit.buffCount do
	local buff = unit:GetBuff(i)
		if buff.name == buffname and buff.count > 0 then 
			return true
		end
	end
	return false
end

function  Garen:isCasting(spell)
	if Game.CanUseSpell(spell) == 8 or myHero:GetSpellData(_E).name == "GarenECancel" then
		return  true
	end
	return false
end

function Garen:GetValidEnemy(range)
    for i = 1,Game.HeroCount() do
        local enemy = Game.Hero(i)
        if  enemy.team ~= myHero.team and enemy.valid and enemy.pos:DistanceTo(myHero.pos) < range then
            return true
        end
    end
    return false
end

function Garen:GetValidMinion(range)
    for i = 1,Game.MinionCount() do
        local minion = Game.Minion(i)
        if  minion.team ~= myHero.team and minion.valid and minion.pos:DistanceTo(myHero.pos) < range then
            return true
        end
    end
    return false
end

function Garen:CountEnemyMinions(range)
	local minionsCount = 0
    for i = 1,Game.MinionCount() do
        local minion = Game.Minion(i)
        if  minion.team ~= myHero.team and minion.valid and minion.pos:DistanceTo(myHero.pos) < range then
            minionsCount = minionsCount + 1
        end
    end
    return minionsCount
end

function Garen:isReady (spell)
	return Game.CanUseSpell(spell) == 0 
end

function Garen:IsValidTarget(unit,range)
    return unit ~= nil and unit.valid and unit.visible and not unit.dead and unit.isTargetable and not unit.isImmortal and unit.pos:DistanceTo(myHero.pos) <= range
end

function Garen:Combo()

	if self:GetValidEnemy(800) == false then return end
	
	if (not _G.SDK and not _G.GOS) then return end
	
	local target =  (_G.SDK and _G.SDK.TargetSelector:GetTarget(800, _G.SDK.DAMAGE_TYPE_PHYSICAL)) or (_G.GOS and _G.GOS:GetTarget(800,"AD"))
		
	if self:IsValidTarget(target,Q.range) and self.Menu.Mode.Combo.Q:Value() and self:isReady(_Q) and not self:isCasting(_E) then
		Control.CastSpell(HK_Q)
	end 
			
	if self:IsValidTarget(target,300) and self.Menu.Mode.Combo.W:Value() and self:isReady(_W) then
		Control.CastSpell(HK_W)
	end

	if  self:IsValidTarget(target,E.range) and self.Menu.Mode.Combo.E:Value() and self:isReady(_E) and not self:isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" then
		Control.CastSpell(HK_E)
	end

	if  self:IsValidTarget(target,R.range) and self.Menu.Mode.Combo.R:Value() and self:isReady(_R) then
		local level = myHero:GetSpellData(_R).level
		local Rdmg = (({175, 350, 525})[level] + (target.maxHealth - target.health) / ({3.5, 3, 2.5})[level] ) * 0.95
		if Rdmg >= target.health then
			Control.CastSpell(HK_R,target)
		end
	end

end

function Garen:Clear()

	if self:GetValidMinion(600) == false then return end

	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		if  minion.team == 200 then
			if self:IsValidTarget(minion,250) and self.Menu.Mode.LaneClear.Q:Value() and self:isReady(_Q) and not self:isCasting(_E) then
				Control.CastSpell(HK_Q)
			end 
			
			if self:IsValidTarget(minion,E.range) and self.Menu.Mode.LaneClear.E:Value() and self:isReady(_E) and not self:isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" then
				if self:CountEnemyMinions(E.range) >= self.Menu.Mode.LaneClear.EKillMinion:Value() then
					Control.CastSpell(HK_E)
				end
			end
	
		elseif minion.team == 300 then
			if self:IsValidTarget(minion,500) and self.Menu.Mode.JungleClear.Q:Value() and self:isReady(_Q) and not self:isCasting(_E) then
				Control.CastSpell(HK_Q)
			end 
					
			if self:IsValidTarget(minion,300) and self.Menu.Mode.JungleClear.W:Value() and self:isReady(_W) then
				Control.CastSpell(HK_W)
			end

			if  self:IsValidTarget(minion,E.range) and self.Menu.Mode.JungleClear.E:Value() and self:isReady(_E) and not self:isCasting(_Q) and myHero:GetSpellData(_E).name == "GarenE" then
				Control.CastSpell(HK_E)
			end

		end

	end
	
end

function Garen:LastHit()
	if self.Menu.Mode.LastHit.Q:Value() == false then return end
	
	local level = myHero:GetSpellData(_Q).level
	if level == nil or level == 0 then return end
	
	if self:GetValidMinion(400) == false then return end

	for i = 1, Game.MinionCount() do
		local minion = Game.Minion(i)
		local Qdmg = ({30, 55, 80, 105, 130})[level] + (1.4 * myHero.totalDamage)
		if self:IsValidTarget(minion,250) and minion.isEnemy then
			if Qdmg >= minion.health and self:isReady(_Q) then
				Control.CastSpell(HK_Q)
			elseif Qdmg >= minion.health and self:HasBuff(myHero,"GarenQ") then
				Control.SetCursorPos(minion.pos)
			end
		end
	end
	
end

function Garen:KillSteal()
	if self.Menu.KillSteal.R:Value() == false then return end
	
	if self:GetValidEnemy(600) == false then return end
	
	local level = myHero:GetSpellData(_R).level
	if level == nil or level == 0 then return end
	
	for i = 1, Game.HeroCount() do
		local target = Game.Hero(i)
		--Damage Reduction = total magic resistance ÷ (100 + total magic resistance)
		local Rdmg = (({175, 350, 525})[level] + (target.maxHealth - target.health) / ({3.5, 3, 2.5})[level] ) * 0.95
		if self:IsValidTarget(target,R.range) and target.team ~= myHero.team and self.Menu.KillSteal.black[target.networkID]:Value() and self:isReady(_R) then
			--PrintChat(Rdmg)
			if Rdmg >= target.health then
				Control.CastSpell(HK_R,target)
			end
		end
	end
end

function Garen:Draw()
	--Draw Range
	if myHero.dead then return end
	if self.Menu.Drawing.E:Value() then Draw.Circle(myHero.pos,325,1,Draw.Color(255, 0, 0, 220)) end			
	if self.Menu.Drawing.R:Value() then Draw.Circle(myHero.pos,400,1,Draw.Color(220,255,0,0)) end	
end

function OnLoad()
	if myHero.charName ~= "Garen" then return end
	Garen()
end

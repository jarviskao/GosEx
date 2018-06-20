--Created by Jarkao (GamingOnSteroids)
--Support All Patch version
--Require Script: IC's OrbWalker
--Require Common: Collision, Eternal Prediction or TPred or HPred
--Date: 20180620

local VERSION = 2.05
local LocalGameCanUseSpell = Game.CanUseSpell
local LocalControlCastSpell = Control.CastSpell
local LocalGameHeroCount = Game.HeroCount
local LocalGameHero = Game.Hero
local LocalGameMissileCount = Game.MissileCount
local LocalGameMissile = Game.Missile
local LocalGameMinionCount = Game.MinionCount
local LocalGameMinion = Game.Minion
local LocalGameTurretCount = Game.TurretCount
local LocalGameTurret = Game.Turret
local LocalGameIsChatOpen = Game.IsChatOpen
local LocalGameIsOnTop = Game.IsOnTop
local LocalDrawColor = Draw.Color
local LocalDrawCircle = Draw.Circle
local LocalGameLatency = Game.Latency
local COLOR_WHITE = LocalDrawColor(255, 255, 255, 255)
local LocalMathHuge = math.huge
local LocalMathMax = math.max
local LocalMathSqrt = math.sqrt
local LocalGameTimer = Game.Timer
local TargetSelector = nil
local DAMAGE_TYPE_PHYSICAL = nil
local DAMAGE_TYPE_MAGICAL = nil
local HealthPrediction = nil
local Damage = 	nil
local IncSpells = {}

class "Yasuo"

function Yasuo:__init()
	self.Q = {range = 475, speed = LocalMathHuge, width = 45, delay = 0.25}
	self.Q3 = {range = 900, speed = 1500, width = 75, delay = 0.25}
	self.W = {range = 400, speed = 500, width = 0, delay = 0.25}
	self.E = {range = 475, speed = 20, width = 0, delay = 0.05}
	self.R = {range = 1400, speed = 20, width = 0, delay = 0.25}
	self.Qdelay = function () return LocalMathMax(0.54 * ( 1 - (myHero.attackSpeed / 1.6725 * 0.55)), 0.175) end
	self:Menu()
end

function Yasuo:Menu()
	self.Icons = {	Menu = "http://static.lolskill.net/img/champions/64/yasuo.png",
					Q = "https://vignette4.wikia.nocookie.net/leagueoflegends/images/e/e5/Steel_Tempest.png",
					W = "https://vignette3.wikia.nocookie.net/leagueoflegends/images/6/61/Wind_Wall.png",
					E = "https://vignette4.wikia.nocookie.net/leagueoflegends/images/f/f8/Sweeping_Blade.png",
					R = "https://vignette1.wikia.nocookie.net/leagueoflegends/images/c/c6/Last_Breath.png",
				}
	self.Menu = MenuElement({type = MENU, id = "Menu", name = "JarKao's "..myHero.charName, leftIcon = self.Icons.Menu})

	self.Menu:MenuElement({type = MENU, id = "Key", name = "Keys Settings"})
	self.Menu.Key:MenuElement({id = "Combo", name = "Combo Key", key = 32})
	self.Menu.Key:MenuElement({id = "Harass", name = "Harass Key", key = string.byte("C")})
	self.Menu.Key:MenuElement({id = "Clear", name = "Clear Key", key = string.byte("V")})
	self.Menu.Key:MenuElement({id = "LastHit", name = "Last Hit Key", key = string.byte("X")})
	self.Menu.Key:MenuElement({id = "Flee", name = "Flee Key", key = string.byte("A")})

	self.Menu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})
	self.Menu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
	self.Menu.Mode.Combo:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q})
	self.Menu.Mode.Combo:MenuElement({id = "Q3", name = "Use Q3 (Whirlwind)", value = true, leftIcon = self.Icons.Q})
	self.Menu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E})

	self.Menu.Mode:MenuElement({type = MENU, id = "Harass", name = "Harass"})
	self.Menu.Mode.Harass:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q})

	self.Menu.Mode:MenuElement({type = MENU, id = "LaneClear", name = "LaneClear"})
	self.Menu.Mode.LaneClear:MenuElement({id = "Q", name = "Use Q (LastHit)", value = true, leftIcon = self.Icons.Q})
	self.Menu.Mode.LaneClear:MenuElement({id = "MinQ3", name = "Min Minion to use Q3", value = 3, min = 1, max = 5, step = 1, leftIcon = self.Icons.Q})
	self.Menu.Mode.LaneClear:MenuElement({id = "E", name = "Use E (LastHit)", value = true, leftIcon = self.Icons.E})
	self.Menu.Mode.LaneClear:MenuElement({id = "EUnderTurret", name = "Use E Under Turret", value = false, leftIcon = self.Icons.E})

	self.Menu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "JungleClear"})
	self.Menu.Mode.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q})
	self.Menu.Mode.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E})

	self.Menu.Mode:MenuElement({type = MENU, id = "LastHit", name = "LastHit"})
	self.Menu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q})
	self.Menu.Mode.LastHit:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E})

	self.Menu.Mode:MenuElement({type = MENU, id = "Flee", name = "Flee"})
	self.Menu.Mode.Flee:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E})

	self.Menu:MenuElement({type = MENU, id = "Pred", name = "Prediction Settings"})
	self.Menu.Pred:MenuElement({ id = "PredSelected", name = "Prediction", value = 1, drop = { "Eternal Pred", "TPred", "HPred"}, onclick = function() PrintChat("[Yasuo] Reload if you have changed the Prediction.") end})
	
	self.Menu:MenuElement({id = "KillSteal", name = "Auto KillSteal", type = MENU})
	self.Menu.KillSteal:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q})
	self.Menu.KillSteal:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E})

	self.Menu:MenuElement({id = "AutoW", name = "Auto Windwall", type = MENU})
	self.Menu.AutoW:MenuElement({id = "W", name = "Use W", value = true, leftIcon = self.Icons.W})
	self.Menu.AutoW:MenuElement({id = "blank", type = SPACE , name = "Compatible with Evade"})

	self.Menu:MenuElement({id = "AutoHarass", name = "Auto Harass", type = MENU})
	self.Menu.AutoHarass:MenuElement({id = "Q", name = "Use Q on Enemy", value = true, leftIcon = self.Icons.Q})

	self.Menu:MenuElement({id = "AutoR", name = "Auto R", type = MENU})
	self.Menu.AutoR:MenuElement({id = "R", name = "Use R", value = true, leftIcon = self.Icons.R})
	self.Menu.AutoR:MenuElement({id = "MinR", name = "Min Enemy to use R", value = 2, min = 1, max = 5, step = 1, leftIcon = self.Icons.R})

	self.Menu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
	self.Menu.Drawing:MenuElement({id = "Disable", name = "Disable All Drawings", value = true})

	self.Menu.Drawing:MenuElement({id = "Q", name = "Draw Q Range", type = MENU, leftIcon = self.Icons.Q})
	self.Menu.Drawing.Q:MenuElement({id = "Enabled", name = "Enabled", value = true})
	self.Menu.Drawing.Q:MenuElement({id = "Width", name = "Width", value = 2, min = 1, max = 5, step = 1})
	self.Menu.Drawing.Q:MenuElement({id = "Color", name = "Color", color = COLOR_WHITE})

	self.Menu.Drawing:MenuElement({id = "W", name = "Draw W Range", type = MENU, leftIcon = self.Icons.W})
	self.Menu.Drawing.W:MenuElement({id = "Enabled", name = "Enabled", value = true})
	self.Menu.Drawing.W:MenuElement({id = "Width", name = "Width", value = 2, min = 1, max = 5, step = 1})
	self.Menu.Drawing.W:MenuElement({id = "Color", name = "Color", color = COLOR_WHITE})

	self.Menu.Drawing:MenuElement({id = "E", name = "Draw E Range", type = MENU, leftIcon = self.Icons.E})
	self.Menu.Drawing.E:MenuElement({id = "Enabled", name = "Enabled", value = true})
	self.Menu.Drawing.E:MenuElement({id = "Width", name = "Width", value = 2, min = 1, max = 5, step = 1})
	self.Menu.Drawing.E:MenuElement({id = "Color", name = "Color", color = COLOR_WHITE})

	self.Menu.Drawing:MenuElement({id = "R", name = "Draw R Range", type = MENU, leftIcon = self.Icons.R})
	self.Menu.Drawing.R:MenuElement({id = "Enabled", name = "Enabled", value = true})
	self.Menu.Drawing.R:MenuElement({id = "Width", name = "Width", value = 2, min = 1, max = 5, step = 1})
	self.Menu.Drawing.R:MenuElement({id = "Color", name = "Color", color = COLOR_WHITE})

	self:GetLib()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
end

function Yasuo:GetLib()
	require "Collision"
	self.QCollision = Collision:SetSpell(self.Q3.range, self.Q3.speed, self.Q3.delay, self.Q3.width, true)
	
	self.PredictionMode = self.Menu.Pred.PredSelected:Value()
	if self.PredictionMode == 1 then
		self.Menu.Pred:MenuElement({ id = "EPredQ", name = "Q HitChance", value = 0.22, min = 0.15, max = 0.3, step = 0.005, leftIcon = self.Icons.Q})
		require "Eternal Prediction"
		self.QPred = Prediction:SetSpell(self.Q, TYPE_LINE, true)
	elseif self.PredictionMode == 2 then
		self.Menu.Pred:MenuElement({ id = "TPredQ", name = "Q HitChance", value = 2, min = 2, max = 5, step = 1, leftIcon = self.Icons.Q})
		require "TPred"
	elseif self.PredictionMode == 3 then
		self.Menu.Pred:MenuElement({ id = "HPredQ", name = "Q HitChance", value = 2, min = 2, max = 5, step = 1, leftIcon = self.Icons.Q})
		require "HPred"
	end
	
end

function Yasuo:Draw()
	--PrintChat(self.Q.delay)
	if myHero.dead or LocalGameIsChatOpen() or not LocalGameIsOnTop() then return end

	if self.Menu.Drawing.Disable:Value() then return end

	if self.Menu.Drawing.Q.Enabled:Value()then
		LocalDrawCircle(myHero.pos, myHero:GetSpellData(_Q).range, self.Menu.Drawing.Q.Width:Value(), self.Menu.Drawing.Q.Color:Value())
	end

	if self.Menu.Drawing.W.Enabled:Value()then
		LocalDrawCircle(myHero.pos, myHero:GetSpellData(_W).range, self.Menu.Drawing.W.Width:Value(), self.Menu.Drawing.W.Color:Value())
	end

	if self.Menu.Drawing.E.Enabled:Value()then
		LocalDrawCircle(myHero.pos, myHero:GetSpellData(_E).range, self.Menu.Drawing.E.Width:Value(), self.Menu.Drawing.E.Color:Value())
	end

	if self.Menu.Drawing.R.Enabled:Value()then
		LocalDrawCircle(myHero.pos, myHero:GetSpellData(_R).range, self.Menu.Drawing.R.Width:Value(), self.Menu.Drawing.R.Color:Value())
	end

end

function Yasuo:Tick()

	if myHero.dead or LocalGameIsChatOpen() or not LocalGameIsOnTop() then return end

	self:AutoR()

	self:KillSteal()

	if ExtLibEvade and ExtLibEvade.Evading then return end

	self:AutoW()

	if self.Menu.Key.Combo:Value() == false then
		self:AutoHarass()
	end

	if IsAutoAttacking(myHero) or IsCastingSpell(myHero) then return end

	if self.Menu.Key.Combo:Value() then
		self:OnCombo()
	elseif self.Menu.Key.Harass:Value() then
		self:OnHarass()
	elseif self.Menu.Key.Clear:Value() then
		self:OnClear()
	elseif self.Menu.Key.LastHit:Value() then
		self:OnLastHit()
	elseif self.Menu.Key.Flee:Value() then
		self:OnFlee()
	end

end

function Yasuo:OnCombo()
	--Q Logic
	if LocalGameCanUseSpell(_Q) == READY then
		if self.Menu.Mode.Combo.Q:Value() and not IsAutoAttacking(myHero) then
			--Q3
			if self.Menu.Mode.Combo.Q3:Value() and HasBuff(myHero, "YasuoQ3W") then	
				local target = TargetSelector:GetTarget(self.Q3.range, DAMAGE_TYPE_PHYSICAL)
				if target then
					local costPos = target:GetPrediction(self.Q3.speed, self.Q3.delay)
					LocalControlCastSpell(HK_Q, costPos)
				end
			else
			--Q1
     			local target = TargetSelector:GetTarget(self.Q.range + 35, DAMAGE_TYPE_PHYSICAL)
      			if target then
      				self:CastQ(myHero, target)
				end
			end
		end
	end

	--E Logic
	if LocalGameCanUseSpell(_E) == READY then
		if self.Menu.Mode.Combo.E:Value() and not IsAutoAttacking(myHero) then
			local target = TargetSelector:GetTarget(475, DAMAGE_TYPE_PHYSICAL)
			if target then
				if HasBuff(target, "YasuoDashWrapper") then
					local EnemyMinions = GetEnemyMinions(self.E.range)
					for i = 1, #EnemyMinions do
						local minion = EnemyMinions[i]
						if HasBuff(minion, "YasuoDashWrapper") == false then 
							local posTo = GetPosTo(minion)
							local afterEPos = myHero.pos + Vector(myHero.pos, posTo):Normalized() * 475
							if GetDistanceSqr(afterEPos, target.pos) < (myHero.range + myHero.boundingRadius + target.boundingRadius - 35) ^ 2 then
								LocalControlCastSpell(HK_E, minion)
								break 
							end
						end
					end
				else
					local posTo = GetPosTo(target)
					local afterEPos = myHero.pos + Vector(myHero.pos, posTo):Normalized() * 475
					if GetDistanceSqr(afterEPos, posTo) < (myHero.range + myHero.boundingRadius + target.boundingRadius - 35) ^ 2 then
						LocalControlCastSpell(HK_E, target)
					end
				end
			else
				target = TargetSelector:GetTarget(self.E.range * 2 , DAMAGE_TYPE_PHYSICAL)
				if target then
					if HasBuff(target, "YasuoDashWrapper") then
						local EnemyMinions = GetEnemyMinions(self.E.range * 2)
						for i = 1, #EnemyMinions do
							local minion = EnemyMinions[i]
							if GetDistanceSqr(myHero.pos, minion.pos) < self.E.range ^ 2 and HasBuff(minion, "YasuoDashWrapper") == false then 
								local posTo = GetPosTo(minion)
								local afterEPos = myHero.pos + Vector(myHero.pos, posTo):Normalized() * 475
								if GetDistanceSqr(afterEPos, target.pos) < (myHero.range + myHero.boundingRadius + target.boundingRadius - 35) ^ 2 then
									LocalControlCastSpell(HK_E, minion)
									break 
								end
							end
						end
					else
						local EnemyMinions = GetEnemyMinions(self.E.range * 2)
						for i = 1, #EnemyMinions do
							local minion = EnemyMinions[i];
							if GetDistanceSqr(myHero, minion) < self.E.range ^ 2 and HasBuff(minion, "YasuoDashWrapper") == false then 
								local posTo = GetPosTo(minion)
								local afterEPos = myHero.pos + Vector(myHero.pos, posTo):Normalized() * 475
								if GetDistanceSqr(afterEPos, target.pos) < self.E.range ^ 2 then
									LocalControlCastSpell(HK_E, minion)
									break 
								end
							end
						end
					end
				end
			end
		end
	end

end

function Yasuo:OnHarass()
	--Q Logic
	if LocalGameCanUseSpell(_Q) == READY then
		if self.Menu.Mode.Harass.Q:Value() and not IsAutoAttacking(myHero) then
			--Q3
			if HasBuff(myHero, "YasuoQ3W") then	
				local target = TargetSelector:GetTarget(self.Q3.range, DAMAGE_TYPE_PHYSICAL)
				if target then
					local costPos = target:GetPrediction(self.Q3.speed, self.Q3.delay)
					LocalControlCastSpell(HK_Q, costPos)
				end
			else
			--Q1
     			local target = TargetSelector:GetTarget(self.Q.range + 35, DAMAGE_TYPE_PHYSICAL)
      			if target then
      				self:CastQ(myHero, target)
				end
			end
		end
	end
end

function Yasuo:OnClear()
	
	if LocalGameCanUseSpell(_Q) == READY then
		--Lane Q Logic
		if self.Menu.Mode.LaneClear.Q:Value() and not IsAutoAttacking(myHero) then
			--Q3
			if HasBuff(myHero, "YasuoQ3W") then	
				local EnemyMinions = GetEnemyMinions(self.Q3.range)
				if #EnemyMinions >= self.Menu.Mode.LaneClear.MinQ3:Value() then
					for i = 1, #EnemyMinions do
						local minion = EnemyMinions[i]
						local costPos = minion:GetPrediction(self.Q3.speed, self.Q3.delay)
						local Block, blockingUnits = self.QCollision:__GetMinionCollision(myHero, costPos, 3)
						if #blockingUnits >= self.Menu.Mode.LaneClear.MinQ3:Value() then
							LocalControlCastSpell(HK_Q, costPos)
							break
						end
					end
				end
			else
			--Q1
				local EnemyMinions = GetEnemyMinions(self.Q.range + 35)
				for i = 1, #EnemyMinions do
					local minion = EnemyMinions[i]
					local hp = HealthPrediction:GetPrediction(minion, self.Qdelay())
					local Qdmg = ({20, 45, 70, 95, 120})[myHero:GetSpellData(_Q).level] + myHero.totalDamage
					if  hp > 0 and hp <= Damage:CalculateDamage(myHero, minion, DAMAGE_TYPE_PHYSICAL, Qdmg) then
						self:CastQ(myHero, minion)
						break
					end
				end
			end
		end

		--Jungle Q Logic
		if self.Menu.Mode.JungleClear.Q:Value() and not IsAutoAttacking(myHero) then
			local Monsters = GetMonsters(self.Q.range + 35)
			for i = 1, #Monsters do
				local minion = Monsters[i]
				self:CastQ(myHero, minion)
				break
			end
		end
	end

	if LocalGameCanUseSpell(_E) == READY then
		--Lane E Logic
		if self.Menu.Mode.LaneClear.E:Value() and not IsAutoAttacking(myHero) then
			local EnemyMinions = GetEnemyMinions(self.E.range)
			for i = 1, #EnemyMinions do
				local minion = EnemyMinions[i]
				if HasBuff(minion, "YasuoDashWrapper") == false then
					--Last Hit
					local hp = HealthPrediction:GetPrediction(minion, GetDistance(myHero.pos, minion.pos) * 0.00005)
					local Edmg = ({60, 70, 80, 90, 100})[myHero:GetSpellData(_E).level] + 0.2 * myHero.bonusDamage + 0.6 * myHero.ap
					if  hp > 0 and hp <= Damage:CalculateDamage(myHero, minion, DAMAGE_TYPE_MAGICAL, Edmg) then
						if self.Menu.Mode.LaneClear.EUnderTurret:Value() then
							LocalControlCastSpell(HK_E, minion)
							break
						else
							local afterEPos = myHero.pos + Vector(myHero.pos, minion.pos):Normalized() * 475
							if IsUnderTurret(afterEPos) == false then
								LocalControlCastSpell(HK_E, minion)
								break
							end
						end
					end
				end
			end
		end

		--Jungle E Logic
		if self.Menu.Mode.JungleClear.E:Value() and not IsAutoAttacking(myHero) then
			local Monsters = GetMonsters(self.E.range)
			for i = 1, #Monsters do
				local minion = Monsters[i]
				if HasBuff(minion, "YasuoDashWrapper") == false then 
					--Last Hit
					local hp = HealthPrediction:GetPrediction(minion, GetDistance(myHero.pos, minion.pos) * 0.00005)
					local Edmg = ({60, 70, 80, 90, 100})[myHero:GetSpellData(_E).level] + 0.2 * myHero.bonusDamage + 0.6 * myHero.ap
					if  hp > 0 and hp <= Damage:CalculateDamage(myHero, minion, DAMAGE_TYPE_MAGICAL, Edmg) then
						LocalControlCastSpell(HK_E, minion)
						break
					end
					--After E can AA minion
					local afterEPos = myHero.pos + Vector(myHero.pos, minion.pos):Normalized() * 475
					if GetDistanceSqr(afterEPos, minion.pos) < (myHero.range + myHero.boundingRadius + minion.boundingRadius - 30) ^ 2 then
						LocalControlCastSpell(HK_E, minion)
						break
					end
				end
			end
		end
	end

end

function Yasuo:OnLastHit()

	if LocalGameCanUseSpell(_Q) == READY then
		--Lane Q Logic
		if self.Menu.Mode.LastHit.Q:Value() and not IsAutoAttacking(myHero) then
			--Q1
			if HasBuff(myHero, "YasuoQ3W") == false then	
				local EnemyMinions = GetEnemyMinions(self.Q.range + 35)
				for i = 1, #EnemyMinions do
					local minion = EnemyMinions[i]
					local hp = HealthPrediction:GetPrediction(minion, self.Qdelay())
					local Qdmg = ({20, 45, 70, 95, 120})[myHero:GetSpellData(_Q).level] + myHero.totalDamage
					if  hp > 0 and hp <= Damage:CalculateDamage(myHero, minion, DAMAGE_TYPE_PHYSICAL, Qdmg) then
						self:CastQ(myHero, minion)
						break
					end
				end
			end
		end
	end

	if LocalGameCanUseSpell(_E) == READY then
		--Lane E Logic
		if self.Menu.Mode.LastHit.E:Value() and not IsAutoAttacking(myHero) then
			local EnemyMinions = GetEnemyMinions(self.E.range)
			for i = 1, #EnemyMinions do
				local minion = EnemyMinions[i]
				if HasBuff(minion, "YasuoDashWrapper") == false then
					--Last Hit
					local hp = HealthPrediction:GetPrediction(minion, GetDistance(myHero.pos, minion.pos) * 0.00005)
					local Edmg = ({60, 70, 80, 90, 100})[myHero:GetSpellData(_E).level] + 0.2 * myHero.bonusDamage + 0.6 * myHero.ap
					if  hp > 0 and hp <= Damage:CalculateDamage(myHero, minion, DAMAGE_TYPE_MAGICAL, Edmg) then
						local afterEPos = myHero.pos + Vector(myHero.pos, minion.pos):Normalized() * 475
						if IsUnderTurret(afterEPos) == false then
							LocalControlCastSpell(HK_E, minion)
							break
						end
					end
				end
			end
		end
	end
	
end

function Yasuo:OnFlee()
	--E Logic
	if self.Menu.Mode.Flee.E:Value() and LocalGameCanUseSpell(_E) == READY then
		local EnemyMinions = GetEnemyMinions(self.E.range)
		for i = 1, #EnemyMinions do
			local minion = EnemyMinions[i]
			if HasBuff(minion, "YasuoDashWrapper") == false then
				if  GetDistanceSqr(minion.pos, mousePos) < GetDistanceSqr(myHero.pos, mousePos) then
					LocalControlCastSpell(HK_E, minion)
					break
				end
			end
		end
	end
end

function Yasuo:AutoHarass()
	if self.Menu.AutoHarass.Q:Value() and LocalGameCanUseSpell(_Q) == READY then
		local EnemyHeroes = GetEnemyHeroes(self.Q.range + 35)
		for i = 1, #EnemyHeroes do
			local hero = EnemyHeroes[i]
			if HasBuff(myHero, "YasuoQ3W") == false then
				if IsUnderTurret(myHero.pos) == false then	
					self:CastQ(myHero, hero)
					break
				end
			end
		end
	end
end

function Yasuo:KillSteal()

	if self.Menu.KillSteal.Q:Value() and LocalGameCanUseSpell(_Q) == READY then
		local EnemyHeroes = GetEnemyHeroes(self.Q.range + 35)
		for i = 1, #EnemyHeroes do
			local hero = EnemyHeroes[i]
			if HasBuff(myHero, "YasuoQ3W") == false then
				local hp = HealthPrediction:GetPrediction(hero, self.Qdelay())
				local Qdmg = ({20, 45, 70, 95, 120})[myHero:GetSpellData(_Q).level] + myHero.totalDamage
				if hp > 0 and hp <= Damage:CalculateDamage(myHero, hero, DAMAGE_TYPE_PHYSICAL, Qdmg) then
					self:CastQ(myHero, hero)
				end
			end
		end
	end

	if self.Menu.KillSteal.E:Value() and LocalGameCanUseSpell(_E) == READY then
		local EnemyHeroes = GetEnemyHeroes(self.E.range)
		for i = 1, #EnemyHeroes do
			local hero = EnemyHeroes[i]
			if HasBuff(hero, "YasuoDashWrapper") == false then
				local Edmg = ({60, 70, 80, 90, 100})[myHero:GetSpellData(_E).level] + 0.2 * myHero.bonusDamage + 0.6 * myHero.ap
				if hero.health <= Damage:CalculateDamage(myHero, hero, DAMAGE_TYPE_MAGICAL, Edmg) then
					LocalControlCastSpell(HK_E, hero)
				end
			end
		end
	end

end

function Yasuo:AutoR()
	if self.Menu.AutoR.R:Value() and LocalGameCanUseSpell(_R) == READY then
		local EnemyHeroes = GetEnemyHeroes(self.R.range + 150)
		if #EnemyHeroes >= self.Menu.AutoR.MinR:Value() then
			local count = 0
			for i = 1, #EnemyHeroes do
				local hero = EnemyHeroes[i]
				if self:isKnockedUp(hero) then
					count = count + 1
				end
				if count >= self.Menu.AutoR.MinR:Value() then
					LocalControlCastSpell(HK_R)
					break
				end
			end
		end
	end
end

function Yasuo:isKnockedUp(unit)
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff ~= nil and buff.count > 0 then
			if buff.type == 29 or buff.type == 30 or buff.type == 39 then
				local CurrentTime = LocalGameTimer()
				if buff.startTime <= CurrentTime and buff.expireTime >= CurrentTime then
					return true
				end
			end
		end
	end
	return false
end

function OnTick()
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i);
		if hero.isEnemy then
			if hero.activeSpell.valid and hero.isChanneling then
				if hero.activeSpell.width > 0 and hero.activeSpell.range > 0  and hero.activeSpell.speed > 0 then
					if IncSpells[hero.networkID] == nil then
						IncSpells[hero.networkID] = {	sPos 		= 	hero.activeSpell.startPos, 
														ePos 		= 	hero.activeSpell.startPos + Vector(hero.activeSpell.startPos, hero.activeSpell.placementPos):Normalized() * hero.activeSpell.range, 
														radius 		= 	hero.activeSpell.width, 
														speed 		= 	hero.activeSpell.speed, 
														castEndTime = 	hero.activeSpell.castEndTime,
														endTime 	= 	hero.activeSpell.endTime,
													}
					end
				end
			end
		end
	end

end

function Yasuo:AutoW()

	for key, v in pairs(IncSpells) do
		if LocalGameTimer() >= v.endTime then IncSpells[key] = nil break end

		if LocalGameTimer() >= v.castEndTime then
			local spellOnMe = v.sPos + Vector(v.sPos,v.ePos):Normalized() * GetDistance(myHero.pos,v.sPos)
			local spellPos = v.sPos + Vector(v.sPos,v.ePos):Normalized() * (v.speed * (LocalGameTimer() - v.castEndTime) * 3)
			local dodgeHere = spellPos + Vector(v.sPos,v.ePos):Normalized() * (v.speed * 0.15)
			if GetDistanceSqr(spellOnMe,spellPos) <= GetDistanceSqr(dodgeHere,spellPos) and GetDistance(spellOnMe,v.sPos) - v.radius - myHero.boundingRadius <= GetDistance(v.sPos,v.ePos) then
				if GetDistanceSqr(myHero.pos,spellOnMe) < (v.radius + myHero.boundingRadius) ^ 2 then
					if LocalGameCanUseSpell(_W) == READY and self.Menu.AutoW.W:Value() then
						local castPos = myHero.pos + Vector(myHero.pos,v.sPos):Normalized() * 100
						LocalControlCastSpell(HK_W, castPos)
					end
				end
			end
		end

	end

end

function Yasuo:CastQ(source, target)
	if self.PredictionMode == 1 then
		local pred = self.QPred:GetPrediction(target, source.pos)
		if pred and pred.hitChance >= self.Menu.Pred.EPredQ:Value() then
			LocalControlCastSpell(HK_Q, pred.castPos)
		end
	elseif self.PredictionMode == 2 then
		local castpos,HitChance, pos = TPred:GetBestCastPosition(target, self.Qdelay(), self.Q.width, self.Q.range, self.Q.speed, source.pos, false, "line")
		if HitChance >= self.Menu.Pred.TPredQ:Value() then
			LocalControlCastSpell(HK_Q, castpos)
		end
	elseif self.PredictionMode == 3 then
		local hitChance, aimPosition = HPred:GetHitchance(source.pos, target, self.Q.range, self.Qdelay(), self.Q.speed, self.Q.width, false)
		if hitChance >= self.Menu.Pred.HPredQ:Value() then
			LocalControlCastSpell(HK_Q, aimPosition)
		end
	end
end

function IsUnderTurret(pos)
	local EnemyTurrets = GetEnemyTurrets(2000)
	for i = 1, #EnemyTurrets do
		local turret = EnemyTurrets[i]
		if GetDistanceSqr(pos, turret.pos) <= (760 + turret.boundingRadius + myHero.boundingRadius) ^ 2 then
			return true
		end
	end
	return false
end

function VectorPointProjectionOnLineSegment(v1, v2, v)
    local cx, cy, ax, ay, bx, by = v.x, (v.z or v.y), v1.x, (v1.z or v1.y), v2.x, (v2.z or v2.y)
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) ^ 2 + (by - ay) ^ 2)
    local pointLine = { x = ax + rL * (bx - ax), y = ay + rL * (by - ay) }
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or { x = ax + rS * (bx - ax), y = ay + rS * (by - ay) }
    return pointSegment, pointLine, isOnSegment
end

function HasBuff(unit, buffName)
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff ~= nil and buff.count > 0 then
			if buff.name == buffName then
				local CurrentTime = LocalGameTimer()
				if buff.startTime <= CurrentTime and buff.expireTime >= CurrentTime then
					return true
				end
			end
		end
	end
	return false
end

function GetDistanceSqr(a, b)
	if a.pos ~= nil then
		a = a.pos;
	end
	if b.pos ~= nil then
		b = b.pos;
	end
	if a.z ~= nil and b.z ~= nil then
		local x = (a.x - b.x)
		local z = (a.z - b.z)
		return x * x + z * z
	else
		local x = (a.x - b.x)
		local y = (a.y - b.y)
		return x * x + y * y
	end
end

function GetDistance(a, b)
	return LocalMathSqrt(GetDistanceSqr(a, b))
end

function IsAutoAttack(name)
	return name:lower():find("attack")
end

function IsAutoAttacking(unit)
	if unit.activeSpell.valid then
		if unit.activeSpell.target > 0 then
			return IsAutoAttack(unit.activeSpell.name);
		end
	end
	return false;
end

function IsCastingSpell(unit)
	if unit.activeSpell.valid then
		return unit.isChanneling;
	end
	return false;
end

function GetEnemyTurrets(range)
	local result = {}
	local counter = 1
	for i = 1, LocalGameTurretCount() do
		local turret = LocalGameTurret(i);
		if turret.isEnemy and turret.alive and turret.visible and turret.isTargetable then
			if GetDistanceSqr(myHero, turret) <= range * range then
				result[counter] = turret
				counter = counter + 1
			end
		end
	end
	return result
end

function GetEnemyMinions(range)
	local result = {}
	local counter = 1
	for i = 1, LocalGameMinionCount() do
		local minion = LocalGameMinion(i);
		if minion.isEnemy and minion.team ~= 300 and minion.valid and minion.alive and minion.visible and minion.isTargetable then
			if GetDistanceSqr(myHero, minion) <= range * range then
				result[counter] = minion
				counter = counter + 1
			end
		end
	end
	return result
end

function GetMonsters(range)
	local result = {}
	local counter = 1
	for i = 1, LocalGameMinionCount() do
		local minion = LocalGameMinion(i);
		if minion.isEnemy and minion.team == 300 and minion.valid and minion.alive and minion.visible and minion.isTargetable then
			if GetDistanceSqr(myHero, minion) <= range * range then
				result[counter] = minion
				counter = counter + 1
			end
		end
	end
	return result
end

function GetEnemyHeroes(range)
	local result = {}
	local counter = 1
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i)
		if hero.isEnemy and hero.valid and hero.alive and hero.visible and hero.isTargetable then
			if GetDistanceSqr(myHero, hero) <= range * range then
				result[counter] = hero
				counter = counter + 1
			end
		end
	end
	return result
end

function GetPosTo(unit)
	local Origin = unit.pos
	local Waypoint = unit.posTo
	return Waypoint == Origin and Origin or Origin + Vector(Origin, Waypoint):Normalized() * (GetDistance(myHero.pos, Origin) * 0.00005 + LocalGameLatency() * 0.002) * unit.ms
end

function OnLoad()
	if myHero.charName ~= "Yasuo" then return end
	DelayAction(function ()
		OnGameStart()
		PrintChat("JarKao's Yasuo v" .. VERSION .. " is loading.")
	end, 5)
end

function OnGameStart()
	TargetSelector 			= 	_G.SDK.TargetSelector
	DAMAGE_TYPE_PHYSICAL	=	_G.SDK.DAMAGE_TYPE_PHYSICAL
	DAMAGE_TYPE_MAGICAL 	= 	_G.SDK.DAMAGE_TYPE_MAGICAL
	HealthPrediction 		= 	_G.SDK.HealthPrediction
	Damage 					= 	_G.SDK.Damage
	Yasuo()
end
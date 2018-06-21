--Created by Jarkao (GamingOnSteroids)
--Support All Patch version
--Require Script: IC's OrbWalker
--Require Common: N/A
--Date: 20180621

local VERSION = 1.0
local LocalGameCanUseSpell	= Game.CanUseSpell
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
local COLOR_WHITE = LocalDrawColor(255, 255, 255, 255)
local LocalMathHuge	= math.huge
local LocalMathSqrt = math.sqrt
local LocalGameTimer = Game.Timer
local _Q	= _Q;
local _W	= _W;
local _E	= _E;
local _R	= _R;
local READY 		= READY;
local TargetSelector 		= nil;
local DAMAGE_TYPE_PHYSICAL 	= nil;
local DAMAGE_TYPE_MAGICAL 	= nil;
local Damage 				= nil;
local IncSpells = {};

class "Garen"

function Garen:__init()
	self.Q = {range = 500, delay = 0.05};
	self.W = {range = 250, delay = 0.05};
	self.E = {range = 300, delay = 0.05};
	self.R = {range = 400, delay = 0.25};
	self.Orbwalker = true;
	self:Menu();
end

function Garen:Menu()
	self.Icons = {	Menu = "http://static.lolskill.net/img/champions/64/garen.png",
					Q = "http://vignette3.wikia.nocookie.net/leagueoflegends/images/1/17/Decisive_Strike.png",
					W = "http://vignette1.wikia.nocookie.net/leagueoflegends/images/2/25/Courage.png",
					E = "http://vignette2.wikia.nocookie.net/leagueoflegends/images/1/15/Judgment.png",
					R = "http://vignette1.wikia.nocookie.net/leagueoflegends/images/c/ce/Demacian_Justice.png",
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
	self.Menu.Mode.Combo:MenuElement({id = "W", name = "Use W", value = true, leftIcon = self.Icons.W})
	self.Menu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E})
	self.Menu.Mode.Combo:MenuElement({id = "R", name = "Use R", value = true, leftIcon = self.Icons.R})

	self.Menu.Mode:MenuElement({type = MENU, id = "LaneClear", name = "LaneClear"})
	self.Menu.Mode.LaneClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E})
	self.Menu.Mode.LaneClear:MenuElement({id = "MinE", name = "Min Minion to use E", value = 3, min = 1, max = 5, step = 1, leftIcon = self.Icons.E})
	
	self.Menu.Mode:MenuElement({type = MENU, id = "JungleClear", name = "JungleClear"});
	--self.Menu.Mode.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q});
	self.Menu.Mode.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = self.Icons.E});

	self.Menu.Mode:MenuElement({type = MENU, id = "LastHit", name = "LastHit"})
	self.Menu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q}) 

	self.Menu.Mode:MenuElement({type = MENU, id = "Flee", name = "Flee"})
	self.Menu.Mode.Flee:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = self.Icons.Q}) 

	self.Menu:MenuElement({id = "AutoW", name = "Auto W", type = MENU})
	self.Menu.AutoW:MenuElement({id = "W", name = "Use W", value = true, leftIcon = self.Icons.W}) 

	self.Menu:MenuElement({type = MENU, id = "KillSteal", name = "Auto KillSteal"})
	self.Menu.KillSteal:MenuElement({id = "R", name = "Use R", value = true, leftIcon = self.Icons.R})

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

	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
end

function Garen:Draw()
	if myHero.dead or self.Menu.Drawing.Disable:Value() or LocalGameIsChatOpen() or not LocalGameIsOnTop() then return end

	if self.Menu.Drawing.Q.Enabled:Value()then
		LocalDrawCircle(myHero.pos, self.Q.range, self.Menu.Drawing.Q.Width:Value(), self.Menu.Drawing.Q.Color:Value())
	end

	if self.Menu.Drawing.W.Enabled:Value()then
		LocalDrawCircle(myHero.pos, self.W.range, self.Menu.Drawing.W.Width:Value(), self.Menu.Drawing.W.Color:Value())
	end

	if self.Menu.Drawing.E.Enabled:Value()then
		LocalDrawCircle(myHero.pos, myHero:GetSpellData(_E).range, self.Menu.Drawing.E.Width:Value(), self.Menu.Drawing.E.Color:Value())
	end

	if self.Menu.Drawing.R.Enabled:Value()then
		LocalDrawCircle(myHero.pos, myHero:GetSpellData(_R).range, self.Menu.Drawing.R.Width:Value(), self.Menu.Drawing.R.Color:Value())
	end

end

function Garen:Tick()
	if myHero.dead or LocalGameIsChatOpen() or not LocalGameIsOnTop() then return end

	self:KillSteal();

	if ExtLibEvade and ExtLibEvade.Evading then return end

	self:AutoW();

	if IsAutoAttacking(myHero) then return end

	if self.Menu.Key.Combo:Value() then
		self:OnCombo();
	elseif self.Menu.Key.Clear:Value() then
		self:OnClear();
	elseif self.Menu.Key.LastHit:Value() then
		self:OnLastHit();
	elseif self.Menu.Key.Flee:Value() then
		self:OnFlee();
	end

	if self.Orbwalker then
		if HasBuff(myHero, "GarenE") then
			Orbwalker:SetAttack(false);
			self.Orbwalker = false;
		end
	else
		if HasBuff(myHero, "GarenE") == false then
			Orbwalker:SetAttack(true);
			self.Orbwalker = true;
		end
	end

end

function Garen:OnCombo()
	--Q Logic
	if self.Menu.Mode.Combo.Q:Value() and not IsAutoAttacking(myHero) then
		if LocalGameCanUseSpell(_Q) == READY then
			if HasBuff(myHero, "GarenE") == false then	
				local target = TargetSelector:GetTarget(self.Q.range, DAMAGE_TYPE_PHYSICAL)
				if target then
					LocalControlCastSpell(HK_Q)
				end
			end
		end
	end

	--E Logic
	if self.Menu.Mode.Combo.E:Value() and not IsAutoAttacking(myHero) then
		if LocalGameCanUseSpell(_E) == READY then
			if HasBuff(myHero, "GarenE") == false  then	
				local target = TargetSelector:GetTarget(self.E.range, DAMAGE_TYPE_PHYSICAL)
				if target then
					LocalControlCastSpell(HK_E)
				end
			end
		end
	end

	--R Logic
	if self.Menu.Mode.Combo.R:Value() and not IsAutoAttacking(myHero) then
		if LocalGameCanUseSpell(_R) == READY then
			local target = TargetSelector:GetTarget(self.R.range, DAMAGE_TYPE_PHYSICAL)
			if target then
				local Rdmg = ({175, 350, 525})[myHero:GetSpellData(_R).level] + ({28, 33, 40})[myHero:GetSpellData(_R).level] / 100 * (target.maxHealth - target.health)
				if HasBuff(target, "garenpassiveenemytarget") then
					if target.health < Rdmg then
						LocalControlCastSpell(HK_R, target)
					end
				else
					if  target.health < Damage:CalculateDamage(myHero, target, DAMAGE_TYPE_MAGICAL, Rdmg) then
						LocalControlCastSpell(HK_R, target)
					end
				end
			end
		end
	end

end

function Garen:OnClear()
	if LocalGameCanUseSpell(_E) == READY then
		--Lane E Logic
		if self.Menu.Mode.LaneClear.E:Value() and not IsAutoAttacking(myHero) then
			local EnemyMinions = GetEnemyMinions(self.E.range)
			if #EnemyMinions >= self.Menu.Mode.LaneClear.MinE:Value() then
				if HasBuff(myHero, "GarenE") == false then	
					LocalControlCastSpell(HK_E)
				end
			end
		end
		--Jungle E Logic
		if self.Menu.Mode.JungleClear.E:Value() and not IsAutoAttacking(myHero) then
			local Monsters = GetMonsters(self.E.range)
			if #Monsters > 1 then
				if HasBuff(myHero, "GarenE") == false then	
					LocalControlCastSpell(HK_E)
				end
			end
		end
	end
end

function Garen:OnLastHit()
	
	if LocalGameCanUseSpell(_Q) == READY then
		--Lanc Q Logic
		if self.Menu.Mode.LastHit.Q:Value() and not IsAutoAttacking(myHero) then
			local EnemyMinions = GetEnemyMinions(myHero.range + 100);
			local Qdmg = ({30, 65, 100, 135, 170})[myHero:GetSpellData(_Q).level] + 1.4 * myHero.totalDamage;
			for i = 1, #EnemyMinions do
				local minion = EnemyMinions[i];
				if GetDistanceSqr(myHero.pos, minion.pos) < (myHero.range + myHero.boundingRadius + minion.boundingRadius - 30) ^ 2 then
					if minion.health <= Damage:CalculateDamage(myHero, minion, DAMAGE_TYPE_PHYSICAL, Qdmg) then
						LocalControlCastSpell(HK_Q);
						break
					end
				end
			end
		end
	end
end

function Garen:OnFlee()
	--Q Logic
	if self.Menu.Mode.Flee.Q:Value() and LocalGameCanUseSpell(_Q) == READY then
		LocalControlCastSpell(HK_Q);
	end
end

function Garen:KillSteal()
	--R
	if self.Menu.KillSteal.R:Value() and LocalGameCanUseSpell(_R) == READY then
		local EnemyHeroes = GetEnemyHeroes(self.R.range);
		for i = 1, #EnemyHeroes do
			local hero = EnemyHeroes[i];
			local Rdmg = ({175, 350, 525})[myHero:GetSpellData(_R).level] + ({28, 33, 40})[myHero:GetSpellData(_R).level] / 100 * (hero.maxHealth - hero.health)
			if HasBuff(hero, "garenpassiveenemytarget") then	
				if hero.health < Rdmg then
					LocalControlCastSpell(HK_R, hero);
					break
				end
			else
				if  hero.health < Damage:CalculateDamage(myHero, hero, DAMAGE_TYPE_MAGICAL, Rdmg)  then
					LocalControlCastSpell(HK_R, hero);
					break
				end
			end
		end
	end
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
													};
					end
				end
			end
		end
	end
end

function Garen:AutoW()
	--W SkillShot
	for key, v in pairs(IncSpells) do
		if LocalGameTimer() >= v.endTime then IncSpells[key] = nil break end
		if LocalGameTimer() >= v.castEndTime then
			local spellOnMe = v.sPos + Vector(v.sPos,v.ePos):Normalized() * GetDistance(myHero.pos,v.sPos);
			local spellPos = v.sPos + Vector(v.sPos,v.ePos):Normalized() * (v.speed * (LocalGameTimer() - v.castEndTime) * 3);
			local dodgeHere = spellPos + Vector(v.sPos,v.ePos):Normalized() * (v.speed * 0.12);
			if GetDistanceSqr(spellOnMe,spellPos) <= GetDistanceSqr(dodgeHere,spellPos) and GetDistance(spellOnMe,v.sPos) - v.radius - myHero.boundingRadius <= GetDistance(v.sPos,v.ePos) then
				if GetDistanceSqr(myHero.pos,spellOnMe) < (v.radius + myHero.boundingRadius) ^ 2 then
					if LocalGameCanUseSpell(_W) == READY and self.Menu.AutoW.W:Value() then
						local castPos = myHero.pos + Vector(myHero.pos,v.sPos):Normalized() * 100;
						LocalControlCastSpell(HK_W);
					end
				end
			end
		end
	end

	--W TargetSpell
	if self.Menu.AutoW.W:Value() and LocalGameCanUseSpell(_W) == READY then
		local EnemyHeroes = GetEnemyHeroes(1200);
		for i = 1, #EnemyHeroes do
			local hero = EnemyHeroes[i];
			if not IsAutoAttacking(hero) and hero.activeSpell.target == myHero.handle then
				LocalControlCastSpell(HK_W);
			end
		end
	end

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
		local x = (a.x - b.x);
		local z = (a.z - b.z);
		return x * x + z * z;
	else
		local x = (a.x - b.x);
		local y = (a.y - b.y);
		return x * x + y * y;
	end
end

function GetDistance(a, b)
	return LocalMathSqrt(GetDistanceSqr(a, b));
end

function IsCastingSpell(unit)
	if unit.activeSpell.valid then
		return unit.isChanneling;
	end
	return false;
end

function IsAutoAttack(name)
	return name:lower():find("attack");
end

function IsAutoAttacking(unit)
	if unit.activeSpell.valid then
		if unit.activeSpell.target > 0 then
			return IsAutoAttack(unit.activeSpell.name);
		end
	end
	return false;
end

function GetEnemyTurrets(range)
	local result = {};
	local counter = 1;
	for i = 1, LocalGameTurretCount() do
		local turret = LocalGameTurret(i);
		if turret.isEnemy and turret.alive and turret.visible and turret.isTargetable then
			if GetDistanceSqr(myHero, turret) <= range * range then
				result[counter] = turret;
				counter = counter + 1;
			end
		end
	end
	return result;
end

function GetEnemyMinions(range)
	local result = {};
	local counter = 1;
	for i = 1, LocalGameMinionCount() do
		local minion = LocalGameMinion(i);
		if minion.isEnemy and minion.team ~= 300 and minion.valid and minion.alive and minion.visible and minion.isTargetable then
			if GetDistanceSqr(myHero, minion) <= range * range then
				result[counter] = minion;
				counter = counter + 1;
			end
		end
	end
	return result;
end

function GetMonsters(range)
	local result = {};
	local counter = 1;
	for i = 1, LocalGameMinionCount() do
		local minion = LocalGameMinion(i);
		if minion.isEnemy and minion.team == 300 and minion.valid and minion.alive and minion.visible and minion.isTargetable then
			if GetDistanceSqr(myHero, minion) <= range * range then
				result[counter] = minion;
				counter = counter + 1;
			end
		end
	end
	return result
end

function GetEnemyHeroes(range)
	local result = {};
	local counter = 1;
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i);
		if hero.isEnemy and hero.valid and hero.alive and hero.visible and hero.isTargetable then
			if GetDistanceSqr(myHero, hero) <= range * range then
				result[counter] = hero;
				counter = counter + 1;
			end
		end
	end
	return result;
end

function OnLoad()
	if myHero.charName ~= "Garen" then return end
	PrintChat("JarKao's Garen v" .. VERSION .. " is loading...")
	DelayAction(function ()
		OnGameStart();
	end, 5)
end

function OnGameStart()
	TargetSelector			=	_G.SDK.TargetSelector;
	DAMAGE_TYPE_PHYSICAL	=	_G.SDK.DAMAGE_TYPE_PHYSICAL;
	DAMAGE_TYPE_MAGICAL		=	_G.SDK.DAMAGE_TYPE_MAGICAL;
	Damage					=	_G.SDK.Damage;
	Orbwalker 				=	_G.SDK.Orbwalker;
	Garen();
end

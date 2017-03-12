--[[
made by Jarviskao
source: https://github.com/jarviskao/Gos/blob/master/Garen_External.lua
]]

--Hero
if myHero.charName ~= "Garen" then return end

--Locals
local LoL = "7.5"
local ver = "1.01"
local tickCount = 0

--Spells
local GarenQ = { range = 300 }
local GarenE = { range = 300 }
local GarenR = { range = 400 }
local SkillOrders = {HK_Q, HK_E, HK_W, HK_Q, HK_Q, HK_R, HK_Q, HK_E, HK_Q, HK_E, HK_R, HK_E, HK_E, HK_W, HK_W, HK_R, HK_W, HK_W}

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

--Combo Menu
GMenu:MenuElement({type = MENU, id = "Mode", name = "Mode Settings"})

--Combo Menu
GMenu.Mode:MenuElement({type = MENU, id = "Combo", name = "Combo"})
GMenu.Mode.Combo:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
--GMenu.Mode.Combo:MenuElement({id = "Qrange", name = "Min. range for use Q", value = 300, min = 100, max = 500 , step = 10 , leftIcon = RangeIcons})
GMenu.Mode.Combo:MenuElement({id = "W", name = "Use W", value = true, leftIcon = SpellIcons.W})
GMenu.Mode.Combo:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
GMenu.Mode.Combo:MenuElement({id = "HotKey",name = "Combo HotKey", key = 32})

--LastHit Menu
GMenu.Mode:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
GMenu.Mode.LastHit:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
GMenu.Mode.LastHit:MenuElement({id = "HotKey",name = "Last Hit HotKey", key = string.byte("X")})

--Harass Menu
GMenu.Mode:MenuElement({type = MENU, id = "Harass", name = "Harass"})
GMenu.Mode.Harass:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
--GMenu.Mode.Harass:MenuElement({id = "Qrange", name = "Min. range for use Q", value = 300, min = 100, max = 500, step = 10, leftIcon = RangeIcons})
GMenu.Mode.Harass:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
GMenu.Mode.Harass:MenuElement({id = "HotKey",name = "Harass HotKey", key = string.byte("C")})

--Clear Menu
GMenu.Mode:MenuElement({type = MENU, id = "Clear", name = "Clear"})
	--LaneClear Menu
	GMenu.Mode.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane Clear"})
	GMenu.Mode.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	GMenu.Mode.Clear.LaneClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	GMenu.Mode.Clear.LaneClear:MenuElement({id = "HotKey",name = "Lane Clear HotKey", key = string.byte("V")})
	--JungleClear Menu
	GMenu.Mode.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle Clear"})
	GMenu.Mode.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true, leftIcon = SpellIcons.Q})
	GMenu.Mode.Clear.JungleClear:MenuElement({id = "E", name = "Use E", value = true, leftIcon = SpellIcons.E})
	GMenu.Mode.Clear.JungleClear:MenuElement({id = "HotKey",name = "Jungle Clear HotKey", key = string.byte("V")})
	
--KillSteal Menu
GMenu:MenuElement({type = MENU, id = "KillSteal", name = "KS Settings"})
GMenu.KillSteal:MenuElement({id = "R", name = "Use R", value = true, leftIcon = SpellIcons.R})
GMenu.KillSteal:MenuElement({type = MENU, id = "black", name = "KillSteal White List", leftIcon = BlockIcons})
DelayAction(function()
	for i = 1, Game.HeroCount() do
		local hero = Game.Hero(i)
		if hero.isEnemy then
			GMenu.KillSteal.black:MenuElement({id = hero.networkID, name = "Use R On: "..hero.charName, value = true})
		end
	end
end, 0.2)
--Miscellaneous Menu 
GMenu:MenuElement({type = MENU, id = "Misc", name = "Misc Settings"})
	--Auto Level Up Spell Menu
	GMenu.Misc:MenuElement({type = MENU, id = "LvUpSpell", name = "Auto Level Spell"})
	GMenu.Misc.LvUpSpell:MenuElement({type = SPACE, name = "Sequence: Q > E > W > Q > Q (Max Q First)"})
	GMenu.Misc.LvUpSpell:MenuElement({id = "UseAutoLvSpell", name = "Use Auto Level Spell", value = false})
	GMenu.Misc.LvUpSpell:MenuElement({id = "UseHumanizer", name = "Humanizer", value = true })
	--Draw Spells Menu
	GMenu.Misc:MenuElement({type = MENU, id = "DrawSpells", name = "Draw Spells"})
	GMenu.Misc.DrawSpells:MenuElement({id = "E", name = "Draw E Range", value = true})
	GMenu.Misc.DrawSpells:MenuElement({id = "R", name = "Draw R Range", value = true})

PrintChat("[Garen] Menu Loaded")

function OnDraw()
	--Draw Range
	if myHero.dead then return end
	if GMenu.Misc.DrawSpells.E:Value() then Draw.Circle(myHero.pos,GarenE.range,1,Draw.Color(255, 255, 255, 255)) end			
	if GMenu.Misc.DrawSpells.R:Value() then Draw.Circle(myHero.pos,GarenR.range,1,Draw.Color(255, 255, 255, 255)) end	
end

--Start
function OnTick()
	if myHero.dead or  not GMenu.Enabled:Value() then return end
	local target = GetTarget(800)
	OnCombo(target)
	OnHarass(target)
	OnClear()
	KillSteal()
	AutoLvSpell()
end

function OnCombo(target)
	if GMenu.Mode.Combo.HotKey:Value() then
		--Q
		if isReady(_Q) and target and IsValidTarget(target,GarenQ.range) and GMenu.Mode.Combo.Q:Value() then
			Control.CastSpell(HK_Q)
		end
		--W
		if isReady(_W) and target and IsValidTarget(target,GarenQ.range) and GMenu.Mode.Combo.W:Value() then
			Control.CastSpell(HK_W)
		end
		--E
		if isReady(_E) and target and IsValidTarget(target,GarenR.range) and GMenu.Mode.Combo.E:Value() and myHero:GetSpellData(_E).name == "GarenE" then
			Control.CastSpell(HK_E)
		end
	end
end

function OnHarass(target)
	if GMenu.Mode.Harass.HotKey:Value() then
		local target = GetTarget(GarenQ.range)
		--Q
		if isReady(_Q) and target and IsValidTarget(target,GarenQ.range) and GMenu.Mode.Harass.Q:Value() then
			Control.CastSpell(HK_Q)
		end
		--W
		if isReady(_W) and target and IsValidTarget(target,GarenQ.range) and GMenu.Mode.Harass.W:Value() then
			Control.CastSpell(HK_W)
		end
		--E
		if isReady(_E) and target and IsValidTarget(target,GarenR.range) and GMenu.Mode.Harass.E:Value() and myHero:GetSpellData(_E).name == "GarenE"then
			Control.CastSpell(HK_E)
		end
	end
end

function OnClear()
	--Lane Clear
	if GMenu.Mode.Clear.LaneClear.HotKey:Value() then
		local minion = GetMinion(GarenQ.range)
		--Q
		if isReady(_Q) and minion and GMenu.Mode.Clear.LaneClear.Q:Value() then
			Control.CastSpell(HK_Q)
		end
		--E
		if isReady(_E) and minion and myHero:GetSpellData(_E).name == "GarenE" and GMenu.Mode.Clear.LaneClear.E:Value() then
			Control.CastSpell(HK_E)
		end
	end
	--Jungle Clear
	
end

function KillSteal()
	if GMenu.KillSteal.R:Value() then
	  for i=1,Game.HeroCount() do
			local hero = Game.Hero(i)
			if hero and IsValidTarget(hero, GarenR.range) and hero.team ~= myHero.team  then
				local Rdmg = (GetRdmg(hero))
				--PrintChat(hero.charName.." : R Dmg = "..Rdmg.."   current health = "..hero.health)
				if isReady(_R) and Rdmg > hero.health  and GMenu.KillSteal.black[hero.networkID]:Value()then
						Control.CastSpell(HK_R, hero)
				end
			end
		end
	end
end

function GetRdmg(hero)
	local level = myHero:GetSpellData(_R).level
	if level == (nil or 0) then level = 1 end
	--PrintChat (level)
	local Rdmg = ({175, 350, 525})[level] + ({27, 32, 39})[level] / 100 * (hero.maxHealth - hero.health)
	return Rdmg
end


function isReady (spell)
	return Game.CanUseSpell(spell) == READY and myHero:GetSpellData(spell).currentCd == 0  and myHero:GetSpellData(spell).level > 0
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

function GetMinion(range)
	local target
		for i = 1,Game.MinionCount() do
			local minion = Game.Minion(i)
			if IsValidTarget(minion, range) and not minion.isAlly then
				target = minion
				break
			end
		end
		return target
end

function IsValidTarget(obj, range)
    return obj ~= nil and obj.valid and obj.visible and not obj.dead and obj.isTargetable and obj.distance <= range
end

function AutoLvSpell()
	if myHero.levelData.lvl > 0 and myHero.levelData.lvlPts > 0 and GMenu.Misc.LvUpSpell.UseAutoLvSpell:Value() then
		if (myHero.levelData.lvl + 1 - myHero.levelData.lvlPts) then
			if GMenu.Misc.LvUpSpell.UseHumanizer:Value() then
				tickCount = tickCount + 1
			end
			if GMenu.Misc.LvUpSpell.UseHumanizer:Value() and tickCount >= 30 then
				LevelSpell()
				tickCount = 0
			elseif not GMenu.Misc.LvUpSpell.UseHumanizer:Value() then
				LevelSpell()
			end		
		end
	end
end

function LevelSpell()
				Control.KeyDown(HK_LUS)
				Control.CastSpell(SkillOrders[(myHero.levelData.lvl + 1 - myHero.levelData.lvlPts)])
				Control.KeyUp(HK_LUS)	
end

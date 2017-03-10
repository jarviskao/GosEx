--[[
made by Jarviskao
source: https://github.com/jarviskao/Gos/blob/master/Garen_External.lua
]]

--Hero
if myHero.charName ~= "Garen" then return end

--Auto Update
local ver = "0.1"

--Locals
local LoL = "7.5"

--Spells
local GarenQ = { range = 300 }
local GarenE = { range = 300 }
local GarenR = { range = 400 }
local SkillOrders = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}

--Main Menu
local GMenu = MenuElement({type = MENU, id = "GMenu", name = "Garen", leftIcon = "http://static.lolskill.net/img/champions/64/garen.png"})
GMenu:MenuElement({id = "Enabled", name = "Enabled", value = true})

--Combo Menu
GMenu:MenuElement({type = MENU, id = "Combo", name = "Combo"})
GMenu.Combo:MenuElement({id = "Q", name = "Use Q", value = true})
GMenu.Combo:MenuElement({id = "Qrange", name = "Min. range for use Q", value = 300, min = 100, max = 500})
GMenu.Combo:MenuElement({id = "E", name = "Use E", value = true})
--GMenu.Combo:MenuElement({id = "R", name = "Use R (Selected target)", value = true})
GMenu.Combo:MenuElement({id = "ComboHotKey",name = "Combo HotKey", key = 32})

--LastHit Menu
GMenu:MenuElement({type = MENU, id = "LastHit", name = "Last Hit"})
GMenu.LastHit:MenuElement({id = "Q", name = "Use Q", value = true})
GMenu.LastHit:MenuElement({id = "LastHitHotKey",name = "Last Hit HotKey", key = string.byte("X")})

--Harass Menu
GMenu:MenuElement({type = MENU, id = "Harass", name = "Harass"})
GMenu.Harass:MenuElement({id = "Q", name = "Use Q", value = true})
GMenu.Harass:MenuElement({id = "Qrange", name = "Min. range for use Q", value = 300, min = 100, max = 500})
GMenu.Harass:MenuElement({id = "E", name = "Use E", value = true})
GMenu.Harass:MenuElement({id = "HarassHotKey",name = "Harass HotKey", key = string.byte("C")})

--Clear Menu
GMenu:MenuElement({type = MENU, id = "Clear", name = "Clear"})
	--LaneClear Menu
	GMenu.Clear:MenuElement({type = MENU, id = "LaneClear", name = "Lane Clear"})
	GMenu.Clear.LaneClear:MenuElement({id = "Q", name = "Use Q", value = true})
	GMenu.Clear.LaneClear:MenuElement({id = "E", name = "Use E", value = true})
	GMenu.Clear.LaneClear:MenuElement({id = "LaneClearHotKey",name = "Lane Clear HotKey", key = string.byte("V")})
	--JungleClear Menu
	GMenu.Clear:MenuElement({type = MENU, id = "JungleClear", name = "Jungle Clear"})
	GMenu.Clear.JungleClear:MenuElement({id = "Q", name = "Use Q", value = true})
	GMenu.Clear.JungleClear:MenuElement({id = "E", name = "Use E", value = true})
	GMenu.Clear.JungleClear:MenuElement({id = "JungleClearHotKey",name = "Jungle Clear HotKey", key = string.byte("V")})
	
--KillSteal Menu
GMenu:MenuElement({type = MENU, id = "KillSteal", name = "KillSteal"})
GMenu.KillSteal:MenuElement({id = "R", name = "Use R", value = true})
GMenu.KillSteal:MenuElement({type = MENU, id = "black", name = "KillSteal White List"})
for i = 1, Game.HeroCount() do
	local hero = Game.Hero(i)
	if hero.isEnemy then
		GMenu.KillSteal.black:MenuElement({hero.name, name = "Use R On: "..hero.charName, value = true})
	end
end

--Miscellaneous Menu 
GMenu:MenuElement({type = MENU, id = "Misc", name = "Miscellaneous"})
	--Auto Level Up Spell Menu
	GMenu.Misc:MenuElement({type = MENU, id = "LvUpSpell", name = "Auto Level Spell"})
	GMenu.Misc.LvUpSpell:MenuElement({type = SPACE, name = "Order: Max Q -> E -> W"})
	GMenu.Misc.LvUpSpell:MenuElement({id = "UseAutoLvSpell", name = "Use Auto Level Spell", value = false})
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
	if myHero.dead then return end
	OnCombo()
	OnClear()
	OnHarass()
	OnLastHit()
	--AutoLvSpell()
end

function OnCombo()
	if GMenu.Combo.ComboHotKey:Value() then
		--Q
		if Game.CanUseSpell(_Q) == READY then
			Control.CastSpell(HK_Q)
		end
		--E
		if Game.CanUseSpell(_E) == READY then
			Control.CastSpell(HK_E)
		end
	end
end

function OnLasthit()
	if GMenu.LastHit.LastHitHotKey:Value() then
		Contorl.CastSpell(HK_Q)
	end
end

function AutoLvSpell()
	if myHero.levelData.lvl > 0 and GMenu.Misc.LvUpSpell.UseAutoLvSpell:Value() then
		if (myHero.levelData.lvl + 1 - myHero.levelData.lvlPts) then
				
		end
	end
end


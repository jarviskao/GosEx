--Hero
if myHero.charName~="Yasuo"then return end
--lib
require"Eternal Prediction"
--Localize
local myHero=myHero
local AARange=myHero.range
local LocalGameHeroCount=Game.HeroCount
local LocalGameHero=Game.Hero
local LocalGameMinionCount=Game.MinionCount
local LocalGameMinion=Game.Minion
local LocalGameCanUseSpell=Game.CanUseSpell
local LocalDrawCircle=Draw.Circle
local LocalDrawCircleMinimap=Draw.CircleMinimap
local LocalMathHuge=math.huge
local LocalMathSqrt=math.sqrt
local ControlCastSpell=Control.CastSpell
local GameLatency=Game.Latency
--Spell
local Q={range=475,speed=LocalMathHuge,delay=0.4,width=20}
local Q3={name="YasuoQ3W",range=900,speed=1500,delay=0.5,width=90}
local W={range=400,speed=500,delay=0.25,width=0}
local E={range=475,speed=20,delay=0.25,width=0}
local R={range=1200,speed=20,delay=0.25,width=0}
--OTHER
local QPred=Prediction:SetSpell(Q,TYPE_LINE,true)
local SpellList={"Q","W","E","R"}
local ENEMY_NEARBY=nil
--icon
local Icons={Menu="http://static.lolskill.net/img/champions/64/yasuo.png",Q="https://vignette4.wikia.nocookie.net/leagueoflegends/images/e/e5/Steel_Tempest.png",W="https://vignette3.wikia.nocookie.net/leagueoflegends/images/6/61/Wind_Wall.png",E="https://vignette4.wikia.nocookie.net/leagueoflegends/images/f/f8/Sweeping_Blade.png",R="https://vignette1.wikia.nocookie.net/leagueoflegends/images/c/c6/Last_Breath.png",Tiamat="https://vignette2.wikia.nocookie.net/leagueoflegends/images/e/e3/Tiamat_item.png",RavenousHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/e/e8/Ravenous_Hydra_item.png",TitanicHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/2/22/Titanic_Hydra_item.png",YoumuusGhostblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/4/41/Youmuu%27s_Ghostblade_item.png",RanduinsOmen="https://vignette1.wikia.nocookie.net/leagueoflegends/images/0/08/Randuin%27s_Omen_item.png",BilgewaterCutlass="https://vignette1.wikia.nocookie.net/leagueoflegends/images/4/44/Bilgewater_Cutlass_item.png",BladeoftheRuinedKing="https://vignette2.wikia.nocookie.net/leagueoflegends/images/2/2f/Blade_of_the_Ruined_King_item.png",HextechGunblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/6/64/Hextech_Gunblade_item.png"}
--Main Menu
local Menu=MenuElement({type=MENU,id="Menu",name="Yasuo - Easier to play",leftIcon=Icons.Menu})
--Main Menu--Key Setting
Menu:MenuElement({type=MENU,id="Key",name="Keys Settings"})
Menu.Key:MenuElement({id="Combo",name="Combo Key",key=32})
Menu.Key:MenuElement({id="Harass",name="Harass Key",key=string.byte("C")})
Menu.Key:MenuElement({id="Clear",name="Clear Key",key=string.byte("V")})
Menu.Key:MenuElement({id="LastHit",name="Last Hit Key",key=string.byte("X")})
Menu.Key:MenuElement({id="Flee",name="Flee Key",key=string.byte("A")})
--Main Menu--Mode Setting
Menu:MenuElement({type=MENU,id="Mode",name="Mode Settings"})
--Main Menu--Mode Setting--Combo
Menu.Mode:MenuElement({type=MENU,id="Combo",name="Combo"})
Menu.Mode.Combo:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.Mode.Combo:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
Menu.Mode.Combo:MenuElement({id="Gapclose",name="Use E To Gapclose",value=true,leftIcon=Icons.E})
Menu.Mode.Combo:MenuElement({id="EUnderTurret",name="Use E Under Turret",value=false,leftIcon=Icons.E})
Menu.Mode.Combo:MenuElement({id="R",name="Use R",value=false,leftIcon=Icons.R})
--Main Menu--Mode Setting--Clear
Menu.Mode:MenuElement({type=MENU,id="LaneClear",name="LaneClear"})
Menu.Mode.LaneClear:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.Mode.LaneClear:MenuElement({id="Q3",name="Use Q3 If Hit X Minion ",value=3,min=1,max=5,step=1,leftIcon=Icons.Q})
Menu.Mode.LaneClear:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
Menu.Mode:MenuElement({type=MENU,id="JungleClear",name="JungleClear"})
Menu.Mode.JungleClear:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.Mode.JungleClear:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
--Main Menu--Mode Setting--Flee
Menu.Mode:MenuElement({type=MENU,id="Flee",name="Flee"})
Menu.Mode.Flee:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
--Main Menu--KillSteal
Menu:MenuElement({type=MENU,id="KillSteal",name="KillSteal"})
Menu.KillSteal:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.KillSteal:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
--Main Menu--AutoCastSpell
Menu:MenuElement({id="AutoCastSpell",name="Auto Cast Spell",type=MENU})
--Main Menu--AutoCastSpell--Auto Q
Menu.AutoCastSpell:MenuElement({type=MENU,id="AutoQ",name="Auto Q (broken)"})
Menu.AutoCastSpell.AutoQ:MenuElement({id="QEnemies",name="Q Enemies",value=false,leftIcon=Icons.Q})
Menu.AutoCastSpell.AutoQ:MenuElement({id="QEnemiesUnder",name="Q Enemies Under Turret",value=false,leftIcon=Icons.Q})
Menu.AutoCastSpell.AutoQ:MenuElement({id="QMinions",name="Q Minions",value=false,leftIcon=Icons.Q})
Menu.AutoCastSpell.AutoQ:MenuElement({id="QMinionsUnder",name="Q Minions Under Turret",value=false,leftIcon=Icons.Q})
--Main Menu--AutoCastSpell--WindWall
Menu.AutoCastSpell:MenuElement({type=MENU,id="AutoW",name="Auto W"})
Menu.AutoCastSpell.AutoW:MenuElement({id="W",name="W Missile Spell",value=true,leftIcon=Icons.W})
Menu.AutoCastSpell.AutoW:MenuElement({id="WAA",name="W Auto Attack",value=true,leftIcon=Icons.W})
Menu.AutoCastSpell.AutoW:MenuElement({id="WAAHp",name="W Auto Attack If Health Below:",value=20,min=5,max=95,identifier="%",leftIcon=Icons.W})
--Main Menu--AutoCastSpell--Auto R
Menu.AutoCastSpell:MenuElement({type=MENU,id="AutoR",name="Auto R"})
Menu.AutoCastSpell.AutoR:MenuElement({id="R",name="R",value=true,leftIcon=Icons.R})
Menu.AutoCastSpell.AutoR:MenuElement({id="MinR",name="R if Hit X Enemies",value=2,min=1,max=5,step=1,leftIcon=Icons.R})
--Main Menu--Item Usage
Menu:MenuElement({type=MENU,id="Item",name="Item Usage"})
Menu.Item:MenuElement({id="Enable",name="Enable",value=true})
Menu.Item:MenuElement({id="Tiamat",name="Tiamat",value=true,leftIcon=Icons.Tiamat})
Menu.Item:MenuElement({id="RavenousHydra",name="Ravenous Hydra",value=true,leftIcon=Icons.RavenousHydra})
Menu.Item:MenuElement({id="TitanicHydra",name="Titanic Hydra",value=true,leftIcon=Icons.TitanicHydra})
Menu.Item:MenuElement({id="YoumuusGhostblade",name="Youmuu's Ghostblade",value=true,leftIcon=Icons.YoumuusGhostblade})
Menu.Item:MenuElement({id="RanduinsOmen",name="Randuin's Omen",value=true,leftIcon=Icons.RanduinsOmen})
Menu.Item:MenuElement({id="BilgewaterCutlass",name="Bilgewater Cutlass",value=true,leftIcon=Icons.BilgewaterCutlass})
Menu.Item:MenuElement({id="BladeoftheRuinedKing",name="Blade of the Ruined King",value=true,leftIcon=Icons.BladeoftheRuinedKing})
Menu.Item:MenuElement({id="HextechGunblade",name="Hextech Gunblade",value=true,leftIcon=Icons.HextechGunblade})
--Main Menu--Drawing
Menu:MenuElement({type=MENU,id="Drawing",name="Drawing"})
Menu.Drawing:MenuElement({id="DisableAll",name="Disable All Drawings",value=true})
for i=1,4 do
Menu.Drawing:MenuElement({id=SpellList[i],name="Draw "..SpellList[i].." Range",type=MENU,leftIcon=Icons[SpellList[i]]})
Menu.Drawing[SpellList[i]]:MenuElement({id="Enabled",name="Enabled",value=true})
Menu.Drawing[SpellList[i]]:MenuElement({id="Width",name="Width",value=2,min=1,max=5,step=1})
Menu.Drawing[SpellList[i]]:MenuElement({id="Color",name="Color",color=Draw.Color(255,255,255,255)})
end
function OnDraw()
if myHero.dead or Menu.Drawing.DisableAll:Value()then return end
--Draw Range
for i=1,4 do
if Menu.Drawing[SpellList[i]].Enabled:Value()then
LocalDrawCircle(myHero.pos,myHero:GetSpellData(i-1).range,Menu.Drawing[SpellList[i]].Width:Value(),Menu.Drawing[SpellList[i]].Color:Value())
end
end
end
---------
--START--
---------
function OnTick()
if myHero.dead then return end
ENEMY_NEARBY=isEnemyNearBy(1200)
if Menu.Key.Combo:Value()then
OnCombo()
elseif Menu.Key.Clear:Value()then
OnClear()
elseif Menu.Key.Flee:Value()then
OnFlee()
end
AutoWindwall()
AutoCastSpell()
KillSteal()
end
---------
--Combo--
---------
function OnCombo()
UseComboItem()
if myHero.attackData.state==STATE_WINDUP or not ENEMY_NEARBY then return end
local CURRENT_TARGET=nil
--QLogic=function()
--PrintChat("OnSpellCast")
--end
--GOSPlus:OnSpellCast(QLogic)
--Q Logic
if Menu.Mode.Combo.Q:Value()and isReady(_Q)then
--Q3
if HasBuff(myHero,Q3.name)then
CURRENT_TARGET=GetTarget(Q3.range)
if CURRENT_TARGET then
if GetDistance(myHero.pos,CURRENT_TARGET.pos)<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local costPos=CURRENT_TARGET:GetPrediction(Q3.speed,Q3.delay)
CastSpell(HK_Q,costPos)
end
else
local costPos=CURRENT_TARGET:GetPrediction(Q3.speed,Q3.delay)
CastSpell(HK_Q,costPos)
end
end
else
--normal Q
CURRENT_TARGET=GetTarget(Q.range)
if CURRENT_TARGET then
if GetDistance(myHero.pos,CURRENT_TARGET.pos)<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=QPred:GetPrediction(CURRENT_TARGET,myHero.pos)
if pred and pred.hitChance>=0.22 then
CastSpell(HK_Q,pred.castPos)
end
end
else
local pred=QPred:GetPrediction(CURRENT_TARGET,myHero.pos)
if pred and pred.hitChance>=0.22 then
CastSpell(HK_Q,pred.castPos)
end
end
end
end
end
--E Logic
if Menu.Mode.Combo.E:Value()and isReady(_E)then
CURRENT_TARGET=GetTarget(1200)
if CURRENT_TARGET then
local gapDistance=GetDistance(myHero.pos,CURRENT_TARGET.pos)
if not HasBuff(CURRENT_TARGET,"YasuoDashWrapper")then
--E to target if in E Range
if gapDistance<E.range then
--if after E can AA target
local afterEPos=CURRENT_TARGET.pos:Shortened(myHero.pos,E.range-gapDistance)
if GetDistance(afterEPos,CURRENT_TARGET.pos)<=AARange+50 then
CastSpell(HK_E,CURRENT_TARGET)
end
else
--E to minion if out of E Range
if Menu.Mode.Combo.Gapclose:Value()and isReady(_E)then
--GapClose
local minion=GetGapCloseEnemiesMinions(CURRENT_TARGET.pos,gapDistance-100)
if minion then
if Menu.Mode.Combo.EUnderTurret:Value()then
CastSpell(HK_E,minion)
else
local afterEPos=minion.pos:Shortened(myHero.pos,E.range-GetDistance(myHero.pos,minion.pos))
if not IsUnderTurret(afterEPos)then
CastSpell(HK_E,minion)
end
end
else
local hero=GetGapCloseEnemiesHero(CURRENT_TARGET.pos,gapDistance-100,CURRENT_TARGET)
if hero then
if Menu.Mode.Combo.EUnderTurret:Value()then
CastSpell(HK_E,hero)
else
local afterEPos=hero.pos:Shortened(myHero.pos,E.range-GetDistance(myHero.pos,hero.pos))
if not IsUnderTurret(afterEPos)then
CastSpell(HK_E,hero)
end
end
end
end
end
end
end
end
end
--R Logic
if Menu.Mode.Combo.R:Value()and isReady(_R)then
CURRENT_TARGET=GetTarget(R.range)
if CURRENT_TARGET then
if isKnockedUp(CURRENT_TARGET)then
CastSpell(HK_R,CURRENT_TARGET)
end
end
end
end
---------
--KillSteal--
---------
function KillSteal()
if myHero.attackData.state==STATE_WINDUP or not isEnemyNearBy(Q.range)then return end
--KillSteal Q
if Menu.KillSteal.Q:Value()and isReady(_Q)then
--spell data
local Qdmg=({20,40,60,80,100})[myHero:GetSpellData(_Q).level]+myHero.totalDamage
--loop
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero.isEnemy and hero.alive and hero.isTargetable and GetDistanceSqr(myHero.pos,hero.pos)<=Q.range*Q.range then
if CalcPhysicalDamage(myHero,hero,Qdmg)>=hero.health+hero.shieldAD then
CastSpell(HK_Q,hero)
end
end
end
end
--KillSteal E
if Menu.KillSteal.E:Value()and isReady(_E)then
--spell data
local Edmg=({60,70,80,90,100})[myHero:GetSpellData(_E).level]+0.2*myHero.bonusDamage+0.6*myHero.ap
--loop
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
local gapDistance=GetDistance(myHero.pos,hero.pos)
if hero.isEnemy and hero.alive and hero.isTargetable and gapDistance<=E.range and not HasBuff(hero,"YasuoDashWrapper")then
if CalcMagicalDamage(myHero,hero,Edmg)+CalcPhysicalDamage(myHero,hero,myHero.totalDamage*(1+myHero.critChance))>=hero.health+hero.shieldAP then
CastSpell(HK_E,hero)
end
end
end
end
end
---------
--Clear--
---------
function OnClear()
UseClearItem()
if myHero.attackData.state==STATE_WINDUP then return end
--LaneClear
if isEnemyMinionNearBy(600)then
if Menu.Mode.LaneClear.Q:Value()and isReady(_Q)then
--Use Q3 if has Q3
if HasBuff(myHero,Q3.name)then
--minion>3 or closer minion
local target=GetQ3MinionTarget(Q3.range)
if target then
if GetDistance(myHero.pos,target.pos)<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local castPos=GetMinionPred(target,Q3.speed,Q3.delay)
CastSpell(HK_Q,castPos)
end
else
local castPos=GetMinionPred(target,Q3.speed,Q3.delay)
CastSpell(HK_Q,castPos)
end
end
else
--Q Closest Target
local target=GetClosestEnemiesMinionsTarget(Q.range)
if target then
if GetDistance(myHero.pos,target.pos)<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local castPos=GetMinionPred(target,Q.speed,Q.delay)
CastSpell(HK_Q,castPos)
end
else
local castPos=GetMinionPred(target,Q.speed,Q.delay)
CastSpell(HK_Q,castPos)
end
end
end
end
end
--E
if Menu.Mode.LaneClear.E:Value()and isReady(_E)then
if not isEnemyNearBy(800)then
--E to minion if E After Pos near a minion
local MINION_TARGET=GetEMinionTarget(E.range)
if MINION_TARGET then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_E,MINION_TARGET)
end
end
--KS with E
local MINION_TARGET=GetKillableMinionTarget(E.range)
if MINION_TARGET then
CastSpell(HK_E,MINION_TARGET)
end
--if Enemies are not in range 600
elseif not isEnemyNearBy(800)then
--KS with E
local MINION_TARGET=GetKillableMinionTarget(E.range)
if MINION_TARGET then
CastSpell(HK_E,MINION_TARGET)
end
end
end
--Jungleclear
if isJungleNearBy(500)then
--Q
if Menu.Mode.JungleClear.Q:Value()and isReady(_Q)then
--Q Closest Target
local MINION_TARGET=GetClosestEnemiesMinionsTarget(Q.range)
if MINION_TARGET then
if GetDistance(myHero.pos,MINION_TARGET.pos)<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local castPos=GetMinionPred(MINION_TARGET,Q.speed,Q.delay)
CastSpell(HK_Q,castPos)
end
else
local castPos=GetMinionPred(MINION_TARGET,Q.speed,Q.delay)
CastSpell(HK_Q,castPos)
end
end
end
--E to minion
if Menu.Mode.JungleClear.E:Value()and isReady(_E)then
--if E After Pos can AA minion
local MINION_TARGET=GetEMinionTarget(E.range)
if MINION_TARGET then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_E,MINION_TARGET)
end
end
--KS with E
local MINION_TARGET=GetKillableMinionTarget(E.range)
if MINION_TARGET then
CastSpell(HK_E,MINION_TARGET)
end
end
end
end
---------
--Flee--
---------
function OnFlee()
if Menu.Mode.Flee.E:Value()and isReady(_E)then
local gapDistance=GetDistance(myHero.pos,mousePos)
--GapClose
local minion=GetGapCloseEnemiesMinions(mousePos,gapDistance-100)
if minion then
CastSpell(HK_E,minion)
else
local hero=GetGapCloseEnemiesHero(mousePos,gapDistance-100,nil)
if hero then
CastSpell(HK_E,hero)
end
end
end
end
---------
--AutoWindwall--
---------
function AutoWindwall()
if isReady(_W)then
--W Missile Spell
if Menu.AutoCastSpell.AutoW.W:Value()then
for i=1,Game.MissileCount()do
local missile=Game.Missile(i)
local data=missile.missileData
if missile.isEnemy and missile.team<300 and data.target==0 then
local myPos=myHero.pos
local pointSegment,pointLine,isOnSegment=VectorPointProjectionOnLineSegment(missile.pos,data.endPos,myPos)
if isOnSegment and GetDistanceSqr(pointSegment,myPos)<(data.width+myHero.boundingRadius)*(data.width+myHero.boundingRadius)then
local TimeToHit=(GetDistance(myPos,missile.pos)-myHero.boundingRadius)/data.speed
if TimeToHit<0.3 and TimeToHit>0.1 then
CastSpell(HK_W,myPos:Extended(data.startPos,200))
end
end
end
end
end
--W Auto Attack
if Menu.AutoCastSpell.AutoW.WAA:Value()and myHero.maxHealth*Menu.AutoCastSpell.AutoW.WAAHp:Value()*0.01>myHero.health then
local CURRENT_TARGET=GetTarget(650)
if CURRENT_TARGET and CURRENT_TARGET.activeSpell.target==myHero.handle then
CastSpell(HK_W,CURRENT_TARGET.pos)
end
end
end
end
---------
--AutoCastSpell--
---------
function AutoCastSpell()
if myHero.attackData.state==STATE_WINDUP then return end
if Menu.AutoCastSpell.AutoR.R:Value()and isReady(_R)then
if ENEMY_NEARBY then
if CountKnockedUpEnemies(R.range)>=Menu.AutoCastSpell.AutoR.MinR:Value()then
CastSpell(HK_R)
end
end
end
--[[--Auto Q Minions if not Oncombo and OnClear
if not Menu.Key.Clear:Value()and not Menu.Key.Combo:Value()then
if Menu.Misc.AutoQMinions:Value()and isReady(_Q)then
if isMinionNearBy(600)then
if not HasBuff(myHero,Q3.name)then
--Q Closest Target
target=GetClosestEnemiesMinionsTarget(Q.range)
if target then
if target.distance<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
if Menu.Misc.DontQMinionsUnder:Value()then
if not IsUnderTurret(myHero.pos)then
CastSpell(HK_Q,pred)
end
else
CastSpell(HK_Q,pred)
end
end
end
else
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
if Menu.Misc.DontQMinionsUnder:Value()then
if not IsUnderTurret(myHero.pos)then
CastSpell(HK_Q,pred)
end
else
CastSpell(HK_Q,pred)
end
end
end
end
end
end
end
end
--Auto Q Enemies if not Oncombo
if not Menu.Key.Combo:Value()then
if Menu.Misc.AutoQEnemies:Value()and isReady(_Q)then
--normal Q3
if HasBuff(myHero,Q3.name)then
if isValidTarget(CURRENT_TARGET,Q3.range)then
if CURRENT_TARGET.distance<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=CURRENT_TARGET:GetPrediction(Q3.speed,Q3.delay+Game.Latency()/1000)
if pred then
if Menu.Misc.DontQEnemiesUnder:Value()then
if not IsUnderTurret(myHero.pos)then
CastSpell(HK_Q,pred)
end
else
CastSpell(HK_Q,pred)
end
end
end
else
local pred=CURRENT_TARGET:GetPrediction(Q3.speed,Q3.delay+Game.Latency()/1000)
if pred then
if Menu.Misc.DontQEnemiesUnder:Value()then
if not IsUnderTurret(myHero.pos)then
CastSpell(HK_Q,pred)
end
else
CastSpell(HK_Q,pred)
end
end
end
end
else
--normal Q
if isValidTarget(CURRENT_TARGET,Q.range)then
if CURRENT_TARGET.distance<AARange+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=QPred:GetPrediction(CURRENT_TARGET,myHero.pos)
if pred and pred.hitChance>=0.22 then
if Menu.Misc.DontQEnemiesUnder:Value()then
if not IsUnderTurret(myHero.pos)then
CastSpell(HK_Q,pred.castPos)
end
else
CastSpell(HK_Q,pred.castPos)
end
end
end
else
local pred=QPred:GetPrediction(CURRENT_TARGET,myHero.pos)
if pred and pred.hitChance>=0.22 then
if Menu.Misc.DontQEnemiesUnder:Value()then
if not IsUnderTurret(myHero.pos)then
CastSpell(HK_Q,pred.castPos)
end
else
CastSpell(HK_Q,pred.castPos)
end
end
end
end
end
end
end]]
end
---------------
--Use Combo Item
---------------
function UseComboItem()
if not Menu.Item.Enable:Value()then return end
local CURRENT_TARGET=GetTarget(450)
--item Usage
if CURRENT_TARGET then
--Get Inventory Items
local Inventory=GetInventoryItems()
--STATE_WINDDOWN/STATE_WINDUP
if myHero.attackData.state==STATE_WINDDOWN then
--For 6 to 11;ITEM_1=6
for i=ITEM_1,ITEM_6 do
if Inventory[i]~=nil and myHero:GetSpellData(i).currentCd==0 then
if Inventory[i]==3077 then
if Menu.Item.Tiamat:Value()then
ControlCastSpell(ItemSlotToHK(i))
end
end
if Inventory[i]==3074 then
if Menu.Item.RavenousHydra:Value()then
ControlCastSpell(ItemSlotToHK(i))
end
end
if Inventory[i]==3143 then
if Menu.Item.RanduinsOmen:Value()then
ControlCastSpell(ItemSlotToHK(i))
end
end
if Inventory[i]==3144 then
if Menu.Item.BilgewaterCutlass:Value()then
ControlCastSpell(ItemSlotToHK(i),CURRENT_TARGET)
end
end
if Inventory[i]==3153 then
if Menu.Item.BladeoftheRuinedKing:Value()then
ControlCastSpell(ItemSlotToHK(i),CURRENT_TARGET)
end
end
if Inventory[i]==3146 then
if Menu.Item.HextechGunblade:Value()then
ControlCastSpell(ItemSlotToHK(i),CURRENT_TARGET)
end
end
if Inventory[i]==3142 then
if Menu.Item.YoumuusGhostblade:Value()then
ControlCastSpell(ItemSlotToHK(i))
end
end
end
end
--For loop END
elseif myHero.attackData.state==STATE_WINDUP then
--For 6 to 11;ITEM_1=6
for i=ITEM_1,ITEM_6 do
if Inventory[i]~=nil and myHero:GetSpellData(i).currentCd==0 then
if Inventory[i]==3748 then
if Menu.Item.TitanicHydra:Value()then
ControlCastSpell(ItemSlotToHK(i))
end
end
end
end
--For loop END
end
--STATE_WINDDOWN/STATE_WINDUP END
end
end
---------------
--Use Clear Item
---------------
function UseClearItem()
if not Menu.Item.Enable:Value()then return end
--item Usage
if isEnemyMinionOrJungleNearBy(350)then
if myHero.attackData.state==STATE_WINDDOWN then
--Get Inventory Items
local Inventory=GetInventoryItems()
for i=ITEM_1,ITEM_6 do--6 to 11;ITEM_1=6
if Inventory[i]~=nil and myHero:GetSpellData(i).currentCd==0 then
if Inventory[i]==3077 then
if Menu.Item.Tiamat:Value()then
ControlCastSpell(ItemSlotToHK(i))
end
end
if Inventory[i]==3074 then
if Menu.Item.RavenousHydra:Value()then
ControlCastSpell(ItemSlotToHK(i))
end
end
end
end
--Get Inventory Items END
end
end
--item Usage END
end
----------
--Yasuo Logic
----------
--Get Gap Close Enemies Minions
function GetGapCloseEnemiesMinions(pos,range)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable then
if GetDistanceSqr(minion.pos,pos)<=range*range and GetDistanceSqr(myHero.pos,minion.pos)<E.range*E.range and not HasBuff(minion,"YasuoDashWrapper")then
return minion
end
end
end
return false
end
--Get Gap Close Enemies Hero
function GetGapCloseEnemiesHero(pos,range,target)
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero~=target and hero.isEnemy and hero.alive and hero.isTargetable then
if GetDistanceSqr(hero.pos,pos)<=range*range and GetDistanceSqr(myHero.pos,hero.pos)<E.range*E.range and not HasBuff(hero,"YasuoDashWrapper")then
return hero
end
end
end
return false
end
--is Knocked Up
function isKnockedUp(unit)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if buff.count>0 and(buff.type==29 or buff.type==30 or buff.type==39)then
return true
end
end
return false
end
--Count Knocked Up Enemies
function CountKnockedUpEnemies(range)
local count=0
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero.isEnemy and hero.alive and GetDistanceSqr(myHero.pos,hero.pos)<=range*range then
if isKnockedUp(hero)then
count=count+1
end
end
end
return count
end
--Get Minion Pred
function GetMinionPred(unit,speed,delay)
if IsImmobileTarget(unit)or unit.posTo==unit.pos or not unit.pathing.isDashing then
return unit.pos
else
return unit:GetPrediction(speed,delay)
end
end
--Get Q3 Minion Target
function GetQ3MinionTarget(range)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable and GetDistanceSqr(myHero.pos,minion.pos)<=range*range then
if GetMinionCollision(minion.pos,Q3.width)>=Menu.Mode.LaneClear.Q3:Value()then
return minion
end
end
end
return false
end
--Get Minion Collision
function GetMinionCollision(castPos,width)
local Count=0
for i=LocalGameMinionCount(),1,-1 do
local minion=LocalGameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable then
local pointSegment,pointLine,isOnSegment=VectorPointProjectionOnLineSegment(myHero.pos,castPos,minion.pos)
local w=width+minion.boundingRadius
if isOnSegment and GetDistanceSqr(pointSegment,minion.pos)<w*w then
Count=Count+1
end
end
end
return Count
end
--Get Killable Minion Target
function GetKillableMinionTarget(range)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
local distance=GetDistance(myHero.pos,minion.pos)
if minion.isEnemy and minion.alive and minion.isTargetable and distance<=range then
local Edmg=({60,70,80,90,100})[myHero:GetSpellData(_E).level]+0.2*myHero.bonusDamage+0.6*myHero.ap
local afterEPos=minion.pos:Shortened(myHero.pos,E.range-distance)
if not HasBuff(minion,"YasuoDashWrapper")and CalcMagicalDamage(myHero,minion,Edmg)>=minion.health and not IsUnderTurret(afterEPos)then
return minion
end
end
end
return false
end
--Get E Minion Target
function GetEMinionTarget(range)
local range=range
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable and GetDistance(myHero.pos,minion.pos)<=range then
if not HasBuff(minion,"YasuoDashWrapper")and GetBestEPos(minion)then
return minion
end
end
end
return false
end
--GetBestEPos
function GetBestEPos(minion)
local afterEPos=minion.pos:Shortened(myHero.pos,E.range-GetDistance(myHero.pos,minion.pos))
if not IsUnderTurret(afterEPos)then
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable and GetDistance(minion.pos,afterEPos)<=AARange+50 then
return true
end
end
end
return false
end
----------
--Common
----------
--Is Under Turret
function IsUnderTurret(pos)
local turret=GetClosestEnemiesTurretTarget()
if turret and GetDistanceSqr(turret.pos,pos)<(turret.boundingRadius+750+myHero.boundingRadius)*(turret.boundingRadius+750+myHero.boundingRadius)then
return true
end
return false
end
--Is Ready Spell
function isReady(spell)
local data=myHero:GetSpellData(spell)
return data.currentCd==0 and data.level>0
end
--Is Enemy Minion or Jungle NearBy
function isEnemyMinionOrJungleNearBy(range)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.isEnemy and GetDistanceSqr(myHero.pos,minion.pos)<=range*range then
return true
end
end
return false
end
--Is Enemy Minion NearBy
function isEnemyMinionNearBy(range)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.team==200 and GetDistanceSqr(myHero.pos,minion.pos)<=range*range then
return true
end
end
return false
end
--Is Enemy NearBy
function isJungleNearBy(range)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.team==300 and GetDistanceSqr(myHero.pos,minion.pos)<=range*range then
return true
end
end
return false
end
--Is Enemy NearBy
function isEnemyNearBy(range)
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero.isEnemy and GetDistanceSqr(myHero.pos,hero.pos)<=range*range then
return true
end
end
return false
end
--Is Immobile Target
function IsImmobileTarget(unit)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if buff and(buff.type==5 or buff.type==11 or buff.type==29 or buff.type==24 or buff.name=="recall")and buff.count>0 then
return true
end
end
return false
end
--Has Buff
function HasBuff(unit,buffName)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if buff.name:lower()==buffName:lower()and buff.count>0 and buff.duration>0.3 then
return true
end
end
return false
end
--Get Closest Enemies Turret Target
function GetClosestEnemiesTurretTarget()
local distance=LocalMathHuge
local closest=false
for i=1,Game.TurretCount()do
local turret=Game.Turret(i)
if turret.isEnemy and turret.alive then
local tempDistance=GetDistance(myHero.pos,turret.pos)
if tempDistance<distance then
distance=tempDistance
closest=turret
end
end
end
return closest
end
--Get Closest Enemies Turret Target
function GetClosestEnemiesMinionsTarget(distance)
local distance=distance
local closest=false
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable then
local tempDistance=GetDistance(myHero.pos,minion.pos)
if tempDistance<distance then
distance=tempDistance
closest=minion
end
end
end
return closest
end
--Get a Target
function GetTarget(range)
if _G.SDK then
return _G.SDK.TargetSelector:GetTarget(range)
elseif _G.EOWLoaded then
return EOW:GetTarget(range)
elseif _G.Orbwalker.Enabled:Value()then
return GOS:GetTarget(range)
elseif _G.OrbwalkerPlus.Enabled:Value()then
return GOSPlus:GetTarget(range)
end
end
--Get Distance
function GetDistance(p1,p2)
return LocalMathSqrt(GetDistanceSqr(p1,p2))
end
--Get Distance*2
function GetDistanceSqr(p1,p2)
return(p1.x-p2.x)*(p1.x-p2.x)+((p1.z or p1.y)-(p2.z or p2.y))*((p1.z or p1.y)-(p2.z or p2.y))
end
--
function VectorPointProjectionOnLineSegment(v1,v2,v)
local cx,cy,ax,ay,bx,by=v.x,v.z,v1.x,v1.z,v2.x,v2.z
local rL=((cx-ax)*(bx-ax)+(cy-ay)*(by-ay))/((bx-ax)*(bx-ax)+(by-ay)*(by-ay))
local pointLine={x=ax+rL*(bx-ax),z=ay+rL*(by-ay)}
local rS=rL<0 and 0 or(rL>1 and 1 or rL)
local isOnSegment=rS==rL
local pointSegment=isOnSegment and pointLine or{x=ax+rS*(bx-ax),z=ay+rS*(by-ay)}
return pointSegment,pointLine,isOnSegment
end
--Calc Physical Damage
function CalcPhysicalDamage(source,target,amount)
local ArmorPenPercent=source.armorPenPercent
local ArmorPenFlat=source.armorPen*(0.6+(0.4*(target.levelData.lvl/18)))
local BonusArmorPen=source.bonusArmorPenPercent
local armor=target.armor
local bonusArmor=target.bonusArmor
local baseArmor=armor-bonusArmor
if bonusArmor<0 then print("CalcPhysicalDamage : smth wrong with "..source.charName.." on "..target.charName)end
local value=nil
if armor<=0 then
value=2-100/(100-armor)
else
baseArmor=baseArmor*ArmorPenPercent
bonusArmor=bonusArmor*ArmorPenPercent*BonusArmorPen
armor=baseArmor+bonusArmor
if armor>ArmorPenFlat then
armor=armor-ArmorPenFlat
end
value=100/(100+armor)
end
if target.type~=myHero.type then
return value*amount
end
if target.charName=="Garen"and HasBuff(target,"GarenW")then
amount=amount*0.7
elseif target.charName=="Alistar"and HasBuff(target,"Ferocious Howl")then
amount=amount*({0.5,0.4,0.3})[target:GetSpellData(_R).level]
elseif target.charName=="Galio"and HasBuff(target,"GalioIdolOfDurand")then
amount=amount*0.5
elseif target.charName=="MaoKai"and HasBuff(target,"MaokaiDrainDefense")then
amount=amount*0.7
elseif target.charName=="Gragas"and HasBuff(target,"GragasWSelf")then
amount=amount*({0.1,0.12,0.14,0.16,0.18})[target:GetSpellData(_W).level]
elseif target.charName=="Malzahar"and HasBuff(target,"malzaharpassiveshield")then
amount=amount*0.1
elseif target.charName=="MasterYi"and HasBuff(target,"Meditate")then
amount=amount-amount*({0.5,0.55,0.6,0.65,0.7})[target:GetSpellData(_W).level]
elseif target.charName=="Braum"and HasBuff(target,"BraumShieldRaise")then
amount=amount*(1-({0.3,0.325,0.35,0.375,0.4})[target:GetSpellData(_E).level])
elseif target.charName=="Urgot"and HasBuff(target,"urgotswapdef")then
amount=amount*(1-({0.3,0.4,0.5})[target:GetSpellData(_R).level])
elseif target.charName=="Amumu"and HasBuff(target,"Tantrum")then
amount=amount-({2,4,6,8,10})[target:GetSpellData(_E).level]
elseif target.charName=="Annie"and HasBuff(target,"MoltenShield")then
amount=amount*(1-({0.16,0.22,0.28,0.34,0.4})[target:GetSpellData(_E).level])
end
return value*amount
end
--Calc Magical Damage
function CalcMagicalDamage(source,target,amount)
local mr=target.magicResist
local value=100/(100+(mr*source.magicPenPercent)-source.magicPen)
if mr<0 then
value=2-100/(100-mr)
elseif(mr*source.magicPenPercent)-source.magicPen<0 then
value=1
end
return value*amount
end
local lastCast=GetTickCount()
function CastSpell(hotkey,pos)
if GetTickCount()-lastCast>250+GameLatency()and not myHero.isChanneling then
if pos~=nil then
ControlCastSpell(hotkey,pos)
else
ControlCastSpell(hotkey)
end
lastCast=GetTickCount()
end
end
----------
--Item Usage
----------
--Item Slot To HK
function ItemSlotToHK(Slot)
local ItemHK={[ITEM_1]=HK_ITEM_1,[ITEM_2]=HK_ITEM_2,[ITEM_3]=HK_ITEM_3,[ITEM_4]=HK_ITEM_4,[ITEM_5]=HK_ITEM_5,[ITEM_6]=HK_ITEM_6,[ITEM_7]=HK_ITEM_7,}
return ItemHK[Slot]
end
--Get Inventory Items
function GetInventoryItems()
local Inventory={[ITEM_1]=nil,[ITEM_2]=nil,[ITEM_3]=nil,[ITEM_4]=nil,[ITEM_5]=nil,[ITEM_6]=nil}
for i=ITEM_1,ITEM_6 do--6 to 11;ITEM_1=6
local itemID=myHero:GetItemData(i).itemID
if itemID~=0 and myHero:GetItemData(i).stacks>0 then--implies that is an item
Inventory[i]=itemID
end
end
return Inventory
end

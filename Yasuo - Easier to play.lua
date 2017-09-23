--Hero
if myHero.charName~="Yasuo"then return end
--lib
require"Eternal Prediction"
--Localize
local myHero=_G.myHero
local LocalSDK=_G.SDK
local LocalEOW=_G.EOWLoaded
local LocalGOS=_G.GOS
local LocalGameHeroCount=Game.HeroCount
local LocalGameHero=Game.Hero
local LocalGameMinionCount=Game.MinionCount
local LocalGameMinion=Game.Minion
local LocalGameCanUseSpell=Game.CanUseSpell
local LocalMathHuge=math.huge
local CastSpell=Control.CastSpell
local ITEM_1=_G.ITEM_1
local ITEM_2=_G.ITEM_2
local ITEM_3=_G.ITEM_3
local ITEM_4=_G.ITEM_4
local ITEM_5=_G.ITEM_5
local ITEM_6=_G.ITEM_6
local ITEM_7=_G.ITEM_7
local _Q=_G._Q
local _W=_G._W
local _E=_G._E
local _R=_G._R
local STATE_WINDUP=_G.STATE_WINDUP
local STATE_WINDDOWN=_G.STATE_WINDDOWN
local TEAM_ALLY=myHero.team
local TEAM_JUNGLE=300
local TEAM_ENEMY=300-TEAM_ALLY
--Spell
local Q={range=475,speed=1500,delay=0.25,width=55}
local Q3={name="YasuoQ3W",range=1000,speed=1500,delay=0.25,width=90}
local W={range=400,speed=500,delay=0.25,width=0}
local E={range=475,speed=20,delay=0.25,width=0}
local R={range=1200,speed=20,delay=0.25,width=0}
--OTHER
local QPred=Prediction:SetSpell(Q,TYPE_LINE,true)
local SpellList={"Q","W","E","R"}
local res=Game.Resolution()
local CURRENT_TARGET=nil
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
Menu.Mode.Combo:MenuElement({id="Gapclose",name="Gapclose with E",value=false,leftIcon=Icons.E})
Menu.Mode.Combo:MenuElement({id="DontGapclose",name="Don't Gapclose if Under Turret",value=true,leftIcon=Icons.E})
--Menu.Mode.Combo:MenuElement({id="W",name="Use W",value=true,leftIcon=Icons.W})
Menu.Mode.Combo:MenuElement({id="R",name="Use R",value=false,leftIcon=Icons.R})
--Main Menu--Mode Setting--Harass
--Menu.Mode:MenuElement({type=MENU,id="Harass",name="Harass"})
--Menu.Mode.Harass:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
--Menu.Mode.Harass:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
--Main Menu--Mode Setting--Clear
Menu.Mode:MenuElement({type=MENU,id="LaneClear",name="LaneClear"})
Menu.Mode.LaneClear:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.Mode.LaneClear:MenuElement({id="Q3",name="Min Minion to Use Q3 ",value=3,min=1,max=5,step=1,leftIcon=Icons.Q})
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
Menu.KillSteal:MenuElement({id="Gapclose",name="Gapclose with E",value=true,leftIcon=Icons.E})
Menu.KillSteal:MenuElement({id="DontGapclose",name="Don't Gapclose if Under Turret",value=true,leftIcon=Icons.E})
Menu.KillSteal:MenuElement({id="R",name="Use R",value=false,leftIcon=Icons.R})
Menu.KillSteal:MenuElement({type=MENU,id="WhiteList",name="White List",leftIcon=Icons.R})
Menu.KillSteal.WhiteList:MenuElement({type=SPACE,id="info",name="Detecting Heroes, Please Wait..."})
if Game.Timer()>30 then DelayAction(function()WhiteList()end,5)else DelayAction(function()WhiteList()end,30)end
--Main Menu--WindWall
Menu:MenuElement({type=MENU,id="WindWall",name="WindWall"})
Menu.WindWall:MenuElement({id="AutoW",name="Auto W Missile Spell",value=true,leftIcon=Icons.W})
Menu.WindWall:MenuElement({id="AutoWAA",name="Auto W Auto Attack",value=true,leftIcon=Icons.W})
Menu.WindWall:MenuElement({id="AutoWAAHp",name="Auto W AA if health is below:",value=20,min=5,max=95,identifier="%"})
--Main Menu--Misc
Menu:MenuElement({id="Misc",name="Misc",type=MENU})
Menu.Misc:MenuElement({id="AutoR",name="Auto R",value=true,leftIcon=Icons.R})
Menu.Misc:MenuElement({id="MinR",name="Min Enemies To Auto R",value=2,min=1,max=5,step=1})
Menu.Misc:MenuElement({id="AutoQEnemies",name="Auto Q Enemies",value=false,leftIcon=Icons.Q})
Menu.Misc:MenuElement({id="DontQEnemiesUnder",name="Don't Q Enemies Under Turret",value=true})
Menu.Misc:MenuElement({id="AutoQMinions",name="Auto Q Minions",value=false,leftIcon=Icons.Q})
Menu.Misc:MenuElement({id="DontQMinionsUnder",name="Don't Q Minions Under Turret",value=true})
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
function WhiteList()
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero.isEnemy then
Menu.KillSteal.WhiteList:MenuElement({id=hero.networkID,name="Use R On: "..hero.charName,value=true})
end
end
Menu.KillSteal.WhiteList.info:Remove()
end
---------
--DRAW--
---------
function OnDraw()
if myHero.dead or Menu.Drawing.DisableAll:Value()then return end
--Draw Range
for i=1,4 do
if Menu.Drawing[SpellList[i]].Enabled:Value()then
Draw.Circle(myHero.pos,myHero:GetSpellData(i-1).range,Menu.Drawing[SpellList[i]].Width:Value(),Menu.Drawing[SpellList[i]].Color:Value())
end
end
end
---------
--START--
---------
function OnTick()
if myHero.dead then return end
local Combo=Menu.Key.Combo:Value()
local Clear=Menu.Key.Clear:Value()
local Flee=Menu.Key.Flee:Value()
CURRENT_TARGET=(LocalSDK and LocalSDK.Orbwalker:IsEnabled()and LocalSDK.TargetSelector:GetTarget())or(LocalEOW and EOW:GetTarget())or(_G.Orbwalker.Enabled:Value()and GOS:GetTarget())
if Combo then
OnCombo()
elseif Clear then
OnClear()
elseif Flee then
OnFlee()
end
AutoWindwall()
AutoCast()
KillSteal()
end
---------
--AutoWindwall--
---------
function AutoWindwall()
if isReady(_W)then
for i=1,Game.MissileCount()do
local missile=Game.Missile(i)
local data=missile.missileData
--W Missile
if Menu.WindWall.AutoW:Value()then
if missile and missile.isEnemy and(missile.team<300)and(data.owner>0)and(data.target==0)and(data.speed>0)and(data.width>0)and(data.range>0)then
if(res.x*2>=missile.pos2D.x)and(res.x*-1<=missile.pos2D.x)and(res.y*2>=missile.pos2D.y)and(res.y*-1<=missile.pos2D.y)then
local endPos=data.endPos
local myPos=myHero.pos
local pointSegment,pointLine,isOnSegment=VectorPointProjectionOnLineSegment(missile.pos,endPos,myPos)--(posStart,posEnd,target)
local width=data.width+myHero.boundingRadius
if isOnSegment and GetDistanceSqr(pointSegment,myPos)<width*width then
local TimeToHit=((myPos:DistanceTo(missile.pos)-myHero.boundingRadius)/data.speed)
if TimeToHit<0.35 and TimeToHit>0.05 then
CastSpell(HK_W,myPos:Extended(data.startPos,200))
end
end
end
end
end
--W AA
if Menu.WindWall.AutoWAA:Value()then
if missile and missile.isEnemy and(missile.team<300)and(data.owner>0)and(data.target==myHero.handle)and(data.speed>0)and(data.range>0)then
if not data.name:find("SRU_")and(myHero.maxHealth*Menu.WindWall.AutoWAAHp:Value()*0.01)>myHero.health then
CastSpell(HK_W,myHero.pos:Extended(data.startPos,200))
end
end
end
end
end
end
---------
--AutoCast--
---------
function AutoCast()
if Menu.Misc.AutoR:Value()and isReady(_R)then
if isValidTarget(CURRENT_TARGET,R.range)then
if CountKnockedUpEnemies(R.range)>=Menu.Misc.MinR:Value()then
CastSpell(HK_R)
end
end
end
--Auto Q Minions if not Oncombo and OnClear
if not Clear and not Combo then
if Menu.Misc.AutoQMinions:Value()and isReady(_Q)then
if isMinionNearBy(600)then
if not HasBuff(myHero,Q3.name)then
--Q Closest Target
target=GetClosestEnemiesMinionsTarget(Q.range)
if target then
if target.distance<myHero.range+50 then
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
if not Combo then
if Menu.Misc.AutoQEnemies:Value()and isReady(_Q)then
--normal Q3
if HasBuff(myHero,Q3.name)then
if isValidTarget(CURRENT_TARGET,Q3.range)then
if CURRENT_TARGET.distance<myHero.range+50 then
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
if CURRENT_TARGET.distance<myHero.range+50 then
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
end
end
---------
--KillSteal--
---------
function KillSteal()
--KillSteal Q
if Menu.KillSteal.Q:Value()and isReady(_Q)then
if isEnemyNearBy(Q.range)then
--spell data
local levelQ=myHero:GetSpellData(_Q).level
local Qdmg=({20,40,60,80,100})[levelQ]+myHero.totalDamage
--loop
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.isEnemy and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=E.range then
if CalcPhysicalDamage(myHero,hero,Qdmg)>=hero.health+hero.shieldAD then
CastSpell(HK_Q,hero)
end
end
end
end
end
--KillSteal E
if Menu.KillSteal.E:Value()and isReady(_E)then
if isEnemyNearBy(1200)then
--spell data
local levelE=myHero:GetSpellData(_E).level
local levelQ=myHero:GetSpellData(_Q).level
local Edmg=({60,70,80,90,100})[levelE]+0.2*myHero.bonusDamage+0.6*myHero.ap
local Qdmg=({20,40,60,80,100})[levelQ]+myHero.totalDamage
--loop
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
local gapDistance=hero.distance
if hero and hero.isEnemy and hero.visible and hero.valid and hero.alive and hero.isTargetable and gapDistance<=1200 then
if gapDistance<E.range and not HasBuff(hero,"YasuoDashWrapper")then
if CalcMagicalDamage(myHero,hero,Edmg)+CalcPhysicalDamage(myHero,hero,myHero.totalDamage*(1+myHero.critChance))>=hero.health+hero.shieldAP then
CastSpell(HK_E,hero)
end
else
if Menu.KillSteal.Gapclose:Value()then
local TotalDamage=CalcMagicalDamage(myHero,hero,Edmg)+CalcPhysicalDamage(myHero,hero,Qdmg)+CalcPhysicalDamage(myHero,hero,myHero.totalDamage*(1+myHero.critChance))
if TotalDamage>=hero.health then
--GapClose
local minion=GetGapCloseEnimiesMinions(hero.pos,gapDistance-100)
local EnimiesHero=GetGapCloseEnimiesHero(hero.pos,gapDistance-100,hero)
if minion then
if Menu.KillSteal.DontGapclose:Value()then
local afterEPos=minion.pos:Shortened(myHero.pos,E.range-minion.distance)
if not IsUnderTurret(afterEPos)then
CastSpell(HK_E,minion)
end
else
CastSpell(HK_E,minion)
end
elseif EnimiesHero then
if Menu.KillSteal.DontGapclose:Value()then
local afterEPos=EnimiesHero.pos:Shortened(myHero.pos,E.range-EnimiesHero.distance)
if not IsUnderTurret(afterEPos)then
CastSpell(HK_E,EnimiesHero)
end
else
CastSpell(HK_E,EnimiesHero)
end
end
end
end
end
end
end
end
end
--KillSteal R
if Menu.KillSteal.R:Value()and isReady(_R)then
if isEnemyNearBy(R.range)then
--spell data
local levelR=myHero:GetSpellData(_R).level
local Rdmg=({200,300,400})[levelR]+1.5*myHero.bonusDamage
--loop
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.isEnemy and hero.visible and hero.valid and hero.alive and hero.isTargetable then
if Menu.KillSteal.WhiteList[hero.networkID]:Value()and isKnockedUp(hero)and hero.distance<=R.range then
if CalcPhysicalDamage(myHero,hero,Rdmg)>=hero.health+hero.shieldAD then
CastSpell(HK_R,hero)
end
end
end
end
end
end
end
---------
--Combo--
---------
function OnCombo()
if myHero.attackData.state==STATE_WINDUP or not CURRENT_TARGET then end
UseComboItem()
if Menu.Mode.Combo.Q:Value()and isReady(_Q)then
--normal Q3
if HasBuff(myHero,Q3.name)then
if isValidTarget(CURRENT_TARGET,Q3.range)then
if CURRENT_TARGET.distance<myHero.range+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=CURRENT_TARGET:GetPrediction(Q3.speed,Q3.delay+Game.Latency()/1000)
if pred then
CastSpell(HK_Q,pred)
end
end
else
local pred=CURRENT_TARGET:GetPrediction(Q3.speed,Q3.delay+Game.Latency()/1000)
if pred then
CastSpell(HK_Q,pred)
end
end
end
else
--normal Q
if isValidTarget(CURRENT_TARGET,Q.range)then
if CURRENT_TARGET.distance<myHero.range+50 then
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
--normal E
if Menu.Mode.Combo.E:Value()and isReady(_E)then
if isValidTarget(CURRENT_TARGET,1200)then
local gapDistance=CURRENT_TARGET.distance
if not HasBuff(CURRENT_TARGET,"YasuoDashWrapper")then
if gapDistance<E.range then
--E to target
local afterEPos=CURRENT_TARGET.pos:Shortened(myHero.pos,E.range-CURRENT_TARGET.distance)
if CURRENT_TARGET.pos:DistanceTo(afterEPos)<=myHero.range+50 then
CastSpell(HK_E,CURRENT_TARGET)
end
else
if Menu.Mode.Combo.Gapclose:Value()and isReady(_E)then
--GapClose
local minion=GetGapCloseEnimiesMinions(CURRENT_TARGET.pos,gapDistance-100)
local hero=GetGapCloseEnimiesHero(CURRENT_TARGET.pos,gapDistance-100,CURRENT_TARGET)
if minion then
if Menu.Mode.Combo.DontGapclose:Value()then
local afterEPos=minion.pos:Shortened(myHero.pos,E.range-minion.distance)
if not IsUnderTurret(afterEPos)then
CastSpell(HK_E,minion)
end
else
CastSpell(HK_E,minion)
end
elseif hero then
if Menu.Mode.Combo.DontGapclose:Value()then
local afterEPos=hero.pos:Shortened(myHero.pos,E.range-hero.distance)
if not IsUnderTurret(afterEPos)then
CastSpell(HK_E,hero)
end
else
CastSpell(HK_E,hero)
end
end
end
end
end
end
end
--normal R
if Menu.Mode.Combo.R:Value()and isReady(_R)then
if isValidTarget(CURRENT_TARGET,R.range)then
if isKnockedUp(CURRENT_TARGET)then
CastSpell(HK_R,CURRENT_TARGET)
end
end
end
end
---------
--Clear--
---------
function OnClear()
UseClearItem()
--LaneClear
if isMinionNearBy(600)then
if Menu.Mode.LaneClear.Q:Value()and isReady(_Q)then
if HasBuff(myHero,Q3.name)then
--Q3 if>=3 minion were attacked
local target=GetQ3Target(Q3.range)
if target then
if target.distance<myHero.range+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
CastSpell(HK_Q,pred)
end
end
else
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
CastSpell(HK_Q,pred)
end
end
end
else
--Q Closest Target
target=GetClosestEnemiesMinionsTarget(Q.range)
if target then
if target.distance<myHero.range+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
CastSpell(HK_Q,pred)
end
end
else
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
CastSpell(HK_Q,pred)
end
end
end
end
end
end
--E
if Menu.Mode.LaneClear.E:Value()and isReady(_E)then
--Enemies nearby
if isEnemyNearBy(1200)then
--KS with E
target=GetLowHPMinionTarget(E.range)
if target then
CastSpell(HK_E,target)
end
else
--E to minion if E After Pos near a minion
target=GetEMinionTarget(E.range)
if target then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_E,target)
end
end
--KS with E
target=GetLowHPMinionTarget(E.range)
if target then
CastSpell(HK_E,target)
end
end
end
--Jungleclear
if isJungleNearBy(600)then
--Q
if Menu.Mode.JungleClear.Q:Value()and isReady(_Q)then
--Q Closest Target
target=GetClosestEnemiesMinionsTarget(Q.range)
if target then
if target.distance<myHero.range+50 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
CastSpell(HK_Q,pred)
end
end
else
local pred=GetPred(target,Q.speed,Q.delay)
if pred then
CastSpell(HK_Q,pred)
end
end
end
end
--E
if Menu.Mode.JungleClear.E:Value()and isReady(_E)then
--E to minion if E After Pos near a minion
target=GetEMinionTarget(E.range)
if target then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_E,target)
end
end
--KS with E
target=GetLowHPMinionTarget(E.range)
if target then
CastSpell(HK_E,target)
end
end
end
end
---------
--Flee--
---------
function OnFlee()
if isMinionAndJungleNearBy(600)then
if Menu.Mode.Flee.E:Value()and isReady(_E)then
local gapDistance=myHero.pos:DistanceTo(mousePos)
--GapClose
local minion=GetGapCloseEnimiesMinions(mousePos,gapDistance-100)
local hero=GetGapCloseEnimiesHero(mousePos,gapDistance-100,CURRENT_TARGET)
if minion then
CastSpell(HK_E,minion)
elseif hero then
CastSpell(HK_E,hero)
end
end
end
end
function UseComboItem()
if not Menu.Item.Enable:Value()then return end
--item Usage
if isValidTarget(CURRENT_TARGET,450)then
--Use item STATE_WINDDOWN
if myHero.attackData.state==STATE_WINDDOWN then
local item=GetItemSlot(3077)
if item and Menu.Item.Tiamat:Value()then
CastSpell(SlotToHotKeys(item))
end
local item=GetItemSlot(3074)
if item and Menu.Item.RavenousHydra:Value()then
CastSpell(SlotToHotKeys(item))
end
local item=GetItemSlot(3143)
if item and Menu.Item.RanduinsOmen:Value()then
CastSpell(SlotToHotKeys(item))
end
local item=GetItemSlot(3144)
if item and Menu.Item.BilgewaterCutlass:Value()then
CastSpell(SlotToHotKeys(item),CURRENT_TARGET)
end
local item=GetItemSlot(3153)
if item and Menu.Item.BladeoftheRuinedKing:Value()then
CastSpell(SlotToHotKeys(item),CURRENT_TARGET)
end
local item=GetItemSlot(3146)
if item and Menu.Item.HextechGunblade:Value()then
CastSpell(SlotToHotKeys(item),CURRENT_TARGET)
end
end
if myHero.attackData.state==STATE_WINDUP then
local item=GetItemSlot(3748)
if item and Menu.Item.TitanicHydra:Value()then
CastSpell(SlotToHotKeys(item))
end
end
--Use item in range 450
local item=GetItemSlot(3142)
if item and Menu.Item.YoumuusGhostblade:Value()then
CastSpell(SlotToHotKeys(item))
end
end
end
function UseClearItem()
if not Menu.Item.Enable:Value()then return end
--item Usage
if isMinionAndJungleNearBy(350)then
if myHero.attackData.state==STATE_WINDDOWN then
local item=GetItemSlot(3077)
if item and Menu.Item.Tiamat:Value()then
CastSpell(SlotToHotKeys(item))
end
local item=GetItemSlot(3074)
if item and Menu.Item.RavenousHydra:Value()then
CastSpell(SlotToHotKeys(item))
end
end
end
end
function isMinionAndJungleNearBy(range)
local range=range
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
return true
end
end
return false
end
function isMinionNearBy(range)
local range=range
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team==200 and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
return true
end
end
return false
end
function isJungleNearBy(range)
local range=range
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team==300 and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
return true
end
end
return false
end
function isEnemyNearBy(range)
local range=range
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.isEnemy and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=range then
return true
end
end
return false
end
function GetItemSlot(itemID)
for i=ITEM_1,ITEM_6 do--6 to 11;ITEM_1=6
local ID=myHero:GetItemData(i).itemID
if ID~=0 and myHero:GetItemData(i).stacks>0 then--implies that is an item
if ID==itemID and myHero:GetSpellData(i).currentCd==0 then--implies that is an ward and ammo>0 and not cd ing
return i
end
end
end
return false
end
function SlotToHotKeys(slot)
local s={ITEM_1,ITEM_2,ITEM_3,ITEM_4,ITEM_5,ITEM_6,ITEM_7}
local hk={HK_ITEM_1,HK_ITEM_2,HK_ITEM_3,HK_ITEM_4,HK_ITEM_5,HK_ITEM_6,HK_ITEM_7}
for i=1,#s do
if slot==s[i]then
return hk[i]
end
end
end
function HasBuff(unit,buffName)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if buff.name:lower()==buffName:lower()and buff.count>0 and buff.duration>0.3 then
return true
end
end
return false
end
function mCollision(castPos,width)
local Count=0
for i=LocalGameMinionCount(),1,-1 do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable then
local pointSegment,pointLine,isOnSegment=VectorPointProjectionOnLineSegment(myHero.pos,castPos,minion.pos)
local w=width+minion.boundingRadius
local minionPos=minion.pos
if isOnSegment and GetDistanceSqr(pointSegment,minionPos)<w*w then
Count=Count+1
end
end
end
return Count
end
function VectorPointProjectionOnLineSegment(v1,v2,v)
local cx,cy,ax,ay,bx,by=v.x,v.z,v1.x,v1.z,v2.x,v2.z
local rL=((cx-ax)*(bx-ax)+(cy-ay)*(by-ay))/((bx-ax)*(bx-ax)+(by-ay)*(by-ay))
local pointLine={x=ax+rL*(bx-ax),z=ay+rL*(by-ay)}
local rS=rL<0 and 0 or(rL>1 and 1 or rL)
local isOnSegment=rS==rL
local pointSegment=isOnSegment and pointLine or{x=ax+rS*(bx-ax),z=ay+rS*(by-ay)}
return pointSegment,pointLine,isOnSegment
end
function GetDistanceSqr(p1,p2)
local dx,dz=p1.x-p2.x,p1.z-p2.z
return dx*dx+dz*dz
end
function GetClosestEnemiesMinionsTarget(distance)
local distance=distance or LocalMathHuge
local closest
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable then
if minion.distance<distance then
distance=minion.distance
closest=minion
end
end
end
return closest
end
function GetQ3Target(range)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
if mCollision(minion.pos,Q3.width)>=Menu.Mode.LaneClear.Q3:Value()then
return minion
end
end
end
return false
end
function GetPred(unit,speed,delay)
if IsImmobileTarget(unit)or unit.attackData.state==STATE_WINDUP or(unit.posTo==unit.pos)or(unit.posTo.x==0 and unit.posTo.y==0 and unit.posTo.z==0)then
return unit.pos
else
return unit:GetPrediction(speed,delay)
end
end
function IsImmobileTarget(unit)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if buff and(buff.type==5 or buff.type==11 or buff.type==29 or buff.type==24 or buff.name=="recall")and buff.count>0 then
return true
end
end
return false
end
function isReady(spell)
return LocalGameCanUseSpell(spell)==0
end
function GetEMinionTarget(range)
local range=range
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
if not HasBuff(minion,"YasuoDashWrapper")and GetBestEPos(minion)then
return minion
end
end
end
return false
end
function GetBestEPos(minion)
local afterEPos=minion.pos:Shortened(myHero.pos,E.range-minion.distance)
if not IsUnderTurret(afterEPos)then
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.pos:DistanceTo(afterEPos)<=myHero.range+50 then
return true
end
end
end
return false
end
function IsUnderTurret(pos)
local turret=GetClosestEnemiesTurretTarget()
if turret and turret.pos:DistanceTo(pos)<(turret.boundingRadius+750+myHero.boundingRadius)then
return true
end
return false
end
function GetClosestEnemiesTurretTarget(distance)
local distance=distance or LocalMathHuge
local closest
for i=1,Game.TurretCount()do
local turret=Game.Turret(i)
if turret and turret.isEnemy and turret.visible and turret.valid and turret.alive and turret.isTargetable then
if turret.distance<distance then
distance=turret.distance
closest=turret
end
end
end
return closest
end
function GetLowHPMinionTarget(range)
local range=range
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
local levelE=myHero:GetSpellData(_E).level
local Edmg=({60,70,80,90,100})[levelE]+0.2*myHero.bonusDamage+0.6*myHero.ap
local afterEPos=minion.pos:Shortened(myHero.pos,E.range-minion.distance)
if not HasBuff(minion,"YasuoDashWrapper")and Edmg>=minion.health and not IsUnderTurret(afterEPos)then
return minion
end
end
end
return false
end
function CountKnockedUpEnemies(range)
local range=range
local count=0
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.isEnemy and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=range then
if isKnockedUp(hero)then
count=count+1
end
end
end
return count
end
function isKnockedUp(unit)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if(buff.type==29 or buff.type==30 or buff.type==39)and buff.count>0 then
return true
end
end
return false
end
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
function GetGapCloseEnimiesMinions(pos,range)
local range=range or 800
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable then
if minion.pos:DistanceTo(pos)<=range and minion.distance<E.range and not HasBuff(minion,"YasuoDashWrapper")then
return minion
end
end
end
return false
end
function GetGapCloseEnimiesHero(pos,range,target)
local range=range or 800
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.isEnemy and hero~=target and hero.visible and hero.valid and hero.alive and hero.isTargetable then
if hero.pos:DistanceTo(pos)<=range and hero.distance<E.range and not HasBuff(hero,"YasuoDashWrapper")then
return hero
end
end
end
return false
end
function isValidTarget(unit,range)
return unit and unit.visible and unit.valid and unit.alive and unit.isTargetable and unit.distance<range
end

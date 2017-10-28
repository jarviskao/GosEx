if myHero.charName~="Yasuo"then return end
local MyName=myHero.charName
local AARange=myHero.range+myHero.boundingRadius
local AARangeSqr=AARange*AARange
local GameHeroCount=Game.HeroCount
local GameHero=Game.Hero
local GameMinionCount=Game.MinionCount
local GameMinion=Game.Minion
local GameCanUseSpell=Game.CanUseSpell
local DrawCircle=Draw.Circle
local DrawColor=Draw.Color
local MathHuge=math.huge
local MathSqrt=math.sqrt
local MathFloor=math.floor
local ControlSetCursorPos=Control.SetCursorPos
local ControlKeyDown=Control.KeyDown
local ControlMouse_event=Control.mouse_event
local ControlKeyUp=Control.KeyUp
local TableInsert=table.insert
local TableSort=table.sort
local MathMax=math.max
local MathMin=math.min
local GameTimer=Game.Timer
local GameIsChatOpen=Game.IsChatOpen
local GameLatency=Game.Latency
local ControlCastSpell=Control.CastSpell
local castSpell={state=0,tick=GetTickCount(),casting=GetTickCount()-1000,mouse=mousePos}
class"Yasuo"
function Yasuo:__init()
require"Eternal Prediction"
self.Q={range=475,speed=LocalMathHuge,delay=0.4,width=20}
self.Q3={name="YasuoQ3W",range=900,speed=1500,delay=0.5,width=90}
self.W={range=400,speed=500,delay=0.25,width=0}
self.E={range=475,speed=20,delay=0.25,width=0}
self.R={range=1200,speed=20,delay=0.25,width=0}
self.Icons={Menu="http://static.lolskill.net/img/champions/64/yasuo.png",Q="https://vignette4.wikia.nocookie.net/leagueoflegends/images/e/e5/Steel_Tempest.png",W="https://vignette3.wikia.nocookie.net/leagueoflegends/images/6/61/Wind_Wall.png",E="https://vignette4.wikia.nocookie.net/leagueoflegends/images/f/f8/Sweeping_Blade.png",R="https://vignette1.wikia.nocookie.net/leagueoflegends/images/c/c6/Last_Breath.png",}
self.QPred=Prediction:SetSpell(self.Q,TYPE_LINE,true)
self.Spell={"Q","W","E","R"}
Callback.Add("Load",function()self:Load()end)
end
function Yasuo:Load()
self:Menu()
Callback.Add("Tick",function()self:Tick()end)
Callback.Add("Draw",function()self:Draw()end)
end
function Yasuo:Menu()
--Main Menu
self.Menu=MenuElement({type=MENU,id="Menu",name="JarKao's "..MyName,leftIcon=self.Icons.Menu})
self.Menu:MenuElement({id="Enable",name="Enable",value=true})
--Main Menu--Key Setting
self.Menu:MenuElement({type=MENU,id="Key",name="Keys Settings"})
self.Menu.Key:MenuElement({id="Combo",name="Combo Key",key=32})
self.Menu.Key:MenuElement({id="Harass",name="Harass Key",key=string.byte("C")})
self.Menu.Key:MenuElement({id="Clear",name="Clear Key",key=string.byte("V")})
self.Menu.Key:MenuElement({id="LastHit",name="Last Hit Key",key=string.byte("X")})
self.Menu.Key:MenuElement({id="Flee",name="Flee Key",key=string.byte("A")})
--Main Menu--Mode Setting
self.Menu:MenuElement({type=MENU,id="Mode",name="Mode Settings"})
--Main Menu--Mode Setting--Combo
self.Menu.Mode:MenuElement({type=MENU,id="Combo",name="Combo"})
self.Menu.Mode.Combo:MenuElement({id="Q",name="Use Q",value=true,leftIcon=self.Icons.Q})
self.Menu.Mode.Combo:MenuElement({id="E",name="Use E",value=true,leftIcon=self.Icons.E})
self.Menu.Mode.Combo:MenuElement({id="Gapclose",name="Use E To Gapclose",value=true,leftIcon=self.Icons.E})
self.Menu.Mode.Combo:MenuElement({id="EUnderTurret",name="Use E Under Turret",value=false,leftIcon=self.Icons.E})
self.Menu.Mode.Combo:MenuElement({id="R",name="Use R",value=false,leftIcon=self.Icons.R})
--Main Menu--Mode Setting--Clear
self.Menu.Mode:MenuElement({type=MENU,id="LaneClear",name="LaneClear"})
self.Menu.Mode.LaneClear:MenuElement({id="Q",name="Use Q",value=true,leftIcon=self.Icons.Q})
self.Menu.Mode.LaneClear:MenuElement({id="Q3",name="Use Q3 If Hit X Minion ",value=3,min=1,max=5,step=1,leftIcon=self.Icons.Q})
self.Menu.Mode.LaneClear:MenuElement({id="E",name="Use E",value=true,leftIcon=self.Icons.E})
self.Menu.Mode:MenuElement({type=MENU,id="JungleClear",name="JungleClear"})
self.Menu.Mode.JungleClear:MenuElement({id="Q",name="Use Q",value=true,leftIcon=self.Icons.Q})
self.Menu.Mode.JungleClear:MenuElement({id="E",name="Use E",value=true,leftIcon=self.Icons.E})
--Main Menu--Mode Setting--Flee
self.Menu.Mode:MenuElement({type=MENU,id="Flee",name="Flee"})
self.Menu.Mode.Flee:MenuElement({id="E",name="Use E",value=true,leftIcon=self.Icons.E})
--Main Menu--KillSteal
self.Menu:MenuElement({type=MENU,id="KillSteal",name="KillSteal"})
self.Menu.KillSteal:MenuElement({id="Q",name="Use Q",value=true,leftIcon=self.Icons.Q})
self.Menu.KillSteal:MenuElement({id="E",name="Use E",value=true,leftIcon=self.Icons.E})
--Main Menu--AutoCastSpell
self.Menu:MenuElement({id="AutoCastSpell",name="Auto Cast Spell",type=MENU})
--Main Menu--AutoCastSpell--Auto Q
self.Menu.AutoCastSpell:MenuElement({type=MENU,id="AutoQ",name="Auto Q (broken)"})
self.Menu.AutoCastSpell.AutoQ:MenuElement({id="QEnemies",name="Q Enemies",value=false,leftIcon=self.Icons.Q})
self.Menu.AutoCastSpell.AutoQ:MenuElement({id="QEnemiesUnder",name="Q Enemies Under Turret",value=false,leftIcon=self.Icons.Q})
self.Menu.AutoCastSpell.AutoQ:MenuElement({id="QMinions",name="Q Minions",value=false,leftIcon=self.Icons.Q})
self.Menu.AutoCastSpell.AutoQ:MenuElement({id="QMinionsUnder",name="Q Minions Under Turret",value=false,leftIcon=self.Icons.Q})
--Main Menu--AutoCastSpell--WindWall
self.Menu.AutoCastSpell:MenuElement({type=MENU,id="AutoW",name="Auto W"})
self.Menu.AutoCastSpell.AutoW:MenuElement({id="W",name="W Missile Spell",value=true,leftIcon=self.Icons.W})
self.Menu.AutoCastSpell.AutoW:MenuElement({id="WAA",name="W Auto Attack",value=true,leftIcon=self.Icons.W})
self.Menu.AutoCastSpell.AutoW:MenuElement({id="WAAHp",name="W Auto Attack If Health Below:",value=20,min=5,max=95,identifier="%",leftIcon=self.Icons.W})
--Main Menu--AutoCastSpell--Auto R
self.Menu.AutoCastSpell:MenuElement({type=MENU,id="AutoR",name="Auto R"})
self.Menu.AutoCastSpell.AutoR:MenuElement({id="R",name="R",value=true,leftIcon=self.Icons.R})
self.Menu.AutoCastSpell.AutoR:MenuElement({id="MinR",name="R if Hit X Enemies",value=2,min=1,max=5,step=1,leftIcon=self.Icons.R})
--Main Menu--Drawing
self.Menu:MenuElement({type=MENU,id="Drawing",name="Drawing"})
self.Menu.Drawing:MenuElement({id="DisableAll",name="Disable All Drawings",value=true})
for i=1,4 do
local s=self.Spell[i]
self.Menu.Drawing:MenuElement({id=s,name="Draw "..s.." Range",type=MENU,leftIcon=self.Icons[s]})
self.Menu.Drawing[s]:MenuElement({id="Enabled",name="Enabled",value=true})
self.Menu.Drawing[s]:MenuElement({id="Width",name="Width",value=2,min=1,max=5,step=1})
self.Menu.Drawing[s]:MenuElement({id="Color",name="Color",color=DrawColor(255,255,255,255)})
end
end
function Yasuo:Draw()
if myHero.dead or self.Menu.Drawing.DisableAll:Value()then return end
--Draw Range
for i=1,4 do
local s=self.Spell[i]
if self.Menu.Drawing[s].Enabled:Value()then
DrawCircle(myHero.pos,myHero:GetSpellData(i-1).range,self.Menu.Drawing[s].Width:Value(),self.Menu.Drawing[s].Color:Value())
end
end
end
function Yasuo:Tick()
if self.Menu.Enable:Value()==false or myHero.dead then return end
if self.Menu.Key.Combo:Value()then
self:OnCombo()
elseif self.Menu.Key.Clear:Value()then
self:OnClear()
elseif self.Menu.Key.Flee:Value()then
self:OnFlee()
end
self:AutoWindwall()
self:AutoCastSpell()
self:KillSteal()
end
function Yasuo:OnCombo()
if myHero.attackData.state==STATE_WINDUP then return end
--Q Logic
if self.Menu.Mode.Combo.Q:Value()and isReady(_Q)then
--Q3
if HasBuff(myHero,self.Q3.name)then
local target=GetTarget(self.Q3.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
local costPos=target:GetPrediction(self.Q3.speed,self.Q3.delay)
CastSpell(HK_Q,costPos,self.Q.delay)
end
else
local costPos=target:GetPrediction(self.Q3.speed,self.Q3.delay)
CastSpell(HK_Q,costPos,self.Q.delay)
end
end
else
--Q1
local target=GetTarget(self.Q.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=self.QPred:GetPrediction(target,myHero.pos)
if pred and pred.hitChance>=0.22 then
CastSpell(HK_Q,pred.castPos,self.Q.delay)
end
end
else
local pred=self.QPred:GetPrediction(target,myHero.pos)
if pred and pred.hitChance>=0.22 then
CastSpell(HK_Q,pred.castPos,self.Q.delay)
end
end
end
end
end
--E Logic
if self.Menu.Mode.Combo.E:Value()and isReady(_E)then
local target=GetTarget(1200)
if target then
local gapDistance=GetDistance(myHero.pos,target.pos)
if not HasBuff(target,"YasuoDashWrapper")then
--E to target if in E Range
if gapDistance<self.E.range then
--if after E can AA target
local afterEPos=target.pos:Shortened(myHero.pos,self.E.range-gapDistance)
if GetDistanceSqr(afterEPos,target.pos)<=AARangeSqr then
CastSpell(HK_E,target)
end
else
--E to minion if out of E Range
if self.Menu.Mode.Combo.Gapclose:Value()and isReady(_E)then
--GapClose
local minion=self:GetGapCloseEnemiesMinions(target.pos,gapDistance-100)
if minion then
if self.Menu.Mode.Combo.EUnderTurret:Value()then
CastSpell(HK_E,minion)
else
local afterEPos=minion.pos:Shortened(myHero.pos,self.E.range-GetDistance(myHero.pos,minion.pos))
if not IsUnderTurret(afterEPos)then
CastSpell(HK_E,minion)
end
end
else
local hero=self:GetGapCloseEnemiesHero(target.pos,gapDistance-100,target)
if hero then
if self.Menu.Mode.Combo.EUnderTurret:Value()then
CastSpell(HK_E,hero)
else
local afterEPos=hero.pos:Shortened(myHero.pos,self.E.range-GetDistance(myHero.pos,hero.pos))
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
if self.Menu.Mode.Combo.R:Value()and isReady(_R)then
local target=GetTarget(self.R.range)
if target then
if isKnockedUp(target)then
ControlCastSpell(HK_R,target)
end
end
end
end
function Yasuo:OnClear()
--LaneClear Q
if self.Menu.Mode.LaneClear.Q:Value()and isReady(_Q)then
--Use Q3 if has Q3
if HasBuff(myHero,self.Q3.name)then
local target=self:GetQ3MinionTarget(self.Q3.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
local castPos=GetMinionPred(target,self.Q3.speed,self.Q3.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
else
local castPos=GetMinionPred(target,self.Q3.speed,self.Q3.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
end
else
--Q Closest Target
local target=GetQ1MinionTarget(self.Q.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
local castPos=GetMinionPred(target,self.Q.speed,self.Q.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
else
local castPos=GetMinionPred(target,self.Q.speed,self.Q.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
end
end
end
--LaneClear E
if self.Menu.Mode.LaneClear.E:Value()and isReady(_E)then
if GetTarget(1000)==nil then
--E to minion if E After Pos near a minion
local target=GetEMinionTarget(self.E.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_E,target)
end
else
CastSpell(HK_E,target)
end
end
--KS with E
local target=GetKillableMinionTarget(self.E.range)
if target then
CastSpell(HK_E,target)
end
end
end
--JungleClear Q
if self.Menu.Mode.LaneClear.Q:Value()and isReady(_Q)then
--Use Q3 if has Q3
if HasBuff(myHero,self.Q3.name)then
local target=self:GetQ3JungleTarget(self.Q3.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
local castPos=GetMinionPred(target,self.Q3.speed,self.Q3.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
else
local castPos=GetMinionPred(target,self.Q3.speed,self.Q3.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
end
else
--Q Closest Target
local target=GetQ1JungleTarget(self.Q.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
local castPos=GetMinionPred(target,self.Q.speed,self.Q.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
else
local castPos=GetMinionPred(target,self.Q.speed,self.Q.delay)
CastSpell(HK_Q,castPos,self.Q.delay)
end
end
end
end
--JungleClear E
if self.Menu.Mode.JungleClear.E:Value()and isReady(_E)then
--E to minion if E After Pos near a minion
local target=GetEJungleTarget(self.E.range)
if target then
if GetDistanceSqr(myHero.pos,target.pos)<=AARangeSqr then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_E,target)
end
else
CastSpell(HK_E,target)
end
end
--KS with E
local target=GetKillableJungleTarget(self.E.range)
if target then
CastSpell(HK_E,target)
end
end
end
function Yasuo:OnFlee()
if self.Menu.Mode.Flee.E:Value()and isReady(_E)then
local gapDistance=GetDistance(myHero.pos,mousePos)
--GapClose
local minion=self:GetGapCloseEnemiesMinions(mousePos,gapDistance-100)
if minion then
CastSpell(HK_E,minion)
else
local hero=self:GetGapCloseEnemiesHero(mousePos,gapDistance-100)
if hero then
CastSpell(HK_E,hero)
end
end
end
end
function Yasuo:KillSteal()
--KillSteal Q
if self.Menu.KillSteal.Q:Value()and isReady(_Q)then
--spell data
local Qdmg=({20,40,60,80,100})[myHero:GetSpellData(_Q).level]+myHero.totalDamage
local QRangeSqr=self.Q.range*self.Q.range
--loop
for i=1,GameHeroCount()do
local hero=GameHero(i)
if hero.isEnemy and hero.alive and hero.isTargetable and GetDistanceSqr(myHero.pos,hero.pos)<=QRangeSqr then
if CalcPhysicalDamage(myHero,hero,Qdmg)>=hero.health+hero.shieldAD then
CastSpell(HK_Q,hero,self.Q.delay)
end
end
end
end
--KillSteal E
if self.Menu.KillSteal.E:Value()and isReady(_E)then
--spell data
local Edmg=({60,70,80,90,100})[myHero:GetSpellData(_E).level]+0.2*myHero.bonusDamage+0.6*myHero.ap
local ERangeSqr=self.E.range*self.E.range
--loop
for i=1,GameHeroCount()do
local hero=GameHero(i)
local gapDistanceSqr=GetDistanceSqr(myHero.pos,hero.pos)
if hero.isEnemy and hero.alive and hero.isTargetable and gapDistanceSqr<=ERangeSqr and not HasBuff(hero,"YasuoDashWrapper")then
if CalcMagicalDamage(myHero,hero,Edmg)+CalcPhysicalDamage(myHero,hero,myHero.totalDamage*(1+myHero.critChance))>=hero.health+hero.shieldAP then
CastSpell(HK_E,hero)
end
end
end
end
end
function Yasuo:AutoCastSpell()
if self.Menu.AutoCastSpell.AutoR.R:Value()and isReady(_R)then
if CountKnockedUpEnemies(self.R.range)>=self.Menu.AutoCastSpell.AutoR.MinR:Value()then
ControlCastSpell(HK_R)
end
end
end
function Yasuo:AutoWindwall()
--W Missile Spell
if self.Menu.AutoCastSpell.AutoW.W:Value()and isReady(_W)then
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
if self.Menu.AutoCastSpell.AutoW.WAA:Value()and isReady(_W)and myHero.maxHealth*self.Menu.AutoCastSpell.AutoW.WAAHp:Value()*0.01>myHero.health then
local target=GetTarget(650)
if target and target.activeSpell.target==myHero.handle then
CastSpell(HK_W,target)
end
end
end
--Get Gap Close Enemies Minions
function Yasuo:GetGapCloseEnemiesMinions(pos,range)
local rangeSqr=range*range
local ERangeSqr=self.E.range*self.E.range
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable then
if GetDistanceSqr(minion.pos,pos)<=rangeSqr and GetDistanceSqr(myHero.pos,minion.pos)<ERangeSqr and not HasBuff(minion,"YasuoDashWrapper")then
return minion
end
end
end
return false
end
--Get Gap Close Enemies Hero
function Yasuo:GetGapCloseEnemiesHero(pos,range,target)
local rangeSqr=range*range
local ERangeSqr=self.E.range*self.E.range
for i=1,GameHeroCount()do
local hero=GameHero(i)
if hero.isEnemy and hero~=target and hero.alive and hero.isTargetable then
if GetDistanceSqr(hero.pos,pos)<=rangeSqr and GetDistanceSqr(myHero.pos,hero.pos)<ERangeSqr and not HasBuff(hero,"YasuoDashWrapper")then
return hero
end
end
end
return false
end
Yasuo()
class"ItemUsage"
function ItemUsage:__init()
self.ItemKey={[ITEM_1]=HK_ITEM_1,[ITEM_2]=HK_ITEM_2,[ITEM_3]=HK_ITEM_3,[ITEM_4]=HK_ITEM_4,[ITEM_5]=HK_ITEM_5,[ITEM_6]=HK_ITEM_6,[ITEM_7]=HK_ITEM_7}
self.Inventory={[ITEM_1]=nil,[ITEM_2]=nil,[ITEM_3]=nil,[ITEM_4]=nil,[ITEM_5]=nil,[ITEM_6]=nil}
self.Icons={Menu="https://i2.wp.com/img.talkandroid.com/uploads/2014/03/htc_dot_view_app_icon-450x450.png",Tiamat="https://vignette2.wikia.nocookie.net/leagueoflegends/images/e/e3/Tiamat_item.png",RavenousHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/e/e8/Ravenous_Hydra_item.png",TitanicHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/2/22/Titanic_Hydra_item.png",YoumuusGhostblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/4/41/Youmuu%27s_Ghostblade_item.png",RanduinsOmen="https://vignette1.wikia.nocookie.net/leagueoflegends/images/0/08/Randuin%27s_Omen_item.png",BilgewaterCutlass="https://vignette1.wikia.nocookie.net/leagueoflegends/images/4/44/Bilgewater_Cutlass_item.png",BladeoftheRuinedKing="https://vignette2.wikia.nocookie.net/leagueoflegends/images/2/2f/Blade_of_the_Ruined_King_item.png",HextechGunblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/6/64/Hextech_Gunblade_item.png"}
Callback.Add("Load",function()self:Load()end)
end
function ItemUsage:Load()
self:Menu()
Callback.Add("Tick",function()self:Tick()end)
end
function ItemUsage:Menu()
self.Menu=MenuElement({type=MENU,id="Menu",name="JarKao's Item Usage",leftIcon=self.Icons.Menu})
self.Menu:MenuElement({id="Enable",name="Enable",value=true})
self.Menu:MenuElement({type=MENU,id="Key",name="Keys Settings"})
self.Menu.Key:MenuElement({id="Combo",name="Use Combo Items",key=32})
self.Menu.Key:MenuElement({id="Clear",name="Use Clear Items",key=string.byte("V")})
self.Menu:MenuElement({type=MENU,id="Item",name="Items"})
self.Menu.Item:MenuElement({id="Tiamat",name="Tiamat",value=true,leftIcon=self.Icons.Tiamat})
self.Menu.Item:MenuElement({id="RavenousHydra",name="Ravenous Hydra",value=true,leftIcon=self.Icons.RavenousHydra})
self.Menu.Item:MenuElement({id="TitanicHydra",name="Titanic Hydra",value=true,leftIcon=self.Icons.TitanicHydra})
self.Menu.Item:MenuElement({id="YoumuusGhostblade",name="Youmuu's Ghostblade",value=true,leftIcon=self.Icons.YoumuusGhostblade})
self.Menu.Item:MenuElement({id="RanduinsOmen",name="Randuin's Omen",value=true,leftIcon=self.Icons.RanduinsOmen})
self.Menu.Item:MenuElement({id="BilgewaterCutlass",name="Bilgewater Cutlass",value=true,leftIcon=self.Icons.BilgewaterCutlass})
self.Menu.Item:MenuElement({id="BladeoftheRuinedKing",name="Blade of the Ruined King",value=true,leftIcon=self.Icons.BladeoftheRuinedKing})
self.Menu.Item:MenuElement({id="HextechGunblade",name="Hextech Gunblade",value=true,leftIcon=self.Icons.HextechGunblade})
end
function ItemUsage:Tick()
if self.Menu.Enable:Value()==false or myHero.dead then return end
if self.Menu.Key.Combo:Value()then
self:UseComboItem()
elseif self.Menu.Key.Clear:Value()then
self:UseClearItem()
end
end
function ItemUsage:UseComboItem()
if not self.Menu.Enable:Value()then return end
local target=GetTarget(450)
--item Usage
if target then
--Get Inventory Items
local Inventory=self:GetInventoryItems()
--STATE_WINDDOWN/STATE_WINDUP
if myHero.attackData.state==STATE_WINDDOWN then
--For 6 to 11;ITEM_1=6
for i=ITEM_1,ITEM_6 do
local item=Inventory[i]
local hotkey=self.ItemKey[i]
if item~=nil and myHero:GetSpellData(i).currentCd==0 then
if item==3077 then
if self.Menu.Item.Tiamat:Value()then
ControlCastSpell(hotkey)
end
end
if item==3074 then
if self.Menu.Item.RavenousHydra:Value()then
ControlCastSpell(hotkey)
end
end
if item==3143 then
if self.Menu.Item.RanduinsOmen:Value()then
ControlCastSpell(hotkey)
end
end
if item==3144 then
if self.Menu.Item.BilgewaterCutlass:Value()then
ControlCastSpell(hotkey,target.pos)
end
end
if item==3153 then
if self.Menu.Item.BladeoftheRuinedKing:Value()then
ControlCastSpell(hotkey,target.pos)
end
end
if item==3146 then
if self.Menu.Item.HextechGunblade:Value()then
ControlCastSpell(hotkey,target.pos)
end
end
if item==3142 then
if self.Menu.Item.YoumuusGhostblade:Value()then
ControlCastSpell(hotkey)
end
end
end
end
--For loop END
elseif myHero.attackData.state==STATE_WINDUP then
--For 6 to 11;ITEM_1=6
for i=ITEM_1,ITEM_6 do
local item=Inventory[i]
if item~=nil and myHero:GetSpellData(i).currentCd==0 then
if item==3748 then
if self.Menu.Item.TitanicHydra:Value()then
ControlCastSpell(self.ItemKey[i])
end
end
end
end
--For loop END
end
--STATE_WINDDOWN/STATE_WINDUP END
end
end
function ItemUsage:UseClearItem()
if not self.Menu.Enable:Value()then return end
--item Usage
if isEnemyMinionNearBy(350)then
if myHero.attackData.state==STATE_WINDDOWN then
--Get Inventory Items
local Inventory=self:GetInventoryItems()
for i=ITEM_1,ITEM_6 do--6 to 11;ITEM_1=6
local item=Inventory[i]
local hotkey=self.ItemKey[i]
if item~=nil and myHero:GetSpellData(i).currentCd==0 then
if item==3077 then
if self.Menu.Item.Tiamat:Value()then
ControlCastSpell(hotkey)
end
end
if item==3074 then
if self.Menu.Item.RavenousHydra:Value()then
ControlCastSpell(hotkey)
end
end
end
end
--Get Inventory Items END
end
end
--item Usage END
end
function ItemUsage:GetInventoryItems()
for i=ITEM_1,ITEM_6 do--6 to 11;ITEM_1=6
local itemID=myHero:GetItemData(i).itemID
if itemID~=0 and myHero:GetItemData(i).stacks>0 then--implies that is an item
self.Inventory[i]=itemID
else
self.Inventory[i]=nil
end
end
return self.Inventory
end
ItemUsage()
----------
--Yasuo Logic
----------
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
local rangeSqr=range*range
for i=1,GameHeroCount()do
local hero=GameHero(i)
if hero.isEnemy and hero.alive and GetDistanceSqr(myHero.pos,hero.pos)<=rangeSqr then
if isKnockedUp(hero)then
count=count+1
end
end
end
return count
end
--Get Minion Pred
function GetMinionPred(unit,speed,delay)
if IsImmobileTarget(unit)or not unit.pathing.isDashing then
return unit.pos
else
return unit:GetPrediction(speed,delay)
end
end
--Get Q3 Minion Target
function Yasuo:GetQ3MinionTarget(range)
local rangeSqr=range*range
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable and GetDistanceSqr(myHero.pos,minion.pos)<=rangeSqr then
if GetMinionCollision(minion.pos,self.Q3.width)>=self.Menu.Mode.LaneClear.Q3:Value()then
return minion
end
end
end
return false
end
--Get Q3 Minion Target
function Yasuo:GetQ3JungleTarget(range)
local rangeSqr=range*range
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable and GetDistanceSqr(myHero.pos,minion.pos)<=rangeSqr then
return minion
end
end
return false
end
function GetMinionCollision(castPos,width,exclude)
local Count=0
local w=(width+48)*(width+48)
for i=GameMinionCount(),1,-1 do
local minion=GameMinion(i)
if minion.isEnemy and minion~=exclude and minion.alive and minion.isTargetable then
local pointSegment,pointLine,isOnSegment=VectorPointProjectionOnLineSegment(myHero.pos,castPos,minion.pos)
if isOnSegment and GetDistanceSqr(pointSegment,minion.pos)<w then
Count=Count+1
end
end
end
return Count
end
--Get Closest Enemies Turret Target
function GetQ1MinionTarget(distance)
local distance=distance
local closest=false
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.team==200 and minion.alive and minion.isTargetable then
local tempDistance=GetDistance(myHero.pos,minion.pos)
if tempDistance<distance then
distance=tempDistance
closest=minion
end
end
end
return closest
end
--Get Closest Enemies Turret Target
function GetQ1JungleTarget(distance)
local distance=distance
local closest=false
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.team==300 and minion.alive and minion.isTargetable then
local tempDistance=GetDistance(myHero.pos,minion.pos)
if tempDistance<distance then
distance=tempDistance
closest=minion
end
end
end
return closest
end
--Get E Minion Target
function GetEMinionTarget(range)
local rangeSqr=range*range
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.team==200 and minion.alive and minion.isTargetable and GetDistanceSqr(myHero.pos,minion.pos)<=rangeSqr then
if not HasBuff(minion,"YasuoDashWrapper")and GetBestEPos(minion)then
return minion
end
end
end
return false
end
--Get E Jungle Target
function GetEJungleTarget(range)
local rangeSqr=range*range
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.team==300 and minion.alive and minion.isTargetable and GetDistanceSqr(myHero.pos,minion.pos)<=rangeSqr then
if not HasBuff(minion,"YasuoDashWrapper")and GetBestEPos(minion)then
return minion
end
end
end
return false
end
--GetBestEPos
function GetBestEPos(minion)
local afterEPos=minion.pos:Shortened(myHero.pos,475-GetDistance(myHero.pos,minion.pos))
if not IsUnderTurret(afterEPos)then
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and minion.alive and minion.isTargetable and GetDistanceSqr(minion.pos,afterEPos)<=AARangeSqr then
return true
end
end
end
return false
end
--Get Killable Minion Target
function GetKillableMinionTarget(range)
local Edmg=({60,70,80,90,100})[myHero:GetSpellData(_E).level]+0.2*myHero.bonusDamage+0.6*myHero.ap
for i=1,GameMinionCount()do
local minion=GameMinion(i)
local distance=GetDistance(myHero.pos,minion.pos)
if minion.isEnemy and minion.team==200 and minion.alive and minion.isTargetable and distance<=range then
local afterEPos=minion.pos:Shortened(myHero.pos,475-distance)
if not HasBuff(minion,"YasuoDashWrapper")and CalcMagicalDamage(myHero,minion,Edmg)>=minion.health and not IsUnderTurret(afterEPos)then
return minion
end
end
end
return false
end
--Get Killable Jungle Target
function GetKillableJungleTarget(range)
local Edmg=({60,70,80,90,100})[myHero:GetSpellData(_E).level]+0.2*myHero.bonusDamage+0.6*myHero.ap
for i=1,GameMinionCount()do
local minion=GameMinion(i)
local distance=GetDistance(myHero.pos,minion.pos)
if minion.isEnemy and minion.team==300 and minion.alive and minion.isTargetable and distance<=range then
local afterEPos=minion.pos:Shortened(myHero.pos,475-distance)
if not HasBuff(minion,"YasuoDashWrapper")and CalcMagicalDamage(myHero,minion,Edmg)>=minion.health and not IsUnderTurret(afterEPos)then
return minion
end
end
end
return false
end
------------
--Common--
------------
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
function GetTarget(range)
if _G.SDK then
return _G.SDK.TargetSelector:GetTarget(range)
elseif _G.EOWLoaded then
return EOW:GetTarget(range)
elseif _G.Orbwalker.Enabled:Value()then
return GOS:GetTarget(range)
end
end
--Get Closest Enemies Turret Target
function GetClosestEnemiesTurretTarget()
local distance=MathHuge
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
function HasBuff(unit,buffName)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if buff.name:lower()==buffName:lower()and buff.count>0 then
return true
end
end
return false
end
--Is Under Turret
function IsUnderTurret(pos)
local turret=GetClosestEnemiesTurretTarget()
if turret and GetDistanceSqr(turret.pos,pos)<=(turret.boundingRadius+760+myHero.boundingRadius)*(turret.boundingRadius+760+myHero.boundingRadius)then
return true
end
return false
end
--Is Ready Spell
function isReady(spell)
local data=myHero:GetSpellData(spell)
return data.currentCd==0 and data.level>0
end
--[[function isAttacking()
if _G.GOSPlus then
return GOSPlus:IsAttacking()
elseif _G.GOS then
return GOS:IsAttacking()
end
return false
end
function CastSpell(hotkey,unit,range,delay)
local delay=delay or 250
local ticker=GetTickCount()
if castSpell.state==0 and not myHero.isChanneling and not isAttacking()and ticker-castSpell.casting>delay+Game.Latency()then
castSpell.state=1
castSpell.mouse=mousePos
castSpell.tick=ticker
end
if castSpell.state==1 then
if ticker-castSpell.tick<Game.Latency()then
Control.SetCursorPos(unit)
Control.KeyDown(hotkey)
Control.KeyUp(hotkey)
castSpell.casting=ticker+delay
DelayAction(function()
if castSpell.state==1 then
Control.SetCursorPos(castSpell.mouse)
castSpell.state=0
end
end,Game.Latency()*0.001)
end
if ticker-castSpell.casting>Game.Latency()then
Control.SetCursorPos(castSpell.mouse)
castSpell.state=0
end
end
end
function SetOrbAttack(bool)
if _G.SDK then
_G.SDK.Orbwalker:SetAttack(bool)
elseif _G.EOWLoaded then
EOW:SetAttacks(bool)
elseif _G.GOSPlus then
GOSPlus.BlockAttack=not bool
elseif _G.GOS then
GOS.BlockAttack=not bool
end
end]]
local lastCast=Game.Timer()
function CastSpell(hotkey,pos,delay)
local delay=delay or 250
if GetTickCount()-lastCast>delay+GameLatency()and not myHero.isChanneling then
if pos~=nil then
ControlCastSpell(hotkey,pos)
else
ControlCastSpell(hotkey)
end
lastCast=GetTickCount()
end
end
function SetOrbAttack(bool)
if _G.SDK then
_G.SDK.Orbwalker:SetAttack(bool)
elseif _G.EOWLoaded then
EOW:SetAttacks(bool)
elseif _G.GOSPlus then
GOSPlus.BlockAttack=not bool
end
end
function isEnemyMinionNearBy(range)
local r=range*range
for i=1,GameMinionCount()do
local minion=GameMinion(i)
if minion.isEnemy and GetDistanceSqr(myHero.pos,minion.pos)<=r then
return true
end
end
return false
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
function GetDistanceSqr(a,b)
if a.z~=nil and b.z~=nil then
local x=(a.x-b.x);local z=(a.z-b.z);return x*x+z*z;else
local x=(a.x-b.x);local y=(a.y-b.y);return x*x+y*y;end
end
function GetDistance(p1,p2)
return MathSqrt(GetDistanceSqr(p1,p2))
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

--Hero
if myHero.charName~="Garen"then return end
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
local LocalDrawCircle=Draw.Circle
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
local Q={range=600}
local W={range=250}
local E={range=325}
local R={range=400}
--icon
local Icons={Menu="http://static.lolskill.net/img/champions/64/garen.png",Q="http://vignette3.wikia.nocookie.net/leagueoflegends/images/1/17/Decisive_Strike.png",W="http://vignette1.wikia.nocookie.net/leagueoflegends/images/2/25/Courage.png",E="http://vignette2.wikia.nocookie.net/leagueoflegends/images/1/15/Judgment.png",R="http://vignette1.wikia.nocookie.net/leagueoflegends/images/c/ce/Demacian_Justice.png",whitelist="https://www.richters.com/Issues/whitelist/nowhitelist.png",Tiamat="https://vignette2.wikia.nocookie.net/leagueoflegends/images/e/e3/Tiamat_item.png",RavenousHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/e/e8/Ravenous_Hydra_item.png",TitanicHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/2/22/Titanic_Hydra_item.png",YoumuusGhostblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/4/41/Youmuu%27s_Ghostblade_item.png",RanduinsOmen="https://vignette1.wikia.nocookie.net/leagueoflegends/images/0/08/Randuin%27s_Omen_item.png",BilgewaterCutlass="https://vignette1.wikia.nocookie.net/leagueoflegends/images/4/44/Bilgewater_Cutlass_item.png",BladeoftheRuinedKing="https://vignette2.wikia.nocookie.net/leagueoflegends/images/2/2f/Blade_of_the_Ruined_King_item.png",HextechGunblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/6/64/Hextech_Gunblade_item.png"}
--Main Menu
local Menu=MenuElement({type=MENU,id="Menu",name="Garen - Easier to play",leftIcon=Icons.Menu})
--Main Menu--Mode Setting
Menu:MenuElement({type=MENU,id="Mode",name="Mode Settings"})
--Main Menu--Mode Setting--Combo
Menu.Mode:MenuElement({type=MENU,id="Combo",name="Combo"})
Menu.Mode.Combo:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.Mode.Combo:MenuElement({id="W",name="Use W",value=true,leftIcon=Icons.W})
Menu.Mode.Combo:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
Menu.Mode.Combo:MenuElement({id="R",name="Use R",value=true,leftIcon=Icons.R})
--Main Menu--Mode Setting--Lane
Menu.Mode:MenuElement({type=MENU,id="Lane",name="Lane"})
Menu.Mode.Lane:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
Menu.Mode.Lane:MenuElement({id="EMinion",name="Use E when X minions",value=3,min=0,max=5,step=1,leftIcon=Icons.E})
--Main Menu--Mode Setting--Jungle
Menu.Mode:MenuElement({type=MENU,id="Jungle",name="Jungle"})
Menu.Mode.Jungle:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.Mode.Jungle:MenuElement({id="W",name="Use W",value=true,leftIcon=Icons.W})
Menu.Mode.Jungle:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
--Main Menu--Mode Setting--LastHit
Menu.Mode:MenuElement({type=MENU,id="LastHit",name="Last Hit"})
Menu.Mode.LastHit:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
--Main Menu--Mode Setting--Flee
Menu.Mode:MenuElement({type=MENU,id="Flee",name="Flee"})
Menu.Mode.Flee:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
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
Menu.Drawing:MenuElement({id="E",name="Draw E Range",value=false,leftIcon=Icons.E})
Menu.Drawing:MenuElement({id="R",name="Draw R Range",value=false,leftIcon=Icons.R})
---------
--DRAW--
---------
function OnDraw()
--Draw Range
if myHero.dead then return end
if Menu.Drawing.E:Value()then LocalDrawCircle(myHero.pos,E.range,1,Draw.Color(220,0,255,0))end
if Menu.Drawing.R:Value()then LocalDrawCircle(myHero.pos,R.range,1,Draw.Color(220,255,0,0))end
end
---------
--START--
---------
function OnTick()
if myHero.dead then return end
local Combo=LocalSDK.Orbwalker:IsEnabled()and LocalSDK.Orbwalker.Modes[LocalSDK.ORBWALKER_MODE_COMBO]
local Flee=LocalSDK.Orbwalker:IsEnabled()and LocalSDK.Orbwalker.Modes[LocalSDK.ORBWALKER_MODE_FLEE]
local Clear=LocalSDK.Orbwalker:IsEnabled()and(LocalSDK.Orbwalker.Modes[LocalSDK.ORBWALKER_MODE_JUNGLECLEAR]or LocalSDK.Orbwalker.Modes[LocalSDK.ORBWALKER_MODE_LANECLEAR])
local LastHit=LocalSDK.Orbwalker:IsEnabled()and LocalSDK.Orbwalker.Modes[LocalSDK.ORBWALKER_MODE_LASTHIT]
local target=LocalSDK.TargetSelector:GetTarget(1200)
if Clear then
UseClearItem()
local minion=GetEnemiesMinions(E.range-20)
if minion then
--Lane E
if Menu.Mode.Lane.E:Value()and isReady(_E)and myHero:GetSpellData(_E).name=="GarenE"and not isCasting(_Q)then
if CountEnemyMinions(E.range)>=Menu.Mode.Lane.EMinion:Value()then
CastSpell(HK_E)
end
end
end
local monster=GetEnemiesMonster(Q.range)
if monster then
--Jungle Q
if Menu.Mode.Jungle.Q:Value()and isReady(_Q)and myHero:GetSpellData(_E).name=="GarenE"then
CastSpell(HK_Q)
end
end
local monster=GetEnemiesMonster(E.range-20)
if monster then
--Jungle E
if Menu.Mode.Jungle.E:Value()and isReady(_E)and myHero:GetSpellData(_E).name=="GarenE"and not isCasting(_Q)then
CastSpell(HK_E)
end
--Jungle W
if Menu.Mode.Jungle.W:Value()and isReady(_W)then
CastSpell(HK_W)
end
end
end
if LastHit then
local levelQ=myHero:GetSpellData(_Q).level
local Qdmg=({30,55,80,105,130})[levelQ]+1.4*myHero.totalDamage
local minionTarget=GetEnemiesMinionsLowHP(Qdmg,myHero.range+50)
if minionTarget then
--Use Q
if Menu.Mode.LastHit.Q:Value()and isReady(_Q)then
CastSpell(HK_Q)
end
--Q to minionTarget
if isCasting(_Q)then
if LocalSDK.Orbwalker:CanAttack(myHero)then
Control.SetCursorPos(minionTarget.pos)
Control.Attack(minionTarget)
end
end
end
end
if Flee then
if Menu.Mode.Flee.Q:Value()and isReady(_Q)then
CastSpell(HK_Q)
end
end
if Combo then
UseComboItem()
--Q
target=LocalSDK.TargetSelector:GetTarget(Q.range)
if target then
if Menu.Mode.Combo.Q:Value()and isReady(_Q)and myHero:GetSpellData(_E).name=="GarenE"then
CastSpell(HK_Q)
end
end
--W
target=LocalSDK.TargetSelector:GetTarget(W.range)
if target then
if Menu.Mode.Combo.W:Value()and isReady(_W)then
CastSpell(HK_W)
end
end
--E
target=LocalSDK.TargetSelector:GetTarget(E.range-20)
if target then
if Menu.Mode.Combo.E:Value()and isReady(_E)and myHero:GetSpellData(_E).name=="GarenE"and not isCasting(_Q)then
CastSpell(HK_E)
end
end
--R
target=LocalSDK.TargetSelector:GetTarget(R.range)
if target then
if Menu.Mode.Combo.R:Value()and isReady(_R)then
local levelR=myHero:GetSpellData(_R).level
local Rdmg=({175,35,525})[levelR]+(target.maxHealth-target.health)/({3.5,3,2.5})[levelR]
---ks with R(current target)
if HasBuff(target,"garenpassiveenemytarget")then
if Rdmg>=target.health+target.shieldAP+CalculateHpRegen(target)then
CastSpell(HK_R,target)
end
else
if CalcMagicalDamage(myHero,target,Rdmg)>=target.health+target.shieldAP+CalculateHpRegen(target)then
CastSpell(HK_R,target)
end
end
local hero=KS(target,R.range)
if hero then
--ks with R(all eneies check except current target)
if HasBuff(hero,"garenpassiveenemytarget")then
if Rdmg>=hero.health+hero.shieldAP+CalculateHpRegen(hero)then
CastSpell(HK_R,hero)
end
else
if CalcMagicalDamage(myHero,hero,Rdmg)>=hero.health+hero.shieldAP+CalculateHpRegen(hero)then
CastSpell(HK_R,hero)
end
end
end
end
end
end
end
function CountEnemyMinions(range)
local range=range or 800
local n=0
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team~=myHero.team and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.pos:DistanceTo(myHero.pos)<=range then
n=n+1
end
end
return n
end
function GetEnemiesMinionsLowHP(dmg,range)
local range=range or 800
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team~=myHero.team and minion.team==200 and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.pos:DistanceTo(myHero.pos)<=range then
if dmg>=minion.health then
return minion
end
end
end
return false
end
function KS(target,range)
local range=range or 800
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team~=myHero.team and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.pos:DistanceTo(myHero.pos)<=range then
if hero~=target then
return hero
end
end
end
return false
end
function UseComboItem()
if not Menu.Item.Enable:Value()then return end
--item Usage
local target=(LocalSDK and LocalSDK.Orbwalker:IsEnabled()and LocalSDK.TargetSelector:GetTarget(450))or(LocalEOW and EOW:GetTarget(450))or(_G.Orbwalker.Enabled:Value()and GOS:GetTarget(450))
if target then
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
CastSpell(SlotToHotKeys(item),target)
end
local item=GetItemSlot(3153)
if item and Menu.Item.BladeoftheRuinedKing:Value()then
CastSpell(SlotToHotKeys(item),target)
end
local item=GetItemSlot(3146)
if item and Menu.Item.HextechGunblade:Value()then
CastSpell(SlotToHotKeys(item),target)
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
function SlotToHotKeys(slot)
local s={ITEM_1,ITEM_2,ITEM_3,ITEM_4,ITEM_5,ITEM_6,ITEM_7}
local hk={HK_ITEM_1,HK_ITEM_2,HK_ITEM_3,HK_ITEM_4,HK_ITEM_5,HK_ITEM_6,HK_ITEM_7}
for i=1,#s do
if slot==s[i]then
return hk[i]
end
end
end
function GetItemSlot(itemID)
for i=ITEM_1,ITEM_6 do--6 to 11;ITEM_1=6
if myHero:GetItemData(i).itemID~=0 and myHero:GetItemData(i).stacks>0 then--implies that is an item
if myHero:GetItemData(i).itemID==itemID and myHero:GetSpellData(i).currentCd==0 then--implies that is an ward and ammo>0 and not cd ing
return i
end
end
end
return false
end
function GetWardingSlot()
if myHero:GetItemData(ITEM_7).itemID==3340 and myHero:GetSpellData(ITEM_7).ammo>0 and myHero:GetSpellData(ITEM_7).currentCd==0 then return ITEM_7 end
for i=ITEM_1,ITEM_6 do--6 to 11;ITEM_1=6
if myHero:GetItemData(i).itemID~=0 and myHero:GetItemData(i).stacks>0 then--implies that is an item
for j=1,#WardingItems do
if myHero:GetItemData(i).itemID==WardingItems[j]and myHero:GetItemData(i).ammo>0 and myHero:GetSpellData(i).currentCd==0 then--implies that is an ward and ammo>0 and not cd ing
return i
end
end
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
function CalculateHpRegen(target)
local distance={300,400,500,600,700,800}
local time={1,1.2,1.4,1.6,1.8,2}
for i=1,#distance do
if myHero.pos:DistanceTo(target.pos)<=distance[i]then
return target.hpRegen*time[i]
end
end
return target.hpRegen*2
end
function GetTargetHasBuff(buffName)
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team~=myHero.team and hero.visible and hero.valid and hero.alive and hero.isTargetable then
if HasBuff(hero,buffName)then
return hero
end
end
end
return false
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
function GetBuffData(unit,buffName)
for i=0,unit.buffCount do
local buff=unit:GetBuff(i)
if buff.name:lower()==buffName:lower()and buff.count>0 and buff.duration>0.3 then
return unit:GetBuff(i)
end
end
return false
end
function GetAllyWards(range)
local range=range or 800
for i=1,Game.WardCount()do
local ward=Game.Ward(i)
if ward and ward.team==myHero.team and ward.visible and ward.valid and ward.alive and ward.isTargetable and ward.pos:DistanceTo(myHero.pos)<=range then
return true
end
end
return false
end
function GetAllyHeroes(range)
local range=range or 800
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team==myHero.team and not hero.isMe and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.pos:DistanceTo(myHero.pos)<=range then
return true
end
end
return false
end
function GetEnemiesHeroes(range)
local range=range or 800
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team~=myHero.team and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.pos:DistanceTo(myHero.pos)<=range then
return true
end
end
return false
end
function GetEnemiesMinions(range)
local range=range or 800
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team~=myHero.team and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.pos:DistanceTo(myHero.pos)<=range then
return true
end
end
return false
end
function GetEnemiesMonster(range)
local range=range or 800
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team~=myHero.team and minion.team==300 and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.pos:DistanceTo(myHero.pos)<=range then
return true
end
end
return false
end
function GetAllyMinions(range)
local range=range or 800
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team==myHero.team and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.pos:DistanceTo(myHero.pos)<=range then
return true
end
end
return false
end
function isMinionAndJungleNearBy(range)
local range=range
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.isEnemy and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.pos:DistanceTo(myHero.pos)<=range then
return true
end
end
return false
end
function isCasting(spell)
return LocalGameCanUseSpell(spell)==8
end
function isCD(spell)
return LocalGameCanUseSpell(spell)==32
end
function isReady(spell)
return LocalGameCanUseSpell(spell)==0
end
function GetPred(unit,speed,delay)
if IsImmobileTarget(unit)then
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

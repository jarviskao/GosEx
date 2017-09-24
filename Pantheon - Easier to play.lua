--Hero
if myHero.charName~="Pantheon"then return end
--Localize
local myHero=myHero
local LocalGameHeroCount=Game.HeroCount
local LocalGameHero=Game.Hero
local LocalGameMinionCount=Game.MinionCount
local LocalGameMinion=Game.Minion
local LocalGameCanUseSpell=Game.CanUseSpell
local LocalDrawCircle=Draw.Circle
local LocalDrawCircleMinimap=Draw.CircleMinimap
local LocalMathHuge=math.huge
local CastSpell=Control.CastSpell
local ITEM_1=ITEM_1
local ITEM_2=ITEM_2
local ITEM_3=ITEM_3
local ITEM_4=ITEM_4
local ITEM_5=ITEM_5
local ITEM_6=ITEM_6
local ITEM_7=ITEM_7
local _Q=_Q
local _W=_W
local _E=_E
local _R=_R
local STATE_WINDUP=STATE_WINDUP
local STATE_WINDDOWN=STATE_WINDDOWN
local TEAM_ALLY=myHero.team
local TEAM_JUNGLE=300
local TEAM_ENEMY=300-TEAM_ALLY
--Spell
local Q={range=600,speed=1500,delay=0.25,width=0}
local W={range=600,speed=0,delay=0.25,width=0}
local E={name="PantheonE",range=650,speed=778,delay=0.25,width=100}
local R={range=5500,attackRange=700,speed=20,delay=0.25,width=0}
--OTHER
local orbStatus=true
local SpellTable={"Q","W","E","R"}
local CURRENT_TARGET=nil
--icon
local Icons={Menu="http://static.lolskill.net/img/champions/64/pantheon.png",Q="https://vignette2.wikia.nocookie.net/leagueoflegends/images/1/1b/Spear_Shot.png",W="https://vignette4.wikia.nocookie.net/leagueoflegends/images/1/1b/Aegis_of_Zeonia.png",E="https://vignette3.wikia.nocookie.net/leagueoflegends/images/e/ea/Heartseeker_Strike.png",R="https://vignette1.wikia.nocookie.net/leagueoflegends/images/d/dd/Grand_Skyfall.png",Tiamat="https://vignette2.wikia.nocookie.net/leagueoflegends/images/e/e3/Tiamat_item.png",RavenousHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/e/e8/Ravenous_Hydra_item.png",TitanicHydra="https://vignette1.wikia.nocookie.net/leagueoflegends/images/2/22/Titanic_Hydra_item.png",YoumuusGhostblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/4/41/Youmuu%27s_Ghostblade_item.png",RanduinsOmen="https://vignette1.wikia.nocookie.net/leagueoflegends/images/0/08/Randuin%27s_Omen_item.png",BilgewaterCutlass="https://vignette1.wikia.nocookie.net/leagueoflegends/images/4/44/Bilgewater_Cutlass_item.png",BladeoftheRuinedKing="https://vignette2.wikia.nocookie.net/leagueoflegends/images/2/2f/Blade_of_the_Ruined_King_item.png",HextechGunblade="https://vignette4.wikia.nocookie.net/leagueoflegends/images/6/64/Hextech_Gunblade_item.png"}
--Main Menu
local Menu=MenuElement({type=MENU,id="Menu",name="Pantheon - Easier to play",leftIcon=Icons.Menu})
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
Menu.Mode.Combo:MenuElement({id="W",name="Use W",value=true,leftIcon=Icons.W})
Menu.Mode.Combo:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
--Main Menu--Mode Setting--Clear
Menu.Mode:MenuElement({type=MENU,id="Clear",name="Clear"})
Menu.Mode.Clear:MenuElement({id="W",name="Use W",value=true,leftIcon=Icons.W})
Menu.Mode.Clear:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
--Main Menu--KillSteal
Menu:MenuElement({type=MENU,id="KillSteal",name="KillSteal"})
Menu.KillSteal:MenuElement({id="Q",name="Use Q",value=true,leftIcon=Icons.Q})
Menu.KillSteal:MenuElement({id="W",name="Use W",value=true,leftIcon=Icons.W})
Menu.KillSteal:MenuElement({id="E",name="Use E",value=true,leftIcon=Icons.E})
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
Menu.Drawing:MenuElement({id="Ready",name="Draw Ready Spells Only",value=true})
for i=1,4 do
Menu.Drawing:MenuElement({id=SpellTable[i],name="Draw "..SpellTable[i].." Range",type=MENU,leftIcon=Icons[SpellTable[i]]})
Menu.Drawing[SpellTable[i]]:MenuElement({id="Enabled",name="Enabled",value=true})
Menu.Drawing[SpellTable[i]]:MenuElement({id="Width",name="Width",value=2,min=1,max=5,step=1})
Menu.Drawing[SpellTable[i]]:MenuElement({id="Color",name="Color",color=Draw.Color(255,255,255,255)})
end
Menu.Drawing:MenuElement({id="RMiniMap",name="Draw R Range on MiniMap",type=MENU,leftIcon=Icons.R})
Menu.Drawing.RMiniMap:MenuElement({id="Enabled",name="Enabled",value=true})
Menu.Drawing.RMiniMap:MenuElement({id="Width",name="Width",value=2,min=1,max=5,step=1})
Menu.Drawing.RMiniMap:MenuElement({id="Color",name="Color",color=Draw.Color(255,255,255,255)})
---------
--DRAW--
---------
function OnDraw()
--Draw Range
if myHero.dead or Menu.Drawing.DisableAll:Value()then return end
if Menu.Drawing.Q.Enabled:Value()then
if Menu.Drawing.Ready:Value()then
if isReady(_Q)then
LocalDrawCircle(myHero.pos,Q.range,Menu.Drawing.Q.Width:Value(),Menu.Drawing.Q.Color:Value())
end
else
LocalDrawCircle(myHero.pos,Q.range,Menu.Drawing.Q.Width:Value(),Menu.Drawing.Q.Color:Value())
end
end
if Menu.Drawing.W.Enabled:Value()then
if Menu.Drawing.Ready:Value()then
if isReady(_W)then
LocalDrawCircle(myHero.pos,W.range,Menu.Drawing.W.Width:Value(),Menu.Drawing.W.Color:Value())
end
else
LocalDrawCircle(myHero.pos,W.range,Menu.Drawing.W.Width:Value(),Menu.Drawing.W.Color:Value())
end
end
if Menu.Drawing.E.Enabled:Value()then
if Menu.Drawing.Ready:Value()then
if isReady(_E)then
LocalDrawCircle(myHero.pos,E.range,Menu.Drawing.E.Width:Value(),Menu.Drawing.E.Color:Value())
end
else
LocalDrawCircle(myHero.pos,E.range,Menu.Drawing.E.Width:Value(),Menu.Drawing.E.Color:Value())
end
end
if Menu.Drawing.R.Enabled:Value()then
local distance=mousePos:DistanceTo(myHero.pos)
if Menu.Drawing.Ready:Value()then
if isReady(_R)then
LocalDrawCircle(myHero.pos,R.range,Menu.Drawing.R.Width:Value(),Menu.Drawing.R.Color:Value())
if distance>3500 and distance<R.range then
LocalDrawCircle(mousePos,R.attackRange,1,Draw.Color(80,255,255,255))
end
end
else
LocalDrawCircle(myHero.pos,R.range,Menu.Drawing.R.Width:Value(),Menu.Drawing.R.Color:Value())
if distance>3500 and distance<R.range then
LocalDrawCircle(mousePos,R.attackRange,1,Draw.Color(80,255,255,255))
end
end
end
if Menu.Drawing.RMiniMap.Enabled:Value()then
if Menu.Drawing.Ready:Value()then
if isReady(_R)then
LocalDrawCircleMinimap(myHero.pos,R.range,Menu.Drawing.RMiniMap.Width:Value(),Menu.Drawing.RMiniMap.Color:Value())
end
else
LocalDrawCircleMinimap(myHero.pos,R.range,Menu.Drawing.RMiniMap.Width:Value(),Menu.Drawing.RMiniMap.Color:Value())
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
--DisableOrb
if myHero.activeSpell.name==E.name and myHero.activeSpell.valid then
orbStatus=false
DisableOrb()
--PrintChat("DisableOrb")
end
--EnableOrb
if orbStatus==false then
if isCD(_E)then
local time=myHero:GetSpellData(_E).cd-myHero:GetSpellData(_E).currentCd
if time>0.75 and time<0.85 then
--PrintChat("E is done.Moving...")
orbStatus=true
EnableOrb()
end
elseif myHero.activeSpell.valid==false then
--prevent interrupt(someone stop my Spell)
--PrintChat("Move not activeSpell")
orbStatus=true
EnableOrb()
end
end
CURRENT_TARGET=GetTarget(800)
if Combo then
OnCombo()
elseif Clear then
OnClear()
end
KillSteal()
end
---------
--Clear--
---------
function OnClear()
UseClearItem()
if myHero.attackData.state==STATE_WINDUP then return end
--W to the closest minion if count>=3 and no enemies around
if Menu.Mode.Clear.W:Value()and isReady(_W)and not HasBuff(myHero,"PantheonPassiveShield")then
local BuffData=GetBuffData(myHero,"PantheonPassiveCounter")
if BuffData and BuffData.count>=3 then
local minion=GetClosestMinionTarget(W.range)
if isValidTarget(minion,W.range)then
if minion.distance<myHero.range+80 then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_W,minion)
end
else
CastSpell(HK_W,minion)
end
end
end
end
end
---------
--KillSteal--
---------
function KillSteal()
if myHero.attackData.state==STATE_WINDUP or not CURRENT_TARGET then return end
--KillSteal Q
if Menu.KillSteal.Q:Value()and isReady(_Q)then
--spell data
local levelQ=myHero:GetSpellData(_Q).level
--Q KS
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team~=TEAM_ALLY and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=Q.range then
--ks with Q(all eneies check except current target)
if hero~=CURRENT_TARGET then
local Qdmg=({65,105,145,185,225})[levelQ]+1.4*hero.bonusDamage
if CalcPhysicalDamage(myHero,hero,Qdmg)>=hero.health+hero.shieldAD+CalculateHpRegen(hero)then
CastSpell(HK_Q,hero)
end
end
end
end
end
--KillSteal W
if Menu.KillSteal.W:Value()and isReady(_W)then
--spell data
local levelW=myHero:GetSpellData(_W).level
local levelE=myHero:GetSpellData(_E).level
--KS with W
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team~=TEAM_ALLY and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=W.range then
--ks with W+AA(all eneies check)
local Wdmg=({50,75,100,125,150})[levelW]+hero.ap
if CalcMagicalDamage(myHero,hero,Wdmg)+CalcPhysicalDamage(myHero,hero,myHero.totalDamage)>=hero.health+hero.shieldAP+CalculateHpRegen(hero)then
CastSpell(HK_W,hero)
end
--ks with W+E(all eneies check)
if Menu.Mode.Combo.E:Value()and isReady(_E)then
local Edmg=({13,23,33,43,53})[levelE]*2+hero.bonusDamage
if CalcMagicalDamage(myHero,hero,Wdmg)+CalcPhysicalDamage(myHero,hero,Edmg)>=hero.health+hero.shieldAP+CalculateHpRegen(hero)then
CastSpell(HK_W,hero)
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
UseComboItem()
if myHero.attackData.state==STATE_WINDUP or not CURRENT_TARGET then return end
--Q
if Menu.Mode.Combo.Q:Value()and isReady(_Q)and not myHero.activeSpell.valid then
if isValidTarget(CURRENT_TARGET,Q.range)then
--Q if Counter<3 or have Shield or do not have counter and Shield
local BuffData1=GetBuffData(myHero,"PantheonPassiveCounter")
local BuffData2=GetBuffData(myHero,"PantheonPassiveShield")
if(not BuffData1 and not BuffData2)or(BuffData1 and BuffData1.count<3)or BuffData2 then
if CURRENT_TARGET.distance<myHero.range+80 then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_Q,CURRENT_TARGET)
end
else
CastSpell(HK_Q,CURRENT_TARGET)
end
end
end
end
--W
if Menu.Mode.Combo.W:Value()and isReady(_W)and not myHero.activeSpell.valid then
--W if do not have sheild or Ally is nearby 800 range or Enemies AA range<300
if isValidTarget(CURRENT_TARGET,W.range)then
if not HasBuff(myHero,"PantheonPassiveShield")or isAllyNearBy(800)then
if CURRENT_TARGET.distance<myHero.range+80 then
if myHero.attackData.state==STATE_WINDDOWN then
CastSpell(HK_W,CURRENT_TARGET)
end
else
CastSpell(HK_W,CURRENT_TARGET)
end
end
end
end
--E
if Menu.Mode.Combo.E:Value()and isReady(_E)then
if isValidTarget(CURRENT_TARGET,E.range-120)then
if CURRENT_TARGET.distance<myHero.range+80 then
if myHero.attackData.state==STATE_WINDDOWN then
local pred=CURRENT_TARGET:GetPrediction(E.speed,E.delay)
if pred then
CastSpell(HK_E,pred)
end
end
else
local pred=CURRENT_TARGET:GetPrediction(E.speed,E.delay)
if pred then
CastSpell(HK_E,pred)
end
end
end
end
end
---------
--ComboItem--
---------
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
---------
--ClearItem--
---------
function UseClearItem()
if not Menu.Item.Enable:Value()then return end
--item Usage
if GetEnemiesMinions(350)then
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
function EnableOrb()
local LocalSDK=_G.SDK
local LocalEOW=_G.EOWLoaded
local LocalGOS=_G.GOS
if LocalSDK and LocalSDK.Orbwalker then
LocalSDK.Orbwalker:SetAttack(true)
LocalSDK.Orbwalker:SetMovement(true)
end
if LocalGOS then
LocalGOS.BlockMovement=false
LocalGOS.BlockAttack=false
end
if LocalEOW then
EOW:SetMovements(true)
EOW:SetAttacks(true)
end
end
function DisableOrb()
local LocalSDK=_G.SDK
local LocalEOW=_G.EOWLoaded
local LocalGOS=_G.GOS
if LocalSDK and LocalSDK.Orbwalker then
LocalSDK.Orbwalker:SetAttack(false)
LocalSDK.Orbwalker:SetMovement(false)
end
if LocalGOS then
LocalGOS.BlockMovement=true
LocalGOS.BlockAttack=true
end
if LocalEOW then
EOW:SetMovements(false)
EOW:SetAttacks(false)
end
end
function GetMonsterHasBuff(buffName)
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team==TEAM_JUNGLE and minion.visible and minion.valid and minion.alive and minion.isTargetable then
if HasBuff(minion,buffName)then
return minion
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
if target.distance<=distance[i]then
return target.hpRegen*time[i]
end
end
return target.hpRegen*2
end
function GetTargetHasBuff(buffName)
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team~=TEAM_ALLY and hero.visible and hero.valid and hero.alive and hero.isTargetable then
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
if ward and ward.team==TEAM_ALLY and ward.visible and ward.valid and ward.alive and ward.isTargetable and ward.distance<=range then
return true
end
end
return false
end
function GetAllyHeroes(range)
local range=range or 800
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team==TEAM_ALLY and not hero.isMe and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=range then
return true
end
end
return false
end
function GetEnemiesHeroes(range)
local range=range or 800
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.team~=TEAM_ALLY and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=range then
return true
end
end
return false
end
function GetEnemiesMinions(range)
local range=range or 800
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team~=TEAM_ALLY and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
return true
end
end
return false
end
function GetAllyMinions(range)
local range=range or 800
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team==TEAM_ALLY and minion.visible and minion.valid and minion.alive and minion.isTargetable and minion.distance<=range then
return true
end
end
return false
end
function GetClosestAllyTurretTarget(distance)
local distance=distance or LocalMathHuge
local closest
for i=1,Game.TurretCount()do
local turret=Game.Turret(i)
if turret and turret.isAlly and turret.visible and turret.valid and turret.alive and turret.isTargetable then
if turret.distance<distance then
distance=turret.distance
closest=turret
end
end
end
return closest
end
function GetClosestAllyHeroTarget(distance)
local distance=distance or LocalMathHuge
local closest
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.isAlly and not hero.isMe and hero.visible and hero.valid and hero.alive and hero.isTargetable then
if hero.distance<distance then
distance=hero.distance
closest=hero
end
end
end
return closest
end
function GetClosestMinionTarget(distance)
local distance=distance or LocalMathHuge
local closest
for i=1,LocalGameMinionCount()do
local minion=LocalGameMinion(i)
if minion and minion.team~=TEAM_ALLY and minion.visible and minion.valid and minion.alive and minion.isTargetable then
if minion.distance<distance then
distance=minion.distance
closest=minion
end
end
end
return closest
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
function isAllyNearBy(range)
local range=range
for i=1,LocalGameHeroCount()do
local hero=LocalGameHero(i)
if hero and hero.isAlly and not hero.isMe and hero.visible and hero.valid and hero.alive and hero.isTargetable and hero.distance<=range then
return true
end
end
return false
end
function isValidTarget(unit,range)
return unit and unit.visible and unit.valid and unit.alive and unit.isTargetable and unit.distance<range
end
function GetTarget(range)
local LocalSDK=_G.SDK
local LocalEOW=_G.EOWLoaded
if(LocalSDK and LocalSDK.Orbwalker:IsEnabled())then
return LocalSDK.TargetSelector:GetTarget(range)
elseif LocalEOW then
return EOW:GetTarget(range)
elseif _G.Orbwalker.Enabled:Value()then
return GOS:GetTarget(range)
end
end

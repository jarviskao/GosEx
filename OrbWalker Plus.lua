class "GOSPlus"

local Version = "1.01"
local GameHeroCount = Game.HeroCount
local GameHero = Game.Hero
local GameMinionCount = Game.MinionCount
local GameMinion = Game.Minion
local GameCanUseSpell = Game.CanUseSpell
local DrawCircle = Draw.Circle
local MathHuge = math.huge
local MathSqrt = math.sqrt
local MathFloor = math.floor
local ControlSetCursorPos = Control.SetCursorPos
local ControlKeyDown = Control.KeyDown
local ControlMouse_event = Control.mouse_event
local ControlKeyUp = Control.KeyUp
local TableInsert = table.insert
local TableSort = table.sort
local MathMax = math.max
local MathMin = math.min
local GameTimer = Game.Timer
local GameIsChatOpen = Game.IsChatOpen
local GameLatency = Game.Latency

function GOSPlus:__init()
  self.myName = myHero.charName
  self.mapID = Game.mapID;
  self.Range = myHero.range + myHero.boundingRadius * 0.5
  self.extraRange = false
  self.hasAmmo = false
  self.HYB = {"Corki", "Kayle", "Jax"}
  self.DMGMulti = (self.myName == "Kalista" and 0.9) or 1
  self.DMG = MathFloor(myHero.totalDamage) * self.DMGMulti
  self.hasNeededBuffs = {}
  self.clickTarget = nil
  self.ForceTarget = nil
  self.BlockAttack = false
  self.BlockMovement = false
  self._Priority = {} self:Priority()
  self._EnemyTowers = nil
  self._EnemyHeroes = nil
  self._AllyHeroes = nil
  self._ChampionHandle = {}

  self.spell = {[_Q] = 1, [_W] = 1, [_E] = 1, [_R] = 1}
  self.attacks = {}
  self.runningMinions = {}
  self.runningMinionsOn = {}
  self.mustLasthit = {}
  self.canLasthit = {}
  self.missLasthit = {}
  self.canOrb = {}
  self.waitOrb = false
  self.closeTurret = myHero
  self.closeTurretTarget = myHero
  self.shop = myHero
  self.turretTarget = 1
  self.Turret_DMG = {
    ["SRU_ChaosMinionRanged"] = 0.7,
    ["SRU_ChaosMinionMelee"] = 0.4325,
    ["SRU_ChaosMinionSiege"] = 0.14,
    ["SRU_ChaosMinionSuper"] = 0.05,
    ["SRU_OrderMinionRanged"] = 0.7,
    ["SRU_OrderMinionMelee"] = 0.4325,
    ["SRU_OrderMinionSiege"] = 0.14,
    ["SRU_OrderMinionSuper"] = 0.05
  }

  Callback.Add("Load", function() self:Load() end)
  self.AA = {state = 1, tick = GetTickCount(), tick2 = GetTickCount(), downTime = GetTickCount(), lastTarget = myHero, lastTarget2 = 1}
  self.lastAttack = GetTickCount()
  self.lastMove = GetTickCount()
  self.castAttack = {state = 0, tick = GetTickCount(), casting = GetTickCount() - 1000, mouse = mousePos}
  self.castSpell = {state = 0, tick = GetTickCount(), casting = GetTickCount() - 1000, mouse = mousePos}
end

function GOSPlus:Load()
  self.extraRange = (self.myName == "Caitlyn" or self.myName == "KogMaw" or self.myName == "Twitch") and true or false
  self.hasAmmo = (self.myName == "Graves" and true) or (self.myName == "Jhin" and true) or false
  self:GetEnemyTowers()
  self:GetCloseTowerStart()
  self:GetEnemyHeroes()
  self:GetAllyHeroes()
  self:Menu()
  self:DisableGoSOrbwalker()
  Callback.Add("Tick", function() self:Tick() end)
  Callback.Add("Draw", function() self:Draw() end)
  Callback.Add("WndMsg", function(msg, key) self:WndMsg(msg, key) end)
end

function GOSPlus:Menu()
  OrbwalkerPlus = MenuElement({id = "OrbwalkerPlus", name = "OrbwalkerPlus | "..myHero.charName, type = MENU, leftIcon = "https://lh3.ggpht.com/thKDcJqa37403jP17ng_9G_nAarw9QLHMIpbMmuiqozP8sKw3hgETqKa0z0VnHz0zps=w300" })
  OrbwalkerPlus:MenuElement({id = "Enabled", name = "Enabled", value = false })
  OrbwalkerPlus:MenuElement({id = "Key", name = "Key Settings", type = MENU})
  OrbwalkerPlus.Key:MenuElement({id = "Combo", name = "Combo", key = string.byte(" ")})
  OrbwalkerPlus.Key:MenuElement({id = "Harass", name = "Harass | Mixed", key = string.byte("C")})
  OrbwalkerPlus.Key:MenuElement({id = "LastHit", name = "LastHit", key = string.byte("X")})
  OrbwalkerPlus.Key:MenuElement({id = "Clear", name = "Waveclear", key = string.byte("V")})
  OrbwalkerPlus.Key:MenuElement({id = "Freeze", name = "Freeze", key = string.byte("Y")})
  OrbwalkerPlus.Key:MenuElement({id = "Flee", name = "Flee", key = string.byte("A")})
  OrbwalkerPlus:MenuElement({id = "TargetSelector", name = "Target Selector", type = MENU})
  if 0.30 - GameTimer() > - 0.05 then
    DelayAction(function()
      local t = self:GetEnemyHeroes()
      if #t > 0 then
        for i= 1, #t do
          local enemy = t[i]
          OrbwalkerPlus.TargetSelector:MenuElement({id = enemy.networkID, name = "Priority: "..enemy.charName, value = self.Priority[enemy.charName], min = 0, max = 5, step = 1})
        end
      end
    end, (0.30 - GameTimer()) * 100 + 1)
  else
    local t = self:GetEnemyHeroes()
    if #t > 0 then
      for i= 1, #t do
        local enemy = t[i]
        OrbwalkerPlus.TargetSelector:MenuElement({id = enemy.networkID, name = "Priority: "..enemy.charName, value = self.Priority[enemy.charName], min = 0, max = 5, step = 1})
      end
    end
  end

  OrbwalkerPlus:MenuElement({id = "Drawings", name = "Drawings", type = MENU})
  OrbwalkerPlus.Drawings:MenuElement({id = "Enabled", name = "Enabled", value = true })
  OrbwalkerPlus.Drawings:MenuElement({id = "myRange", name = "Draw: Range", value = true })
  OrbwalkerPlus.Drawings:MenuElement({id = "enemyRange", name = "Draw: Enemy Range", value = false })
  OrbwalkerPlus.Drawings:MenuElement({id = "lasthit", name = "Draw: Last-Hit Marker", value = true })

  OrbwalkerPlus:MenuElement({id = "extraWindUp", name = "Extra Windup", value = 0.06, min = 0, max = 0.2, step = 0.01})
  OrbwalkerPlus:MenuElement({id = "savagery", name = "Savagery Stacks", value = 0, min = 0, max = 5, step = 1})
  OrbwalkerPlus:MenuElement({id = "clickDelay", name = "Delay between clicks", value = 180, min = 50, max = 350, step = 1})
  OrbwalkerPlus:MenuElement({id = "lowSpec", name = "Low Spec Performance", value = true })
  OrbwalkerPlus:MenuElement({type = SPACE, name = "Script Version: "..Version})
  _G.OrbwalkerPlus = OrbwalkerPlus
end

function GOSPlus:ForceTarget(unit)
  if not unit.dead then self.ForceTarget = unit else self.ForceTarget = nil end
end

function GOSPlus:ForceMove(pos)
  return pos or nil
end

function GOSPlus:BlockAttack(bool)
  self.BlockAttack = bool or false
end

function GOSPlus:BlockMovement(bool)
  self.BlockMovement = bool or false
end

local OnAttackFunc = function() end

function GOSPlus:OnAttack(func)
  OnAttackFunc = func
end

local OnAttackCompFunc = function() end

function GOSPlus:OnAttackComplete(func)
  OnAttackCompFunc = func
end

function GOSPlus:CanAttack()
  if self.hasAmmo then return self.AA.state == 1 and self:IsChanneling() == false and myHero.hudAmmo > 0 and self.BlockAttack == false end
  return self.AA.state == 1 and self:IsChanneling() == false and self.BlockAttack == false and self:BlockAttackWhileCasting() == false
end

function GOSPlus:CanMove()
  return (self.AA.state == 3 or self.AA.state == 1) and (self:IsChanneling() == false or self:MoveWhileChannel() == true) and self.BlockMovement == false
end

function GOSPlus:IsAttacking()
  return self.AA.state == 2
end

function GOSPlus:Tick()
  if not OrbwalkerPlus.Enabled:Value() then return end
  self:AA_Tick()
  self:SpellLoop()
  self:AttackLoop()
  self.DMG = MathFloor((myHero.totalDamage * self.DMGMulti) + OrbwalkerPlus.savagery:Value() + self:BonusDMG())
  self.Range = myHero.range + myHero.boundingRadius * 0.5
  if myHero.dead or GameIsChatOpen() then return end
  if self:GetMode() == 0 then
    self:Combo_Orb()
  elseif self:GetMode() == 1 then
    self:Harass_Orb()
  elseif self:GetMode() == 2 then
    self:Clear_Orb()
  elseif self:GetMode() == 3 then
    self:Lasthit_Orb()
  elseif self:GetMode() == 4 then
    self:Freeze_Orb()
  elseif self:GetMode() == 5 then
    self:Flee_Orb()
  end
end

function GOSPlus:Draw()
  if not OrbwalkerPlus.Enabled:Value() then return end
  if not OrbwalkerPlus.Drawings.Enabled:Value() then return end
  if myHero.dead then return end
  self:ComboTCO()
  self:DrawEnemyRange()
  if self.clickTarget ~= nil and self.clickTarget.visible then DrawCircle(self.clickTarget.pos, 100, 3, Draw.Color(250, 250, 50, 60)) end
  if OrbwalkerPlus.Drawings.myRange:Value() then DrawCircle(myHero.pos, self.Range + myHero.boundingRadius * 0.5, 1, Draw.Color(240, 40, 250, 100)) end
  if OrbwalkerPlus.Drawings.lasthit:Value() then
    self:DrawHitMarker()
  end
end

function GOSPlus:WndMsg(msg, key)
  if not OrbwalkerPlus.Enabled:Value() then return end
  if key == 0 and msg == 513 then
    local t = self:GetEnemyHeroes()
    if #t > 0 then
      for i=1, #t do
        local enemy = t[i]
        if not enemy.dead and GetDistance(mousePos,enemy.pos) <= enemy.boundingRadius * 2 + 25 then
          self.clickTarget = enemy
          return
        end
      end
    end
    self.clickTarget = nil
  end
end

function GOSPlus:GetMode()
  if OrbwalkerPlus.Key.Combo:Value() then return 0 end
  if OrbwalkerPlus.Key.Harass:Value() then return 1 end
  if OrbwalkerPlus.Key.Clear:Value() then return 2 end
  if OrbwalkerPlus.Key.LastHit:Value() then return 3 end
  if OrbwalkerPlus.Key.Freeze:Value() then return 4 end
  if OrbwalkerPlus.Key.Flee:Value() then return 5 end
  return nil
end

function GOSPlus:GetEnemyHeroes()
  if self._EnemyHeroes then return self._EnemyHeroes end
  for i = 1, GameHeroCount() do
    local unit = GameHero(i)
    if unit.isEnemy then
      if self._EnemyHeroes == nil then self._EnemyHeroes = {} end
      self._EnemyHeroes[#self._EnemyHeroes + 1] = unit
      self._ChampionHandle[unit.handle] = unit
    end
  end
  if self._EnemyHeroes then return self._EnemyHeroes end
  return {}
end

function GOSPlus:GetAllyHeroes()
  if self._AllyHeroes then return self._AllyHeroes end
  for i = 1, GameHeroCount() do
    local unit = GameHero(i)
    if unit.isAlly then
      if self._AllyHeroes == nil then self._AllyHeroes = {} end
      self._AllyHeroes[#self._AllyHeroes + 1] = unit
      self._ChampionHandle[unit.handle] = unit
    end
  end
  if self._AllyHeroes then return self._AllyHeroes end
  return {}
end

function GOSPlus:GetHeroByHandle(handle)
  return self._ChampionHandle[handle]
end

function GOSPlus:GetCloseTowerStart()
  for i = 1, Game.TurretCount() do
    local turret = Game.Turret(i)
    if turret.isAlly and GetDistance(turret.pos,Vector(0, 0, 0)) < 500 then
      self.closeTurret = turret
    end
    if turret.isEnemy and GetDistance(turret.pos,Vector(0, 0, 0)) < 500 then
      self.closeTurretTarget = turret
    end
  end
end

function GOSPlus:GetEnemyTowers()
  if self._EnemyTowers then return self._EnemyTowers end
  for i = 0, Game.ObjectCount() do
    local o = Game.Object(i)
    -- if o.isEnemy and (o.name:find("HQ_T") or o.name:find("Barracks_T")) then
    if o.isEnemy and (o.type == Obj_AI_Barracks) then
      if self._EnemyTowers == nil then self._EnemyTowers = {} end
      self._EnemyTowers[#self._EnemyTowers + 1] = o
    end
    if o.type == Obj_AI_SpawnPoint and o.team == myHero.team then
      self.shop = o
    end
  end
  if self._EnemyTowers ~= nil then
    for i = 1, Game.TurretCount() do
      local turret = Game.Turret(i)
      if turret.isEnemy then
        self._EnemyTowers[#self._EnemyTowers + 1] = turret
      end
    end
  end
  if self._EnemyTowers then return self._EnemyTowers end
  return {}
end

local _OnSpellCastFunc = function() end
function GOSPlus:OnSpellCast(func)
  _OnSpellCastFunc = func
end

local BlockAutoAttack = {
  ["Garen"] = function() if GotBuff(myHero, "GarenE") > 0 then return true else return false end end
}

function GOSPlus:BlockAttackWhileCasting()
  local blockAA = BlockAutoAttack[self.myName] or nil
  if blockAA ~= nil and blockAA() == true then
    return true
  else
    return false
  end
end

local ChannelingMove = {
  ["Gragas"] = 1,
  ["Galio"] = 1,
  ["Lucian"] = 3,
  ["Varus"] = 0,
  ["Vi"] = 0,
  ["Vladimir"] = 2,
  ["Xerath"] = 0,
}

local specialChannel = {
  ["Xerath"] = function() if GotBuff(myHero, "XerathLocusOfPower2") == 1 then return true else return false end end,
  ["Jhin"] = function() if myHero:GetSpellData(_R).name == "JhinRShot" then return true else return false end end,
}

function GOSPlus:MoveWhileChannel()
  if myHero.isChanneling then local s = ChannelingMove[self.myName] if s ~= nil then if s == myHero.activeSpellSlot then return true end end end
  return false
end

local currentChannel = {state = 0, spell = 0, time = 0, delay = 0.25}
function GOSPlus:IsChanneling()
  if myHero.isChanneling then
    -- Draw.Text("Channel",30,500,500)
    local spell = myHero.activeSpell
    if spell.valid then
      local channel = currentChannel
      if channel.state == 0 then
        channel.state = 1
        channel.spell = myHero.activeSpellSlot
        channel.name = spell.name
        channel.time = GameTimer()
        channel.delay = (spell.windup <= 0.05 and spell.windup) or (spell.windup == 0.25 and spell.windup) or (spell.windup == 0.5 and spell.windup) or (spell.windup == 0.75 and spell.windup) or spell.animation
        channel.animation = spell.animation
        -- print(channel.name)
        -- print("WindUp: "..spell.windup)
        -- print("Animation: "..spell.animation)
      end
      if channel.state == 1 then
        if GameTimer() - channel.time < channel.delay then
          return true
        elseif channel.delay < 0.05 then
          return true
        else
          return false
        end
      end
    end
  else
    if currentChannel.state == 1 then
      if GameTimer() - currentChannel.time >= currentChannel.delay + 0.025 and currentChannel.delay > 0 and specialChannel[self.myName] == nil then
        currentChannel.state = 0
      else
        if GameTimer() - currentChannel.time < currentChannel.animation then
          local special = specialChannel[self.myName] or nil
          if special ~= nil and special() == true then
            return true
          else
            currentChannel.state = 0
          end
        else
          currentChannel.state = 0
        end
      end
    end
  end
  return false
end

--BonusDMG_Table is based on minion only
local BonusDMG_Table = {
  ["Aatrox"] = {["aatroxwonhpowerbuff"] = function() return ({45, 80, 115, 150, 185})[myHero:GetSpellData(_W).level] + 0.75 * myHero.bonusDamage end},
  ["Ashe"] = {["asheqattack"] = function() return ({1.05, 1.1, 1.15, 1.2, 1.25})[myHero:GetSpellData(_Q).level] * myHero.totalDamage end},
  ["Akali"] = {["akalishadowstate"] = function() return ({[1] = 10, [2] = 12, [3] = 14, [4] = 16, [5] = 18, [6] = 20, [7] = 22, [8] = 24, [9] = 26, [10] = 28, [11] = 30, [12] = 40, [13] = 50, [14] = 60, [15] = 70, [16] = 80, [17] = 90, [18] = 100})[myHero.levelData.lvl] + 0.75 * myHero.ap + 0.5 * myHero.bonusDamage end},
  ["Alistar"] = {["alistartrample"] = function() return 40 + 15 * myHero.levelData.lvl end},
  ["Bard"] = {["bardpspiritammocount"] = function() return 30 + 0.3 * (GotBuff(myHero, "bardpdisplaychimecount") / 5) * myHero.ap end},
  ["Blitzcrank"] = {["powerfist"] = function() return myHero.totalDamage end},
  ["Caitlyn"] = {["caitlynheadshot"] = function() return (2.5 + (0.5 * myHero.critChance)) * myHero.totalDamage end},
  ["Camille"] = {["camilleq"] = function() return ({0.2, 0.25, 0.3, 0.35, 0.4})[myHero:GetSpellData(_Q).level] * myHero.totalDamage end,
    ["camilleq2"] = function() return ({0.4, 0.5, 0.6, 0.7, 0.8})[myHero:GetSpellData(_Q).level] * myHero.totalDamage end},
  ["Chogath"] = {["vorpalspikes"] = function() return ({20, 30, 40, 50, 60})[myHero:GetSpellData(_E).level] + 0.3 * myHero.ap end},
  ["Darius"] = {["dariusnoxiantacticsonh"] = function() return 1.4 * myHero.totalDamage end},
  ["Diana"] = {["dianaarcready"] = function() return ({[1] = 20, [2] = 25, [3] = 30, [4] = 35, [5] = 40, [6] = 50, [7] = 60, [8] = 70, [9] = 80, [10] = 90, [11] = 105, [12] = 120, [13] = 135, [14] = 155, [15] = 175, [16] = 200, [17] = 225, [18] = 250})[myHero.levelData.lvl] + 0.8 * myHero.ap end},
  ["Draven"] = {["dravenspinning"] = function() return ({30, 35, 40, 45, 50})[myHero:GetSpellData(_Q).level] + ({0.65, 0.75, 0.85, 0.95, 1.05})[myHero:GetSpellData(_Q).level] * myHero.bonusDamage end},
  ["Ekko"] = {["ekkoeattackbuff"] = function() return 15 + 25 * myHero:GetSpellData(_E).level + 0.4 * myHero.ap end},
  ["Fizz"] = {["fizzw"] = function() return 15 + 10 * myHero:GetSpellData(_W).level + 0.33 * myHero.ap end},
  ["Gangplank"] = {["gangplankpassiveattack"] = function() return 8 + 4 * myHero.levelData.lvl + 0.4 * myHero.bonusDamage end},
  ["Garen"] = {["garenq"] = function() return 5 + 25 * myHero:GetSpellData(_Q).level + 0.4 * myHero.totalDamage end},
  ["Hecarim"] = {["hecarimrampspeed"] = function() return 5 + 35 * myHero:GetSpellData(_E).level + 0.5 * myHero.bonusDamage end},
  ["Irelia"] = {["ireliahitenstylecharged"] = function() return 15 * myHero:GetSpellData(_W).level end},
  ["Ivern"] = {["ivernwpassive"] = function() return 10 + 10 * myHero:GetSpellData(_W).level + 0.3 * myHero.ap end},
  ["Jax"] = {["jaxempowertwo"] = function() return 5 + 35 * myHero:GetSpellData(_W).level + 0.6 * myHero.ap end},
  ["Jayce"] = {["jaycehypercharge"] = function() return - 0.62 + 0.08 * myHero:GetSpellData(_W).level end,
  ["jaycepassivemeleeattack"] = function() return - 20 + 20 * myHero:GetSpellData(_R).level + 0.25 * myHero.bonusDamage end},
  ["Jinx"] = {["jinxq"] = function() return 0.1 * myHero.totalDamage end},
  ["Kassadin"] = {["netherblade"] = function() return 15 + 25 * myHero:GetSpellData(_W).level + 0.7 * myHero.ap end},
  ["Kayle"] = {["judicatorrighteousfury"] = function() return 5 + 5 * myHero:GetSpellData(_E).level + 0.3 * myHero.ap + (0.15 + 0.05 * myHero:GetSpellData(_E).level) * myHero.totalDamage end,
  ["kaylerighteousfurybuff"] = function() return 5 + 5 * myHero:GetSpellData(_E).level + 0.15 * myHero.ap end},
  ["Kennen"] = {["kennendoublestrikelive"] = function() return (0.3 + 0.1 * myHero:GetSpellData(_W).level) * myHero.totalDamage end},
  ["Leona"] = {["leonashieldofdaybreak"] = function() return 5 + 25 * myHero:GetSpellData(_Q).level + 0.3 * myHero.ap end},
  ["Lucian"] = {["lucianpassivebuff"] = function() return myHero.totalDamage end},
  ["Malphite"] = {["malphitecleave"] = function() return 15 * myHero:GetSpellData(_W).level + 0.1 * myHero.ap + 0.15 * myHero.armor end},
  ["MasterYi"] = {["wujustylesuperchargedvisual"] = function() return ({14, 23, 32, 41, 50})[myHero:GetSpellData(_E).level] + 0.25 * myHero.bonusDamage end,
  ["doublestrike"] = function() return myHero.totalDamage * 0.5 end},
  ["MonkeyKing"] = {["monkeykingdoubleattack"] = function() return 30 * myHero:GetSpellData(_Q).level + 0.1 * myHero.totalDamage end},
  ["Nasus"] = {["nasusq"] = function() return 10 + 20 * myHero:GetSpellData(_Q).level + 0 end},
  ["Nautilus"] = {["nautiluspiercinggazeshield"] = function() return 10 + 5 * myHero:GetSpellData(_W).level + 0.2 * myHero.ap end},
  ["Nidalee"] = {["takedown"] = function() return - 20 + 25 * myHero:GetSpellData(_Q).level + 0.75 * myHero.totalDamage + 0.4 * myHero.ap end},
  ["Nocturne"] = {["nocturneumbrablades"] = function() return 0.2 * myHero.totalDamage end},
  ["Orianna"] = {["orianaspellsword"] = function() return ({[1] = 10, [2] = 10, [3] = 10, [4] = 18, [5] = 18, [6] = 18, [7] = 26, [8] = 26, [9] = 26, [10] = 28, [11] = 34, [12] = 34, [13] = 42, [14] = 42, [15] = 42, [16] = 50, [17] = 50, [18] = 50})[myHero.levelData.lvl] + 0.15 * myHero.ap end},
  ["Poppy"] = {["poppypassivebuff"] = function() return 10 * myHero.levelData.lvl end},
  ["RekSai"] = {["reksaiq"] = function() return 5 + 10 * myHero:GetSpellData(_Q).level + 0.2 * myHero.bonusDamage end},
  ["Renekton"] = {["renektonpreexecute"] = function() return - 20 + 30 * myHero:GetSpellData(_W).level + 0.5 * myHero.totalDamage end},
  ["Riven"] = {["rivenpassiveaaboost"] = function() return (({[1] = 0.25, [2] = 0.25, [3] = 0.25, [4] = 0.25, [5] = 0.25, [6] = 0.3, [7] = 0.3, [8] = 0.3, [9] = 0.35, [10] = 0.35, [11] = 0.35, [12] = 0.4, [13] = 0.4, [14] = 0.4, [15] = 0.45, [16] = 0.45, [17] = 0.45, [18] = 0.5})[myHero.levelData.lvl]) * myHero.totalDamage end},
  ["Rumble"] = {["rumbleoverheat"] = function() return 20 + 5 * myHero.levelData.lvl + 0.3 * myHero.ap end},
  ["Shaco"] = {["deceive"] = function() return 5 + 15 * myHero:GetSpellData(_Q).level + 0.4 * myHero.ap end},
  ["Shen"] = {["shenqbuff"] = function() return 10 + 20 * myHero:GetSpellData(_Q).level end},
  ["Shyvana"] = {["shyvanadoubleattack"] = function() return (0.25 + 0.15 * myHero:GetSpellData(_Q).level) * myHero.totalDamage end},
  ["Sona"] = {["sonapassiveattack"] = function() return ({[1] = 15, [2] = 25, [3] = 35, [4] = 45, [5] = 55, [6] = 65, [7] = 75, [8] = 85, [9] = 100, [10] = 115, [11] = 130, [12] = 145, [13] = 160, [14] = 175, [15] = 190, [16] = 205, [17] = 220, [18] = 235})[myHero.levelData.lvl] + 0.2 * myHero.ap end,
  ["sonaqprocattacker"] = function() return 10 + 10 * myHero:GetSpellData(_Q).level + 0.2 * myHero.ap end},
  ["Teemo"] = {["toxicshot"] = function() return 10 * myHero:GetSpellData(_E).level + 0.3 * myHero.ap end},
  ["Trundle"] = {["trundletrollsmash"] = function() return 20 * myHero:GetSpellData(_Q).level + (-0.05 + 0.05 * myHero:GetSpellData(_Q).level) * myHero.totalDamage end},
  ["TwistedFate"] = {["cardmasterstackparticle"] = function() return 30 + 25 * myHero:GetSpellData(_E).level + 0.5 * myHero.ap end,
    ["bluecardpreattack"] = function() return 20 + 20 * myHero:GetSpellData(_E).level + 0.5 * myHero.ap end,
    ["redcardpreattack"] = function() return 15 + 15 * myHero:GetSpellData(_E).level + 0.5 * myHero.ap end,
  ["goldcardpreattack"] = function() return 7.5 + 7.5 * myHero:GetSpellData(_E).level + 0.5 * myHero.ap end},
  ["Udyr"] = {["udyrtigerstance"] = function() return 0.15 * myHero.totalDamage end},
  ["Varus"] = {["varusw"] = function() return 6 + 4 * myHero:GetSpellData(_W).level + 0.25 * myHero.ap end},
  ["Vayne"] = {["vaynetumblebonus"] = function() return (0.25 + 0.05 * myHero:GetSpellData(_Q).level) * myHero.totalDamage end},
  ["Vi"] = {["vie"] = function() return - 10 + 20 * myHero:GetSpellData(_E).level + 0.15 * myHero.totalDamage + 0.7 * myHero.ap end},
  ["Viktor"] = {["viktorpowertransferreturn"] = function() return 20 * myHero:GetSpellData(_Q).level + 0.5 * myHero.ap end},
  ["Volibear"] = {["volibearq"] = function() return 30 * myHero:GetSpellData(_Q).level end,
  ["volibearrapllicator"] = function() return 35 + 40 * myHero:GetSpellData(_R).level + 0.3 * myHero.ap end},
  ["Viktor"] = {["viktorpowertransferreturn"] = function() return 20 * myHero:GetSpellData(_Q).level + 0.5 * myHero.ap end},
  ["Warwick"] = {["warwickp"] = function() return 8 + 2 * myHero.levelData.lvl end},
  ["Ziggs"] = {["viktorpowertransferreturn"] = function() return 20 * myHero:GetSpellData(_Q).level + 0.5 * myHero.ap end},
  ["XinZhao"] = {["viktorpowertransferreturn"] = function() return 8 + 2 * myHero.levelData.lvl end},
}

--target table
local BonusDMG_Table_Target = {
  ["Ekko"] = {["ekkowpassive"] = function(target) if 100 * target.health / target.maxHealth < 30 then return MathMin(150, (target.maxHealth - target.health) * 0.03) else return 0 end end},
  ["Gragas"] = {["gragaswattackbuff"] = function(target) return MathMin(290 + 30 * myHero:GetSpellData(_W).level, - 10 + 30 * myHero:GetSpellData(_W).level + 0.08 * target.maxHealth) + 0.3 * myHero.ap end},
  ["Illaoi"] = {["illaoiw"] = function(target) return MathMin(300, (0.025 + 0.005 * myHero:GetSpellData(_W).level) * target.maxHealth) end},
  ["Jhin"] = {["jhinpassiveattackbuff"] = function(target) return (target.maxHealth - target.health) * ({0.15, 0.15, 0.15, 0.15, 0.15, 0.20, 0.20, 0.20, 0.20, 0.20, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25})[myHero.levelData.lvl] end},
  ["Sejuani"] = {["sejuaninorthernwindsenrage"] = function(target) return MathMin(300, (0.035 + 0.005) * target.maxHealth) end},
  ["KogMaw"] = {["kogmawbioarcanebarrage"] = function(target) return MathMin(100, (0.02 + 0.01 * myHero:GetSpellData(_W).level) * target.maxHealth) end},
}

--target have buff table
local BonusDMG_Table_TargetLoop = {
  ["Ashe"] = function(target) if GotBuff(target, "ashepassiveslow") > 0 then return (0.1 + (myHero.critChance)) * myHero.totalDamage else return 0 end end,
  ["Akali"] = function(target) if GotBuff(target, "AkaliMota") > 0 then return 20 + 25 * myHero:GetSpellData(_Q).level + 0.5 * myHero.ap else return 0 end end,
  ["Braum"] = function(target) if GotBuff(target, "braummarkstunreduction") > 0 then return 12 + 2 * myHero.levelData.lvl else return 0 end end,
  ["Camille"] = function(target) if GotBuff(myHero, "camiller") > 0 then return ({5,10,15})[myHero:GetSpellData(_R).level] + (({0.04,0.06,0.08})[myHero:GetSpellData(_R).level]) * target.health else return 0 end end,
  ["Ekko"] = function(target) if GotBuff(target, "ekkostacks") == 2 then return ({[1] = 30, [2] = 40, [3] = 50, [4] = 60, [5] = 70, [6] = 80, [7] = 85, [8] = 90, [9] = 95, [10] = 100, [11] = 105, [12] = 110, [13] = 115, [14] = 120, [15] = 125, [16] = 130, [17] = 135, [18] = 140})[myHero.levelData.lvl] + 0.8 * myHero.ap else return 0 end end,
  ["Gnar"] = function(target) if GotBuff(target, "gnarwproc") == 2 then return MathMin(50 + 50 * myHero:GetSpellData(_W).level, 10 + 10 * myHero:GetSpellData(_W).level + (0.04 + 0.02 * myHero:GetSpellData(_W).level) * target.maxHealth) else return 0 end end,
  ["JarvanIV"] = function(target) if GotBuff(target, "jarvanivmartialcadencecheck") < 1 then return MathMin(400, 0.1 * target.health) else return 0 end end,
  ["Kalista"] = function(target) if GotBuff(target, "kalistacoopstrikemarkally") > 0 then return MathMin(({75, 125, 150, 175, 200})[myHero:GetSpellData(_W).level], (({0.05, 0.075, 0.1, 0.125, 0.15})[myHero:GetSpellData(_W).level]) * target.maxHealth ) else return 0 end end,
  ["Lux"] = function(target) if GotBuff(target, "LuxIlluminatingFraulein") > 0 then return 10 + 10 * myHero.levelData.lvl + 0.2 * myHero.ap else return 0 end end,
  ["Nautilus"] = function(target) if GotBuff(target, "nautiluspassivecheck") < 1 then return 2 + 6 * myHero.levelData.lvl else return 0 end end,
  ["Quinn"] = function(target) if GotBuff(target, "QuinnW") > 0 then return 10 + 5 * myHero.levelData.lvl + (0.14 + 0.02 * myHero.levelData.lvl) * myHero.totalDamage else return 0 end end,
  ["Skarner"] = function(target) if GotBuff(target, "skarnerpassivebuff") > 0 then return 15 + 10 * myHero:GetSpellData(_E).level else return 0 end end,
  ["Vi"] = function(target) if GotBuff(target, "viwproc") == 2 then return MathMin(300, (0.025 + 0.015 * myHero:GetSpellData(_W).level) * target.maxHealth) else return 0 end end,
  ["Zed"] = function(target) if 100 * target.health / target.maxHealth < 50 and GotBuff(target, "zedpassivecd") < 1 then return (({[1] = 0.06, [2] = 0.06, [3] = 0.06, [4] = 0.06, [5] = 0.06, [6] = 0.06, [7] = 0.08, [8] = 0.08, [9] = 0.08, [10] = 0.08, [11] = 0.08, [12] = 0.08, [13] = 0.08, [14] = 0.08, [15] = 0.08, [16] = 0.08, [17] = 0.1, [18] = 0.1})[myHero.levelData.lvl]) * target.maxHealth else return 0 end end,
}

function GOSPlus:BonusDMG()
  local bonus = 0
  self.hasNeededBuffs = {}
  if BonusDMG_Table[self.myName] ~= nil or BonusDMG_Table_Target[self.myName] ~= nil then
    local t = BonusDMG_Table[self.myName]
    local b = BonusDMG_Table_Target[self.myName]
    local g = GetBuffs(myHero)
    if #g > 0 then
      for i = 1, #g do
        local buff = g[i]
        if t ~= nil and t[buff.name:lower()] ~= nil then
          bonus = t[buff.name:lower()]() or 0
        end
        if b ~= nil and b[buff.name:lower()] ~= nil then
          self.hasNeededBuffs[#self.hasNeededBuffs + 1] = b[buff.name:lower()]
        end
      end
    end
  end
  return bonus
end

function GOSPlus:BonusDMG_TargetNeeded(unit)
  local bonus = 0
  if #self.hasNeededBuffs > 0 then
    for i, buff in pairs(self.hasNeededBuffs) do
      bonus = MathFloor(buff(unit)) or 0
    end
  end
  if not OrbwalkerPlus.lowSpec:Value() then
    local l = BonusDMG_Table_TargetLoop[self.myName]
    if l ~= nil then bonus = MathFloor(l(unit)) end
  end
  return bonus
end

function GOSPlus:BonusDMG_TargetNeeded_Special(unit)
  if self.myName == "Vayne" and unit.handle == self.AA.lastTarget2 then return GotBuff(unit, "VayneSilveredDebuff") == 2 and MathFloor(20 + 20 * myHero:GetSpellData(_W).level) or 0 end
  if self.myName == "MissFortune" and unit.handle ~= self.AA.lastTarget2 then return (({[1] = 25, [2] = 25, [3] = 25, [4] = 30, [5] = 30, [6] = 30, [7] = 35, [8] = 35, [9] = 40, [10] = 40, [11] = 45, [12] = 45, [13] = 50, [14] = 50, [15] = 50, [16] = 50, [17] = 50, [18] = 50})[myHero.levelData.lvl]) end
  return 0
end

function GOSPlus:AA_ResetSpell()
  return {["Ashe"] = 0,
    ["Blitzcrank"] = 2,
    ["Chogath"] = 2,
    ["Camille"] = 0,
    ["Darius"] = 1,
    ["DrMundo"] = 2,
    ["Ekko"] = 2,
    -- ["Elise"] = 2,
    ["Evelynn"] = 2,
    ["Fiora"] = 2,
    ["Fizz"] = 1,
    ["Garen"] = 0,
    ["Graves"] = 2,
    ["Illaoi"] = 1,
    ["Jax"] = 1,
    ["Kassadin"] = 1,
    ["Katarina"] = 2,
    ["Leona"] = 0,
    ["Lucian"] = 2,
    ["MasterYi"] = 1,
    ["Nasus"] = 0,
    ["Nautilus"] = 1,
    ["Riven"] = 0,
    ["Mordekaiser"] = 0,
    ["RekSai"] = 0,
    ["Renekton"] = 1,
    ["Sejuani"] = 1,
    ["Shyvana"] = 0,
    ["Sivir"] = 1,
    ["Trundle"] = 0,
    ["Vayne"] = 0,
    ["Vi"] = 2,
    ["MonkeyKing"] = 0,
    ["XinZhao"] = 0,
    ["Yorick"] = 0,
  }
end

function GOSPlus:Priority()
  self.Priority = {
    ["Aatrox"] = 2,
    ["Ahri"] = 4,
    ["Akali"] = 3,
    ["Alistar"] = 1,
    ["Amumu"] = 1,
    ["Anivia"] = 4,
    ["Annie"] = 4,
    ["Ashe"] = 4,
    ["AurelionSol"] = 4,
    ["Azir"] = 4,
    ["Bard"] = 2,
    ["Blitzcrank"] = 1,
    ["Brand"] = 4,
    ["Braum"] = 1,
    ["Caitlyn"] = 4,
    ["Camille"] = 2,
    ["Cassiopeia"] = 4,
    ["Chogath"] = 2,
    ["Corki"] = 4,
    ["Darius"] = 2,
    ["Diana"] = 3,
    ["Draven"] = 4,
    ["DrMundo"] = 1,
    ["Ekko"] = 4,
    ["Elise"] = 2,
    ["Evelynn"] = 3,
    ["Ezreal"] = 4,
    ["FiddleSticks"] = 3,
    ["Fiora"] = 2,
    ["Fizz"] = 3,
    ["Galio"] = 2,
    ["Gangplank"] = 3,
    ["Garen"] = 1,
    ["Gnar"] = 1,
    ["Gragas"] = 2,
    ["Graves"] = 4,
    ["Hecarim"] = 2,
    ["Heimerdinger"] = 3,
    ["Illaoi"] = 2,
    ["Irelia"] = 2,
    ["Ivern"] = 1,
    ["Janna"] = 1,
    ["JarvanIV"] = 1,
    ["Jax"] = 2,
    ["Jayce"] = 4,
    ["Jhin"] = 4,
    ["Jinx"] = 4,
    ["Kalista"] = 4,
    ["Karma"] = 4,
    ["Karthus"] = 4,
    ["Kassadin"] = 3,
    ["Katarina"] = 4,
    ["Kayle"] = 3,
    ["Kennen"] = 4,
    ["Khazix"] = 4,
    ["Kindred"] = 4,
    ["Kled"] = 2,
    ["KogMaw"] = 4,
    ["Leblanc"] = 4,
    ["LeeSin"] = 2,
    ["Leona"] = 1,
    ["Lissandra"] = 3,
    ["Lucian"] = 4,
    ["Lulu"] = 2,
    ["Lux"] = 4,
    ["Malphite"] = 1,
    ["Malzahar"] = 4,
    ["Maokai"] = 1,
    ["MasterYi"] = 4,
    ["MissFortune"] = 4,
    ["MonkeyKing"] = 2,
    ["Mordekaiser"] = 3,
    ["Morgana"] = 3,
    ["Nami"] = 2,
    ["Nasus"] = 1,
    ["Nautilus"] = 1,
    ["Nidalee"] = 3,
    ["Nocturne"] = 2,
    ["Nunu"] = 1,
    ["Olaf"] = 2,
    ["Orianna"] = 4,
    ["Pantheon"] = 2,
    ["Poppy"] = 2,
    ["Quinn"] = 4,
    ["Rammus"] = 1,
    ["RekSai"] = 2,
    ["Renekton"] = 1,
    ["Rengar"] = 3,
    ["Riven"] = 4,
    ["Rumble"] = 2,
    ["Ryze"] = 3,
    ["Sejuani"] = 1,
    ["Shaco"] = 3,
    ["Shen"] = 1,
    ["Shyvana"] = 1,
    ["Singed"] = 1,
    ["Sion"] = 1,
    ["Sivir"] = 4,
    ["Skarner"] = 1,
    ["Sona"] = 2,
    ["Soraka"] = 4,
    ["Swain"] = 2,
    ["Syndra"] = 4,
    ["TahmKench"] = 1,
    ["Taliyah"] = 3,
    ["Talon"] = 4,
    ["Taric"] = 1,
    ["Teemo"] = 4,
    ["Thresh"] = 1,
    ["Tristana"] = 4,
    ["Trundle"] = 2,
    ["Tryndamere"] = 2,
    ["TwistedFate"] = 4,
    ["Twitch"] = 4,
    ["Udyr"] = 2,
    ["Urgot"] = 2,
    ["Varus"] = 4,
    ["Vayne"] = 4,
    ["Veigar"] = 4,
    ["Velkoz"] = 4,
    ["Vi"] = 2,
    ["Viktor"] = 4,
    ["Vladimir"] = 3,
    ["Volibear"] = 1,
    ["Warwick"] = 1,
    ["Xerath"] = 4,
    ["XinZhao"] = 2,
    ["Yasuo"] = 3,
    ["Yorick"] = 1,
    ["Zac"] = 1,
    ["Zed"] = 4,
    ["Ziggs"] = 4,
    ["Zilean"] = 3,
    ["Zyra"] = 1,
    ["PracticeTool_TargetDummy"] = 0
  }
end

function GOSPlus:ReducePrio(number)
  if number == nil then return 1.5 end
  if number == 5 then return 2 end
  if number == 4 then return 1.75 end
  if number == 3 then return 1.5 end
  if number == 2 then return 1.25 end
  if number == 1 then return 1 end
  if number == 0 then return 0.5 end
end

function GOSPlus:GetTarget(range, type)
  local target = {}
  local range = range or self.Range
  if self.clickTarget ~= nil and GetDistance(myHero.pos, self.clickTarget.pos) < range + self:ExtraRange(self.clickTarget) + self.clickTarget.boundingRadius * 0.5 then return self.clickTarget end
  local t = type or (table.contains(self.HYB, self.myName) and "HYB") or (myHero.bonusDamage > myHero.ap and "AD") or "AP"
  local h = self:GetEnemyHeroes()
  if #h > 0 then
    for i = 1, #h do
      local hero = h[i]
      if hero == nil then return end
      if OrbwalkerPlus.TargetSelector[hero.networkID] == nil then return end
      if OrbwalkerPlus.TargetSelector[hero.networkID]:Value() == nil then return end
      if GetDistance(myHero.pos, hero.pos) < range + self:ExtraRange(hero) + hero.boundingRadius * 0.5 and hero.valid and not hero.dead and hero.visible and hero.isTargetable then
        if t == "AD" then
          target[(CalcPhysicalDamage(myHero, hero, 100) / hero.health) * self:ReducePrio( OrbwalkerPlus.TargetSelector[hero.networkID]:Value() ~= nil and OrbwalkerPlus.TargetSelector[hero.networkID]:Value() or 1)] = hero
        elseif t == "AP" then
          target[(CalcMagicalDamage(myHero, hero, 100) / hero.health) * self:ReducePrio( OrbwalkerPlus.TargetSelector[hero.networkID]:Value() ~= nil and OrbwalkerPlus.TargetSelector[hero.networkID]:Value() or 1)] = hero
        elseif t == "HYB" then
          target[((CalcMagicalDamage(myHero, hero, 50) + CalcPhysicalDamage(myHero, hero, 50)) / hero.health) * self:ReducePrio( OrbwalkerPlus.TargetSelector[hero.networkID]:Value() ~= nil and OrbwalkerPlus.TargetSelector[hero.networkID]:Value() or 1)] = hero
        end
      end
    end
  end
  local bT = 0
  for d, v in pairs(target) do
    if d > bT then
      bT = d
    end
  end
  if bT ~= 0 then return target[bT] end
end

function GOSPlus:ExtraRange(unit)
  if self.extraRange == true then
    if self.myName == "Caitlyn" and GotBuff(unit, "caitlynyordletrapinternal") > 0 then
      return 650
    elseif self.myName == "KogMaw" and GotBuff(myHero, "kogmawbioarcanebarrage") > 0 then
      return ({130,150,70,190,210})[myHero:GetSpellData(_W).level]
    elseif self.myName == "Twitch" and GotBuff(myHero, "TwitchFullAutomatic") > 0 then
      return 300
    end
  end
  return 0
end

function GOSPlus:CastAttack(pos, range, delay)
  -- local delay = delay or 100
  local delay = 100
  local range = range or MathHuge
  local ticker = GetTickCount()
  -- local champ = pos.type == Obj_AI_Hero and true or false
  if self.castAttack.state == 0 and GetDistance(myHero.pos, pos.pos) < range and ticker - self.castAttack.casting > delay + GameLatency() and self:CanAttack() and not pos.dead and pos.isTargetable then
    self.castAttack.state = 1
    self.castAttack.mouse = mousePos:ToScreen()
    self.castAttack.tick = ticker
    self.lastAttack = GetTickCount()
  end
  if self.castAttack.state == 1 then
    if ticker - self.castAttack.tick < GameLatency() and self.AA.state == 1 then
      ControlSetCursorPos(pos.pos)
      ControlMouse_event(MOUSEEVENTF_RIGHTDOWN)
      ControlMouse_event(MOUSEEVENTF_RIGHTUP)
      self.castAttack.casting = ticker + delay
      DelayAction(function()
        ControlSetCursorPos(self.castAttack.mouse.x, self.castAttack.mouse.y)
        DelayAction(function()
          self.castAttack.state = 0
        end, 0.0001)
      end, 0.0001)
    end
    if ticker - self.castAttack.casting > GameLatency() and self.castAttack.state == 1 then
      ControlSetCursorPos(self.castAttack.mouse.x, self.castAttack.mouse.y)
      self.castAttack.state = 0
    end
  end
end

function GOSPlus:CastSpell(hotkey, pos, delay)
  local delay = delay or 50
  local ticker = GetTickCount()
  local pos = pos.pos or pos

  if self.castSpell.state == 0 and self.castAttack.state == 0 and ticker - self.castSpell.casting > delay + GameLatency() and self:CanAttack()  then
    self.BlockAttack = true
    self.castSpell.state = 1
		self.castSpell.mouse = mousePos
		self.castSpell.tick = ticker
	end

	if self.castSpell.state == 1 then
		if ticker - self.castSpell.tick < GameLatency() and self.AA.state == 1 then
			ControlSetCursorPos(pos)
			ControlKeyDown(hotkey)
			ControlKeyUp(hotkey)
			self.castSpell.casting = ticker + delay
			DelayAction(function()
				if self.castSpell.state == 1 then
					ControlSetCursorPos(self.castSpell.mouse)
          DelayAction(function()
            self.castSpell.state = 0
            self.BlockAttack = false
          end,0.0001)
				end
			end,GameLatency() * 0.001)
		end
		if ticker - self.castSpell.casting > GameLatency() and self.castSpell.state == 1 then
			ControlSetCursorPos(self.castSpell.mouse)
			self.castSpell.state = 0
      self.BlockAttack = false
		end
	end
end

function GOSPlus:CastMove(pos)
  local movePos = pos or mousePos
  ControlKeyDown(HK_TCO)
  ControlMouse_event(MOUSEEVENTF_RIGHTDOWN)
  ControlMouse_event(MOUSEEVENTF_RIGHTUP)
  DelayAction(function()
    ControlKeyUp(HK_TCO)
  end, 0.0001)
end

function GOSPlus:GetWindUp()
  --PrintChat(myHero.attackData.windUpTime.."   "..(1 / (30 / myHero.attackData.castFrame) / myHero.attackSpeed))
  if self.myName == "Garen" then return myHero.attackData.windUpTime + 0.05 end
  if self.myName == "Poppy" and myHero.range > 400 then return myHero.attackData.windUpTime + 0.1 end
  if self.myName == "Draven" then return myHero.attackData.windUpTime - 0.05 end
  if self.myName == "Corki" then return (1 / (30 / myHero.attackData.castFrame) / myHero.attackSpeed) end
  if self.myName == "Fiora" then return myHero.attackData.windUpTime - 0.05 end
  if self.myName == "Graves" then return 0.05 end
  if self.myName == "Sivir" then return myHero.attackData.windUpTime + 0.05 end
  if self.myName == "Jayce" then return GetWindUpSpecial(myHero) end
  if self.myName == "Nidalee" then return GetWindUpSpecial(myHero) end
  if self.myName == "Zed" then return (1 / (30 / myHero.attackData.castFrame) / myHero.attackSpeed) end
  return myHero.attackData.windUpTime
end

local _PS = {
["Poppy"] = 1800,
["Jayce"] = 2000,
["Elise"] = 1600,
["Azir"] = MathHuge,
["Thresh"] = MathHuge,
["Velkoz"] = MathHuge,
}

function GOSPlus:GetProjectileSpeed()
  if (myHero.range < 400 or myHero.attackData.projectileSpeed == 0) then return MathHuge end
  if _PS[self.myName] ~= nil then if myHero.range > 400 then return _PS[self.myName] end end
  return myHero.attackData.projectileSpeed
end

--self.AA.state = 1 windown 2 windup 3
function GOSPlus:AA_Tick()
  local spell = myHero.activeSpell
  if self.AA.state == 1 and myHero.attackData.state == 2 and spell.valid then
    self.lastTick = GetTickCount()
    self.AA.state = 2
    if self:GetHeroByHandle(myHero.attackData.target) ~= nil then
      self.AA.lastTarget = self:GetHeroByHandle(myHero.attackData.target)
    end
    self.AA.lastTarget2 = myHero.attackData.target
    OnAttackFunc()
  end
  if self.AA.state == 2 then
    local passedTime = (GameTimer() - myHero.attackData.endTime) + (myHero.attackData.endTime) - (myHero.attackData.endTime - myHero.attackData.animationTime)
    if not spell.valid then
      self.AA.state = 1
    end
    if passedTime + GameLatency() * 0.001 > self:GetWindUp() - myHero.attackData.castFrame / (250 / (0.61 * myHero.attackSpeed)) + OrbwalkerPlus.extraWindUp:Value() then
      self.AA.state = 3
      self.AA.tick2 = GetTickCount()
      self.AA.downTime = myHero.attackData.windDownTime * 1000 - (myHero.attackData.windUpTime * 1000)
      -- print(myHero.attackData.castFrame)
      -- print("WindUp: "..GOSPlus:GetWindUp())
      -- print("CalcUp: "..(1/(30/myHero.attackData.castFrame)/myHero.attackSpeed))
      -- print("ProjSpeed: "..GOSPlus:GetProjectileSpeed())
      DelayAction(function()
        OnAttackCompFunc()
      end, myHero.attackData.castFrame * 0.005 + GameLatency() * 0.001)
      if self:GetMode() ~= nil then
        self.lastMove = GetTickCount()
        self:CastMove()
      end
    end
  end
  if self.AA.state == 3 then
    if GetTickCount() - self.AA.tick2 - GameLatency() - myHero.attackData.castFrame > myHero.attackData.windDownTime * 1000 - (myHero.attackData.windUpTime * 1000) / 2 then
      self.AA.state = 1
    end
    if myHero.attackData.state == 1 then
      self.AA.state = 1
    end
    if GetTickCount() - self.AA.tick2 > self.AA.downTime + (myHero.attackData.windUpTime * 1000) / 2 then
      self.AA.state = 1
    end
    if GameTimer() >= myHero.attackData.endTime - (GameLatency() * 0.001) - 0.15 then
      self.AA.state = 1
    end
  end
end

function GOSPlus:SpellLoop()
  for i, s in pairs(self.spell) do
    local canusespell = GameCanUseSpell(i)
    if s == 0 and (canusespell == ONCOOLDOWN or canusespell == NOMANAONCOOLDOWN or canusespell == NOTAVAILABLE or canusespell == READYNOCAST) then
      -- s = 1
      self.spell[i] = 1
      if self:AA_ResetSpell()[self.myName] ~= nil and self:AA_ResetSpell()[self.myName] == i then
        self.AA.state = 1
        self.castAttack.state = 0
        self.castAttack.casting = GetTickCount() - 1000
      end
      _OnSpellCastFunc(i)
    end
    if s == 1 and (canusespell == READY) then
      self.spell[i] = 0
    end
  end
end

function GOSPlus:AttackLoop()
  self.attacks = {}
  self.runningMinions = {}
  for i = 1, GameMinionCount() do
    local minion = GameMinion(i)
    if minion.valid and minion.isAlly and GetDistance(minion.pos, myHero.pos) < 2500 then
      local aaData = minion.attackData
      if aaData.target ~= nil then
        local projectileSpeed = aaData.projectileSpeed
        local mName = minion.charName
        if mName:find("Melee") or mName:find("Super") then projectileSpeed = MathHuge end
        local state = aaData.state
        local windUp = mName:find("Siege") and 0.25 or aaData.windUpTime
        if state == 1 then self.runningMinions[minion.networkID] = minion end
        if state == 2 or state == 3 then if self.attacks[aaData.target] == nil then self.attacks[aaData.target] = {} end TableInsert(self.attacks[aaData.target], {aaData.endTime, windUp, projectileSpeed, minion}) end
      end
    end
  end
  for i = 1, Game.TurretCount() do
    local turret = Game.Turret(i)
    if turret.isAlly and turret.valid and GetDistance(turret.pos, myHero.pos) < 875 then
      self.closeTurret = turret
      local aaData = turret.attackData
      if aaData.target ~= nil then
        local projectileSpeed = aaData.projectileSpeed
        local state = aaData.state
        local windUp = 0.15
        self.turretTarget = aaData.target
        if state == 2 or state == 3 then if self.attacks[aaData.target] == nil then self.attacks[aaData.target] = {} end TableInsert(self.attacks[aaData.target], {aaData.endTime, windUp, projectileSpeed, turret}) end
      end
    end
  end
  local h = self:GetAllyHeroes()
  if #h > 0 then
    for i = 1, #h do
      local hero = h[i]
      if hero ~= myHero and hero.valid and GetDistance(hero.pos, myHero.pos) < 2500 then
        local aaData = hero.attackData
        if aaData.target ~= nil then
          local projectileSpeed = hero.range < 400 and MathHuge or aaData.projectileSpeed
          local state = aaData.state
          local windUp = aaData.windUpTime
          if state == 2 or state == 3 then if self.attacks[aaData.target] == nil then self.attacks[aaData.target] = {} end TableInsert(self.attacks[aaData.target], {aaData.endTime, windUp, projectileSpeed, hero}) end
        end
      end
    end
  end
end

function GOSPlus:HP_Pred(unit, time)
  local time = time - GameLatency() * 0.001
  local hp = unit.health
  if unit.team == 300 then return hp end
  local attacksOn = 0
  if self.AA.state == 3 then self.runningMinionsOn = {} end
  for i, v in pairs(self.attacks) do
    if i == unit.handle then
      for a in pairs(v) do
        if v[a][4].valid then
          if v[a][3] > 5000 then
            local passedTime = (GameTimer() - v[a][1]) + (v[a][1]) - (v[a][1] - v[a][4].attackData.animationTime)
            local timeToHit = v[a][2] - passedTime
            local whileTimeToHit = timeToHit
            local count = 0
            while timeToHit < time do
              if timeToHit > 0 then
                count = count + 1
              end
              timeToHit = timeToHit + v[a][4].attackData.animationTime
            end
            if count > 0 then
              hp = hp - MathFloor(v[a][4].totalDamage * (1 + v[a][4].bonusDamagePercent) - unit.flatDamageReduction) * count
              attacksOn = attacksOn + 1
            end
          else
            local passedTime = (GameTimer() - v[a][1]) + (v[a][1]) - (v[a][1] - v[a][4].attackData.animationTime)
            local timeToHit = v[a][2] + ((GetDistance(unit.pos, v[a][4].pos) + v[a][4].boundingRadius) / v[a][3]) - passedTime
            local whileTimeToHit = timeToHit
            local count = 0
            while whileTimeToHit < time do
              if whileTimeToHit > 0 then
                count = count + 1
              end
              whileTimeToHit = whileTimeToHit + v[a][4].attackData.animationTime
            end
            if count > 0 then
              if v[a][4].type == Obj_AI_Turret then
                if self.mapID == SUMMONERS_RIFT then
                  hp = hp - MathFloor(unit.maxHealth * self.Turret_DMG[unit.charName]) * count
                else
                  hp = hp - MathFloor(v[a][4].totalDamage * (1 + v[a][4].bonusDamagePercent) - unit.flatDamageReduction) * count
                end
              else
                hp = hp - MathFloor(v[a][4].totalDamage * (1 + v[a][4].bonusDamagePercent) - unit.flatDamageReduction) * count
              end
              attacksOn = attacksOn + 1
            end
          end
        end
      end
    end
  end
  self.runningMinionsOn = {}
  self.runningMinionsOn[unit.networkID] = 0
  for i, v in pairs(self.runningMinions) do
    local range = (v.charName:find("Melee") or v.charName:find("Super")) and 150 or 650
    if GetDistance(v.pos, unit.pos) < range + 150 and unit.handle ~= v.attackData.target then
      self.runningMinionsOn[unit.networkID] = self.runningMinionsOn[unit.networkID] + 1
    end
  end
  return MathFloor(hp)
end

function GOSPlus:ComboTCO()
  if self:GetMode() == 0 then
    ControlKeyDown(HK_TCO)
  else
    if Control.IsKeyDown(HK_TCO) then ControlKeyUp(HK_TCO) end
  end
end

function GOSPlus:Combo_Orb()
  if self:CanAttack() then
    local target = self:GetTarget()
    if target then
      if GetTickCount() - self.lastAttack > 50 then
        self:CastAttack(target, MathHuge, 50)
        self.lastAttack = GetTickCount()
      end
    end
  end
  if self:CanMove() and not self:IsAttacking() and GetTickCount() - self.lastMove > OrbwalkerPlus.clickDelay:Value() and GetTickCount() - self.lastAttack > 100 then
    self:CastMove()
    self.lastMove = GetTickCount()
  end
end

function GOSPlus:Harass_Orb()
  self.waitOrb = false
  self.mustLasthit = {}
  self.canLasthit = {}

  local mustCounter = 0
  local canCounter = 0
  for i = 1, GameMinionCount() do
    local minion = GameMinion(i)
    if minion.valid and minion.isEnemy and GetDistance(minion.pos, myHero.pos) < self.Range + 250 then
      local projectileSpeed = self:GetProjectileSpeed()
      local windUp = self:GetWindUp()
      local hpPred = self:HP_Pred(minion, windUp + (GetDistance(minion.pos, myHero.pos)) / projectileSpeed)
      local hpPred2 = self:HP_Pred(minion, windUp * 3 + (self.Range / projectileSpeed) * 2 + myHero.attackData.animationTime)
      local bonusDMG = self:BonusDMG_TargetNeeded_Special(minion) + self:BonusDMG_TargetNeeded(minion)
      if hpPred < - 10 then
        if self.attacks[minion.handle] ~= nil then
          self.runningMinionsOn[minion.networkID] = self.runningMinionsOn[minion.networkID] + #self.attacks[minion.handle]
        end
      end

      if hpPred <= self.DMG + bonusDMG and hpPred > 0 and (hpPred2 < 1 or minion.charName:find("Siege")) and GetDistance(minion.pos, myHero.pos) < self.Range then
        self.mustLasthit[mustCounter + 1] = minion
      elseif hpPred <= self.DMG + bonusDMG and hpPred > 0 and GetDistance(minion.pos, myHero.pos) < self.Range then
        self.canLasthit[canCounter + 1] = minion
      end
      if hpPred2 < 1 then
        self.waitOrb = true
      end

    end
  end

  TableSort(self.mustLasthit, function(a, b)
    local first = a.maxHealth
    local second = b.maxHealth
    return first > second
  end)
  TableSort(self.canLasthit, function(a, b)
    local first = a.maxHealth
    local second = b.maxHealth
    return first > second
  end)

  if self:CanAttack() and GetTickCount() - self.lastAttack > 50 then

    if self.mustLasthit[1] ~= nil then
      local minion = self.mustLasthit[1]
      if GetDistance(minion.pos, myHero.pos) <= self.Range + 45 then
        self:CastAttack(minion, self.Range + 45, 50)
        self.lastAttack = GetTickCount()
      end
    elseif self.canLasthit[1] ~= nil and self.waitOrb == false then
      local minion = self.canLasthit[1]
      if GetDistance(minion.pos, myHero.pos) <= self.Range + 45 then
        self:CastAttack(minion, self.Range + 45, 50)
        self.lastAttack = GetTickCount()
      end
    else
      if self.waitOrb == false then
        local target = self:GetTarget()
        if target then
          self:CastAttack(target)
          self.lastAttack = GetTickCount()
        end
      end
    end

  end

  if self:CanMove() and not self:IsAttacking() and GetTickCount() - self.lastMove > OrbwalkerPlus.clickDelay:Value() and GetTickCount() - self.lastAttack > 100 then
    self:CastMove()
    self.lastMove = GetTickCount()
  end
end

function GOSPlus:Lasthit_Orb()
  self.waitOrb = false
  local underTower = false
  self.mustLasthit = {}
  self.canLasthit = {}
  self.missLasthit = {}
  local mustCounter = 0
  local canCounter = 0
  local missCounter = 0

  for i = 1, GameMinionCount() do
    local minion = GameMinion(i)
    if minion.valid and minion.isEnemy and GetDistance(minion.pos, myHero.pos) < self.Range + 250 then
      local projectileSpeed = self:GetProjectileSpeed()
      local windUp = self:GetWindUp()
      local hpPred = self:HP_Pred(minion, windUp + (GetDistance(minion.pos, myHero.pos)) / projectileSpeed)
      local hpPred2 = self:HP_Pred(minion, windUp * 3 + (self.Range / projectileSpeed) * 2 + myHero.attackData.animationTime)
      local bonusDMG = self:BonusDMG_TargetNeeded_Special(minion) + self:BonusDMG_TargetNeeded(minion)
      if hpPred < - 10 then
        self.missLasthit[missCounter + 1] = minion
        if self.attacks[minion.handle] ~= nil then
          self.runningMinionsOn[minion.networkID] = self.runningMinionsOn[minion.networkID] + #self.attacks[minion.handle]
        end
      end

      if hpPred <= self.DMG + bonusDMG and hpPred > 0 and (hpPred2 < 1 or minion.charName:find("Siege")) and GetDistance(minion.pos, myHero.pos) < self.Range then
        self.mustLasthit[mustCounter + 1] = minion
      elseif hpPred <= self.DMG + bonusDMG and hpPred > 0 and GetDistance(minion.pos, myHero.pos) < self.Range then
        self.canLasthit[canCounter + 1] = minion
      end
      if hpPred2 < 1 then
        self.waitOrb = true
      end

      if GetDistance(minion.pos, self.closeTurret.pos) < 875 and self.runningMinionsOn[minion.networkID] < 2 then

      end
    end
  end


  TableSort(self.mustLasthit, function(a, b)
    local first = a.maxHealth
    local second = b.maxHealth
    return first > second
  end)
  TableSort(self.canLasthit, function(a, b)
    local first = a.maxHealth
    local second = b.maxHealth
    return first > second
  end)

  if self:CanAttack() and GetTickCount() - self.lastAttack > 50 then

    if self.mustLasthit[1] ~= nil then
      local minion = self.mustLasthit[1]
      if GetDistance(minion.pos, myHero.pos) <= self.Range + 45 then
        self:CastAttack(minion, self.Range + 45, 50)
        self.lastAttack = GetTickCount()
      end
    elseif self.canLasthit[1] ~= nil and self.waitOrb == false then
      local minion = self.canLasthit[1]
      if GetDistance(minion.pos, myHero.pos) <= self.Range + 45 then
        self:CastAttack(minion, self.Range + 45, 50)
        self.lastAttack = GetTickCount()
      end
    end

  end

  if self:CanMove() and not self:IsAttacking() and GetTickCount() - self.lastMove > OrbwalkerPlus.clickDelay:Value() and GetTickCount() - self.lastAttack > 100 then
    self:CastMove()
    self.lastMove = GetTickCount()
  end
end

function GOSPlus:Clear_Orb()
  self.waitOrb = false
  local waitMinion = false
  local underTowerClear = false
  local hitTower = 0
  self.mustLasthit = {}
  self.canLasthit = {}
  self.missLasthit = {}
  self.canOrb = {}
  local mustCounter = 0
  local canCounter = 0
  local missCounter = 0
  local canOrbCounter = 0

  local t = self:GetEnemyTowers()
  if #t > 0 then
    for i = 1, #t do
      local turret = t[i]
      if turret.isTargetable and not turret.dead and turret.health < turret.maxHealth then
        local radius = (turret.name:find("HQ_T") and 200) or (turret.name:find("Barracks_T") and 150) or 50
        if GetDistance(turret.pos, myHero.pos) < self.Range + radius then
          self.closeTurretTarget = turret
          if turret.name:find("HQ_T") then
            hitTower = 2
          else
            hitTower = 1
          end
          break
        end
      end
    end
  end

  for i = 1, GameMinionCount() do
    local minion = GameMinion(i)
    if minion.valid and minion.isEnemy and GetDistance(minion.pos, myHero.pos) < self.Range + 100 then
      local projectileSpeed = self:GetProjectileSpeed()
      local windUp = self:GetWindUp()
      local hpPred = self:HP_Pred(minion, windUp + (GetDistance(minion.pos, myHero.pos)) / projectileSpeed)
      local hpPred2 = self:HP_Pred(minion, windUp * 3 + (self.Range / projectileSpeed) * 2 + myHero.attackData.animationTime)
      local bonusDMG = self:BonusDMG_TargetNeeded_Special(minion) + self:BonusDMG_TargetNeeded(minion)

      if hpPred < - 10 then
        self.missLasthit[missCounter + 1] = minion
        if self.attacks[minion.handle] ~= nil then
          self.runningMinionsOn[minion.networkID] = self.runningMinionsOn[minion.networkID] + #self.attacks[minion.handle]
        end
      end
      local runners = self.runningMinionsOn[minion.networkID] ~= nil and self.runningMinionsOn[minion.networkID] or 0
      local extraRange = minion.team == 300 and minion.boundingRadius or 0
      if hpPred <= self.DMG + bonusDMG and hpPred > 0 and (hpPred2 < 1 or minion.charName:find("Siege")) and GetDistance(minion.pos, myHero.pos) < self.Range + extraRange then
        self.mustLasthit[mustCounter + 1] = minion
      elseif hpPred <= self.DMG + bonusDMG and hpPred > 0 and GetDistance(minion.pos, myHero.pos) < self.Range + extraRange then
        self.canLasthit[canCounter + 1] = minion
      elseif ((hpPred2 - (self.DMG + bonusDMG) > 10) or (hpPred2 == minion.health)) and runners < 2 and GetDistance(minion.pos, myHero.pos) < self.Range + extraRange and GetDistance(minion.pos, self.closeTurret.pos) > 875 then
        self.canOrb[canOrbCounter + 1]  = minion
        -- elseif hpPred2 - (minion.health - hpPred) - (self.DMG + bonusDMG) < 1 and hpPred2 - (minion.health - hpPred) < minion.health then
      elseif hpPred2 - (minion.health - hpPred) < 25 then
        self.waitOrb = true
      end
      if hpPred2 < 1 then
        waitMinion = true
      end

      if GetDistance(minion.pos, self.closeTurret.pos) < 875 and runners < 2 then
        local pewpew = MathFloor(hpPred2 / (self.mapID == SUMMONERS_RIFT and MathFloor(minion.maxHealth * self.Turret_DMG[minion.charName]) or MathFloor(self.closeTurret.totalDamage * (1 + self.closeTurret.bonusDamagePercent) - minion.flatDamageReduction)))
        local delay = (1 / 0.83) * (pewpew)
        local undertowerHPPred = self:HP_Pred(minion, windUp * 2 + ((GetDistance(minion.pos, myHero.pos)) / projectileSpeed) * 2 + delay + 2)

        local check = MathFloor((hpPred2 - (self.DMG + bonusDMG)) / (self.mapID == SUMMONERS_RIFT and MathFloor(minion.maxHealth * self.Turret_DMG[minion.charName]) or MathFloor(self.closeTurret.totalDamage * (1 + self.closeTurret.bonusDamagePercent) - minion.flatDamageReduction))) -- works

        self.waitOrb = false
        local attacks = MathFloor(delay / (0.65 * myHero.attackSpeed))
        if undertowerHPPred < 1 and pewpew <= 3 and pewpew >= attacks then
          self.waitOrb = true
        end
        if (pewpew == check or pewpew > 5) and self.waitOrb == false then
          underTowerClear = true
          self.canOrb[canOrbCounter + 1] = minion
        end
      end
    end
  end


  TableSort(self.mustLasthit, function(a, b)
    local first = a.maxHealth
    local second = b.maxHealth
    return first > second
  end)
  TableSort(self.canLasthit, function(a, b)
    local first = a.maxHealth
    local second = b.maxHealth
    return first > second
  end)
  if underTowerClear == true then
    TableSort(self.canOrb, function(a, b)
      local first = GetDistance(a.pos, self.closeTurret.pos)
      local second = GetDistance(b.pos, self.closeTurret.pos)
      return first < second
    end)
  else
    TableSort(self.canOrb, function(a, b)
      local first = a.health
      local second = b.health
      return first < second
    end)
  end


  if self:CanAttack() and GetTickCount() - self.lastAttack > 50 then

    if self.mustLasthit[1] ~= nil and hitTower < 2 then
      local minion = self.mustLasthit[1]
      local extraRange = minion.team == 300 and minion.boundingRadius or 45
      if GetDistance(minion.pos, myHero.pos) <= self.Range + extraRange then
        self:CastAttack(minion, self.Range + extraRange, 50)
        self.lastAttack = GetTickCount()
      end
    elseif self.canLasthit[1] ~= nil and waitMinion == false and hitTower < 2 then
      local minion = self.canLasthit[1]
      local extraRange = minion.team == 300 and minion.boundingRadius or 45
      if GetDistance(minion.pos, myHero.pos) <= self.Range + extraRange then
        self:CastAttack(minion, self.Range + extraRange, 50)
        self.lastAttack = GetTickCount()
      end
    elseif hitTower > 0 and waitMinion == false then
      self:CastAttack(self.closeTurretTarget, MathHuge, 50)
      self.lastAttack = GetTickCount()
    elseif (self.waitOrb == false or underTowerClear == true) then
      if self.canOrb[1] ~= nil then
        local minion = self.canOrb[1]
        local extraRange = minion.team == 300 and minion.boundingRadius or 45
        if GetDistance(minion.pos, myHero.pos) <= self.Range + extraRange then
          self:CastAttack(minion, self.Range + extraRange, 50)
          self.lastAttack = GetTickCount()
        end
      end
    end

  end

  if self:CanMove() and not self:IsAttacking() and GetTickCount() - self.lastMove > OrbwalkerPlus.clickDelay:Value() and GetTickCount() - self.lastAttack > 100 then
    self:CastMove()
    self.lastMove = GetTickCount()
  end
end

function GOSPlus:Freeze_Orb()
  self.mustLasthit = {}
  local mustCounter = 0

  for i = 1, GameMinionCount() do
    local minion = GameMinion(i)
    if minion.valid and minion.isEnemy and GetDistance(minion.pos, myHero.pos) < self.Range + 50 then
      local projectileSpeed = self:GetProjectileSpeed()
      local windUp = self:GetWindUp()
      local hpPred = self:HP_Pred(minion, windUp + (GetDistance(minion.pos, myHero.pos)) / projectileSpeed)
      local hpPred2 = self:HP_Pred(minion, windUp * 4 + (GetDistance(minion.pos, myHero.pos)) / projectileSpeed)
      local bonusDMG = self:BonusDMG_TargetNeeded_Special(minion) + self:BonusDMG_TargetNeeded(minion)
      if hpPred <= self.DMG + bonusDMG and hpPred > 0 and hpPred2 < 0 and GetDistance(minion.pos, myHero.pos) < self.Range + 45 then
        self.mustLasthit[mustCounter + 1] =  minion
      end
    end
  end

  if self:CanAttack() and GetTickCount() - self.lastAttack > 50 then

    TableSort(self.mustLasthit, function(a, b)
      local first = a.maxHealth
      local second = b.maxHealth
      return first > second
    end)

    if self.mustLasthit[1] ~= nil then
      local minion = self.mustLasthit[1]
      if GetDistance(minion.pos, myHero.pos) <= self.Range + 45 then
        self:CastAttack(minion, self.Range + 45, 50)
        self.lastAttack = GetTickCount()
      end
    end

  end

  if self:CanMove() and not self:IsAttacking() and GetTickCount() - self.lastMove > OrbwalkerPlus.clickDelay:Value() and GetTickCount() - self.lastAttack > 100 then
    self:CastMove()
    self.lastMove = GetTickCount()
  end
end

function GOSPlus:Flee_Orb()
  if self:CanMove() and GetTickCount() - self.lastMove > OrbwalkerPlus.clickDelay:Value() and GetTickCount() - self.lastAttack > 100 then
    self:CastMove()
    self.lastMove = GetTickCount()
  end
end

function GOSPlus:DrawHitMarker()
  if OrbwalkerPlus.Drawings.lasthit:Value() then
    local rangeCheck = self.Range < 350 and 800 or self.Range + 350
    for i = 1, GameMinionCount() do
      local minion = GameMinion(i)
      if minion.valid and minion.isEnemy and GetDistance(minion.pos, myHero.pos) < rangeCheck then
        local projectileSpeed = self:GetProjectileSpeed()
        local windUp = self:GetWindUp()
        local hpPred = self:HP_Pred(minion, windUp + (GetDistance(minion.pos, myHero.pos)) / projectileSpeed)
        local hpPred2 = self:HP_Pred(minion, windUp * 2 + myHero.attackData.animationTime + (GetDistance(minion.pos, myHero.pos)) / projectileSpeed)
        local bonusDMG = self:BonusDMG_TargetNeeded_Special(minion) + self:BonusDMG_TargetNeeded(minion)
        if hpPred <= self.DMG + bonusDMG and hpPred > 0 then
          DrawCircle(minion.pos, 50, 3, Draw.Color(240, 40, 250, 100)) -- green
        elseif hpPred2 <= self.DMG + bonusDMG then
          DrawCircle(minion.pos, 50, 3, Draw.Color(120, 250, 250, 60)) -- yellow
        end
      end
    end
  end
end

function GOSPlus:DrawEnemyRange()
  if OrbwalkerPlus.Drawings.enemyRange:Value() then
    local t = self:GetEnemyHeroes()
    if #t > 0 then
      for i = 1, #t do
        local enemy = t[i]
        if not enemy.dead and enemy.visible and GetDistance(enemy.pos, myHero.pos) < 2000 then
          DrawCircle(enemy.pos, enemy.range + enemy.boundingRadius, 1, Draw.Color(220, 250, 50, 60))
        end
      end
    end
  end
end

function GOSPlus:DisableGoSOrbwalker()
  if _G.Orbwalker then
		_G.Orbwalker.Enabled:Value(false);
		_G.Orbwalker.Drawings.Enabled:Value(false);
	end
end

_G.GOSPlus = GOSPlus()

--------------
--[[Common]]--
--------------

local AttackData = {
['Jayce'] = {AttackDelayCastOffsetPercent = -0.1, AttackDelayOffsetPercent = -0.05},
['Nidalee'] = {AttackDelayCastOffsetPercent = -0.15, AttackDelayOffsetPercent = -0.2}}

function GetAttackDelayOffsetPercent(unit)
  return AttackData[unit.charName] and AttackData[unit.charName].AttackDelayOffsetPercent or 0
end

function GetAttackDelayCastOffsetPercent(unit)
  return AttackData[unit.charName] and AttackData[unit.charName].AttackDelayCastOffsetPercent or 0
end

function GetAnimationTime(unit)
  local attackDelay = 1 / (0.62 / (GetAttackDelayOffsetPercent(unit) + 1) * unit.attackSpeed)
  return attackDelay
end

function GetWindUpSpecial(unit)
  return GetAnimationTime(unit) * (GetAttackDelayCastOffsetPercent(unit) + 0.30)
end

function GetItemSlot(unit, id)
  for i = ITEM_1, ITEM_7 do
    if unit:GetItemData(i).itemID == id then
      return i
    end
  end
  return 0 --
end

local DamageReductionTable = {
  ["Braum"] = {buff = "BraumShieldRaise", amount = function(target) return 1 - ({0.3, 0.325, 0.35, 0.375, 0.4})[target:GetSpellData(_E).level] end},
  ["Urgot"] = {buff = "urgotswapdef", amount = function(target) return 1 - ({0.3, 0.4, 0.5})[target:GetSpellData(_R).level] end},
  ["Alistar"] = {buff = "Ferocious Howl", amount = function(target) return ({0.5, 0.4, 0.3})[target:GetSpellData(_R).level] end},
  ["Galio"] = {buff = "GalioIdolOfDurand", amount = function(target) return 0.5 end},
  ["Garen"] = {buff = "GarenW", amount = function(target) return 0.7 end},
  ["Gragas"] = {buff = "GragasWSelf", amount = function(target) return ({0.1, 0.12, 0.14, 0.16, 0.18})[target:GetSpellData(_W).level] end},
  ["Annie"] = {buff = "MoltenShield", amount = function(target) return 1 - ({0.16, 0.22, 0.28, 0.34, 0.4})[target:GetSpellData(_E).level] end},
  ["Malzahar"] = {buff = "malzaharpassiveshield", amount = function(target) return 0.1 end}
}

function GotBuff(unit, buffname)
  for i = 0, unit.buffCount do
    local buff = unit:GetBuff(i)
    if buff.name:lower() == buffname:lower() and buff.count > 0 then
      return buff.count
    end
  end
  return 0
end

function GetBuffData(unit, buffname)
  for i = 0, unit.buffCount do
    local buff = unit:GetBuff(i)
    if buff.name:lower() == buffname:lower() and buff.count > 0 then
      return buff
    end
  end
  return {type = 0, name = "", startTime = 0, expireTime = 0, duration = 0, stacks = 0, count = 0}
end

function CalcPhysicalDamage(source, target, amount)
  local ArmorPenPercent = source.armorPenPercent
  local ArmorPenFlat = (0.4 + target.levelData.lvl / 30) * source.armorPen
  local BonusArmorPen = source.bonusArmorPenPercent

  if source.type == Obj_AI_Minion then
    ArmorPenPercent = 1
    ArmorPenFlat = 0
    BonusArmorPen = 1
  elseif source.type == Obj_AI_Turret then
    ArmorPenFlat = 0
    BonusArmorPen = 1
    if source.charName:find("3") or source.charName:find("4") then
      ArmorPenPercent = 0.25
    else
      ArmorPenPercent = 0.7
    end
  end

  if source.type == Obj_AI_Turret then
    if target.type == Obj_AI_Minion then
      amount = amount * 1.25
      if string.ends(target.charName, "MinionSiege") then
        amount = amount * 0.7
      end
      return amount
    end
  end

  local armor = target.armor
  local bonusArmor = target.bonusArmor
  local value = 100 / (100 + (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat)

  if armor < 0 then
    value = 2 - 100 / (100 - armor)
  elseif (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat < 0 then
    value = 1
  end
  return MathMax(0, MathFloor(DamageReductionMod(source, target, PassivePercentMod(source, target, value) * amount, 1)))
end

function CalcMagicalDamage(source, target, amount)
  local mr = target.magicResist
  local value = 100 / (100 + (mr * source.magicPenPercent) - source.magicPen)

  if mr < 0 then
    value = 2 - 100 / (100 - mr)
  elseif (mr * source.magicPenPercent) - source.magicPen < 0 then
    value = 1
  end
  return MathMax(0, MathFloor(DamageReductionMod(source, target, PassivePercentMod(source, target, value) * amount, 2)))
end

function DamageReductionMod(source, target, amount, DamageType)
  if source.type == Obj_AI_Hero then
    if GotBuff(source, "Exhaust") > 0 then
      amount = amount * 0.6
    end
  end

  if target.type == Obj_AI_Hero then

    for i = 0, target.buffCount do
      if target:GetBuff(i).count > 0 then
        local buff = target:GetBuff(i)
        if buff.name == "MasteryWardenOfTheDawn" then
          amount = amount * (1 - (0.06 * buff.count))
        end

        if DamageReductionTable[target.charName] then
          if buff.name == DamageReductionTable[target.charName].buff and (not DamageReductionTable[target.charName].damagetype or DamageReductionTable[target.charName].damagetype == DamageType) then
            amount = amount * DamageReductionTable[target.charName].amount(target)
          end
        end

        if target.charName == "Maokai" and source.type ~= Obj_AI_Turret then
          if buff.name == "MaokaiDrainDefense" then
            amount = amount * 0.8
          end
        end

        if target.charName == "MasterYi" then
          if buff.name == "Meditate" then
            amount = amount - amount * ({0.5, 0.55, 0.6, 0.65, 0.7})[target:GetSpellData(_W).level] / (source.type == Obj_AI_Turret and 2 or 1)
          end
        end
      end
    end

    if GetItemSlot(target, 1054) > 0 then
      amount = amount - 8
    end

    if target.charName == "Kassadin" and DamageType == 2 then
      amount = amount * 0.85
    end
  end

  return amount
end

function PassivePercentMod(source, target, amount, damageType)
  local SiegeMinionList = {"Red_Minion_MechCannon", "Blue_Minion_MechCannon"}
  local NormalMinionList = {"Red_Minion_Wizard", "Blue_Minion_Wizard", "Red_Minion_Basic", "Blue_Minion_Basic"}

  if source.type == Obj_AI_Turret then
    if table.contains(SiegeMinionList, target.charName) then
      amount = amount * 0.7
    elseif table.contains(NormalMinionList, target.charName) then
      amount = amount * 1.14285714285714
    end
  end
  if source.type == Obj_AI_Hero then
    if target.type == Obj_AI_Hero then
      if (GetItemSlot(source, 3036) > 0 or GetItemSlot(source, 3034) > 0) and source.maxHealth < target.maxHealth and damageType == 1 then
        amount = amount * (1 + MathMin(target.maxHealth - source.maxHealth, 500) / 50 * (GetItemSlot(source, 3036) > 0 and 0.015 or 0.01))
      end
    end
  end
  return amount
end

function GetBuffs(unit)
  local t = {}
  local counter = 0
  for i = 0, unit.buffCount do
    local buff = unit:GetBuff(i)
    if buff.count > 0 then
      t[counter + 1] = buff
    end
  end
  return t
end

function GetDistance2DSqr(a, b)
  local x = (a.x - b.x);
  local y = (a.y - b.y);
  return x * x + y * y;
end

function GetDistanceSqr(a, b)
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

function GetDistance(p1, p2)
    return MathSqrt(GetDistanceSqr(p1, p2))
end

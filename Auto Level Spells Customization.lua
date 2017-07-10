class "AutoLevelSpells"
--lol = 7.13
--ver = 1.3
function AutoLevelSpells:__init()
    SkillOrder = {}
    OrderName = {}
  	currentLvPts = 0
  	LvSpellTimer = 0
  	self:LoadFile()
  	self:Menu()
  	Callback.Add("Tick", function() self:Tick() end)
end

function AutoLevelSpells:LoadFile()
  if not FileExist(COMMON_PATH.."AutoLevel.txt") then return end
  local File = io.open(COMMON_PATH.."AutoLevel.txt", "r")
  local FileContent = File:read("*all")
  File:close()
  for line in string.gmatch(FileContent,'[^\r\n]+') do   --('+' is for skipping over empty lines
      local str = line:sub(1, 1)
      if str ~= "-" and str ~= "/" and str ~= "*" then -- if it's not a comment then
        local champion = self:GetChampionName(line)
        if champion:lower():find(myHero.charName:lower()) then
            local name = self:GetOrderName(line)
            if name then
                table.insert(OrderName, name)
                self:GetSkillOrder(line, name)
            else
                table.insert(OrderName, "Spell"..#OrderName+1)
                self:GetSkillOrder(line, "Spell"..#OrderName)
            end
        end
     end
  end
end

function AutoLevelSpells:GetChampionName(line)
    for i = 1, #line do
        local str1 = line:sub(i, i)
        local str2 = line:sub(i-1 , i-1)
        if (str1 == ' ' and str2 ~= ' ') or ( (str1 == "|" or str1 == "," or str1 == "." or str1 == "/" or str1 == "\\" ) and str2 ~= ' ') then
            return line:sub(1, i-1)
        end
    end
end

function AutoLevelSpells:GetOrderName(line)
    for i = 1, #line do
        local str1 = line:sub(i, i)
        if str1 == "|" or str1 == "," or str1 == "." or str1 == "/" or str1 == "\\"   then
            for j = i+1, #line do
                local str2 = line:sub(j, j)
                if str2 ~= " " then
                    for k= j+1, #line do
                        local str3 = line:sub(k, k)
                        if str3 == " " then
                            return line:sub(j, k-1)
                        end
                    end
                end
            end
        elseif i == #line then
            return nil
        end
    end
end

function AutoLevelSpells:GetSkillOrder(line, name)
    for i = 1, #line do
        local str1 = line:sub(i, i)
        local str2 = line:sub(i+1, i+1)
        if str1 == " " and str2 ~= " " then
            SkillOrder[name] = {}
            for j = 1, 18 do
                local spell = line:sub(i+j, i+j)
                if spell == "1" or spell == "q" or spell == "Q" then
                        SkillOrder[name][j] = _Q
                elseif spell == "2" or spell == "w" or spell == "W" then
                        SkillOrder[name][j] = _W
                elseif spell == "3" or spell == "e" or spell == "E" then
                        SkillOrder[name][j] = _E
                elseif spell == "4" or spell == "r" or spell == "R" then
                        SkillOrder[name][j] = _R
                end
            end
        end
    end
end

function AutoLevelSpells:Menu()
    --icon
    local Icons = { Menu = "https://image.ibb.co/b3XCCa/N6p_VC84qnoo_Es_OCJ15dija_OIfi_Zw_Bi1t0z6_IDwczm_x_KO1_E_y9_NGaogv5jhj_QDx3_YRIF_w300.png",
                    Enable =	"https://image.ibb.co/fo93JF/256_256_da4555b24380d442df41fc883fbe3411.png",
                    lvl =	"https://image.ibb.co/kAzEQv/right_arrow_icon_95235.png",
                    Humanizer	=	"https://image.ibb.co/kizsCa/clock_128.png",
                    Custom = "https://image.ibb.co/fdM5Xa/star.png",
                    KeyR = "http://image2.indotrading.com/co23081/personalwebsite/635639981389215900.png"
    							}
  	--Main Menu
  	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Auto Level Spells: Customization", leftIcon = Icons.Menu})
  	self.Menu:MenuElement({id = "Enable", name = "Enable", value = true , leftIcon = Icons.Enable })
    --Main Menu -- champion
    self.Menu:MenuElement({type = MENU, id = "Custom", name = myHero.charName.." - Custom", leftIcon = Icons.Custom})
    if #OrderName == 0 then self.Menu.Custom:MenuElement({type = SPACE, name = "No Custom Spell Order", value = false}) else
        for key,value in pairs(OrderName) do
            self.Menu.Custom:MenuElement({id = key, name = value:upper().." : "..self:DisplayOrderName(key), value = false, onclick = function() self:SpellController() end})
        end
    end
  	--Main Menu
  	self.Menu:MenuElement({id = "Start", name = "Start Above Level", value = 2, min = 1, max = 18, step = 1, leftIcon = Icons.lvl })
  	self.Menu:MenuElement({id = "Delay", name = "Level Up Spell Delay (seconds)", value = 0.8, min = 0, max = 2.5, step = 0.05, leftIcon = Icons.Humanizer})
    self.Menu:MenuElement({id = "ROnly", name = "R Spell Only", value = false, leftIcon = Icons.KeyR, onclick = function() self:RSpellController() end})
    --PrintChat(SkillOrder)
end

function  AutoLevelSpells:DisplayOrderName(key)
    local spell = {}
    for i = 1, 6 do
        spell[i] = self:ToString(SkillOrder[OrderName[key]][i])
    end
    return table.concat(spell," > ")
end

function AutoLevelSpells:ToString(spellNum)
  	local spells = {"Q", "W", "E", "R"}
  	return spells[spellNum+1]
end

function AutoLevelSpells:ToHK(spellNum)
  	local HK = {HK_Q, HK_W, HK_E, HK_R}
  	return HK[spellNum+1]
end

function AutoLevelSpells:RSpellController()
    -- R on
    if self.Menu.ROnly:Value() then
        for key,value in pairs(OrderName) do
            self.Menu.Custom[key]:Value(false)
        end
    end
end

function AutoLevelSpells:SpellController()
    -- Custom order On
    for key,value in pairs(OrderName) do
        if self.Menu.Custom[key]:Value() then
            self.Menu.ROnly:Value(false)
        end
    end
end

function AutoLevelSpells:Tick()
  --PrintChat("exp = "..myHero.levelData.exp.."  Current LV = "..myHero.levelData.lvl.."  lvlPts = "..myHero.levelData.lvlPts)
	if not self.Menu.Enable:Value() then return end

	local level = myHero.levelData.lvl
	if level < self.Menu.Start:Value() then return end

	--local levelpts = myHero.levelData.lvlPts
  local levelpts = myHero.levelData.lvl - (myHero:GetSpellData(_Q).level + myHero:GetSpellData(_W).level + myHero:GetSpellData(_E).level + myHero:GetSpellData(_R).level)
  --PrintChat("lvlPts = "..levelpts)

	if levelpts ~= currentLvPts then
      --PrintChat("levelpts "..levelpts.." ~= currentLvPts in lua "..currentLvPts)
			currentLvPts = levelpts
			LvSpellTimer = Game.Timer()
	end

  if not self.Menu.ROnly:Value() and levelpts >= 1 and Game.Timer() - LvSpellTimer > 5 then
      PrintChat("Fail to level spells. Please check you setting!")
  end

	if self.Menu.ROnly:Value() then
      --PrintChat("R Only")
      if level >= 1 and levelpts >= 1 then
    			if (level + 1 - levelpts) ==  6 or (level + 1 - levelpts) == 11 or (level + 1 - levelpts) == 16 then
    					if Game.Timer() > LvSpellTimer + self.Menu.Delay:Value() then
                --PrintChat("leveling R")
    						Control.KeyDown(HK_LUS)
    						Control.KeyDown(HK_R)
    						Control.KeyUp(HK_R)
    						Control.KeyUp(HK_LUS)
    					end
    			end
      end
	elseif not self.Menu.ROnly:Value() then
      --PrintChat("Custom LV spell")
			if level >= 1 and levelpts >= 1 then
					if Game.Timer() > LvSpellTimer + self.Menu.Delay: Value() then
            for key,value in pairs(OrderName) do
  							if self.Menu.Custom[key]:Value() then
    								Control.KeyDown(HK_LUS)
    								Control.KeyDown(self:ToHK(SkillOrder[OrderName[key]][(level + 1 - levelpts)]))
                    						Control.KeyUp(self:ToHK(SkillOrder[OrderName[key]][(level + 1 - levelpts)]))
    								Control.KeyUp(HK_LUS)
  							end
            end
					end
			end
	end

end

function OnLoad()
	 AutoLevelSpells()
end

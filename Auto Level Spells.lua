--Created by Jarkao (GamingOnSteroids)
--Version = 1.41
--Support All Patch version

class "AutoLevelSpells"

function AutoLevelSpells:__init()
    self.SkillOrder = {}
    self.OrderName = {}
    self.Levelup = false
    self.Levelpts = 0
    self.Timer = 0
    self.Index = 0
    self.HotKey = {[_Q] = HK_Q, [_W] = HK_W, [_E] = HK_E, [_R] = HK_R}
    self.HotKeyToString = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}

    Callback.Add("Load", function() self:Load() end)
end

function AutoLevelSpells:Load()
  	self:LoadFile()
  	self:Menu()
  	Callback.Add("Tick", function() self:Tick() end)
end

function AutoLevelSpells:LoadFile()
  if not FileExist(COMMON_PATH.."AutoLevel.txt") then return end
  PrintChat("Custom Spells Order Loaded!")
  local File = io.open(COMMON_PATH.."AutoLevel.txt", "r")
  local FileContent = File:read("*all")
  File:close()
  for line in string.gmatch(FileContent,'[^\r\n]+') do   --('+' is for skipping over empty lines
      local str = line:sub(1, 1)
      if str ~= "-" and str ~= "/" and str ~= "*" and str ~= "#" and str ~= "@" then -- not a comment
        local champion = self:GetChampionName(line)
        if champion:lower():find(myHero.charName:lower()) then
            local name = self:GetOrderName(line)
            if name then
                table.insert(self.OrderName, name)
                self:GetSkillOrder(line, name)
            else
                table.insert(self.OrderName, "Custom "..#self.OrderName+1)
                self:GetSkillOrder(line, "Custom "..#self.OrderName)
            end
        end
     end
  end
end

function AutoLevelSpells:GetChampionName(line)
    for i = 1, #line do
        local str = line:sub(i, i)
        if str == " " or str == "\t" or str == "|" or str == "," or str == "." or str == "/" or str == "\\" then
            self.Index = i
            return line:sub(1, i-1)
        end
    end
end

function AutoLevelSpells:GetOrderName(line)
    for i = self.Index, #line do
        local sign = line:sub(i, i)
        if sign == "|" or sign == "," or sign == "." or sign == "/" or sign == "\\"  then
            for j = i+1, #line do
                local str1 = line:sub(j, j)
                if str1 ~= " " and str1 ~= "\t" then
                    for k= j+1, #line do
                        local str2 = line:sub(k, k)
                        if str2 == " " or str2 == "\t" then
                        	self.Index = k
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
    for i = self.Index, #line do
        local str1 = line:sub(i, i)
        local str2 = line:sub(i+1, i+1)
        if (str1 == " " or str1 == "\t") and (str2 ~= " " and str2 ~= "\t") then
            self.SkillOrder[name] = {}
            for j = 1, 18 do
                local spell = line:sub(i+j, i+j)
                if spell == "1" or spell == "q" or spell == "Q" then
                    self.SkillOrder[name][j] = _Q
                elseif spell == "2" or spell == "w" or spell == "W" then
                    self.SkillOrder[name][j] = _W
                elseif spell == "3" or spell == "e" or spell == "E" then
                    self.SkillOrder[name][j] = _E
                elseif spell == "4" or spell == "r" or spell == "R" then
                    self.SkillOrder[name][j] = _R
                end
            end
        end
    end
end

function AutoLevelSpells:Menu()
    self.Icons = { 	Menu 	= 	"https://image.ibb.co/b3XCCa/N6p_VC84qnoo_Es_OCJ15dija_OIfi_Zw_Bi1t0z6_IDwczm_x_KO1_E_y9_NGaogv5jhj_QDx3_YRIF_w300.png",
	                Enable 	=	"https://image.ibb.co/fo93JF/256_256_da4555b24380d442df41fc883fbe3411.png",
	                lvl 	=	"https://image.ibb.co/kAzEQv/right_arrow_icon_95235.png",
	                Humanizer	=	"https://image.ibb.co/kizsCa/clock_128.png",
	                Custom 	= "https://image.ibb.co/fdM5Xa/star.png",
	                KeyR 	= "http://image2.indotrading.com/co23081/personalwebsite/635639981389215900.png"
				}

  	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Auto Level Spells", leftIcon = self.Icons.Menu})
  	self.Menu:MenuElement({id = "Enable", name = "Enable", value = true, leftIcon = self.Icons.Enable })

    self.Menu:MenuElement({type = MENU, id = "Custom", name = myHero.charName.." - Spells Order", leftIcon = self.Icons.Custom})
    if #self.OrderName == 0 then self.Menu.Custom:MenuElement({type = SPACE, name = "No Custom Spells Order", value = false}) else
        for key,value in pairs(self.OrderName) do
            self.Menu.Custom:MenuElement({id = key, name = value:upper().." : "..self:DisplayOrderName(key), value = false, onclick = function() self:DisableRSpell() end})
        end
    end

  	self.Menu:MenuElement({id = "Start", name = "Start Above Level", value = 2, min = 1, max = 18, step = 1, leftIcon = self.Icons.lvl})
  	self.Menu:MenuElement({id = "Delay", name = "Level up Delay in Seconds", value = 0.8, min = 0, max = 1.5, step = 0.05, leftIcon = self.Icons.Humanizer})
    self.Menu:MenuElement({id = "ROnly", name = "R Spell Only", value = false, leftIcon = self.Icons.KeyR, onclick = function() self:DisableCustomSpells() end})
end

function  AutoLevelSpells:DisplayOrderName(key)
    local spell = {}
    for i = 1, 6 do
        spell[i] = self.HotKeyToString[self.SkillOrder[self.OrderName[key]][i]]
    end
    return table.concat(spell," > ")
end

function AutoLevelSpells:DisableCustomSpells()
    if self.Menu.ROnly:Value() then
        for key,value in pairs(self.OrderName) do
        	if self.Menu.Custom[key]:Value() then
            	self.Menu.Custom[key]:Value(false)
            end
        end
    end
end

function AutoLevelSpells:DisableRSpell()
    for key,value in pairs(self.OrderName) do
        if self.Menu.Custom[key]:Value() then
        	if self.Menu.ROnly:Value() then
            	self.Menu.ROnly:Value(false)
            end
        end
    end
end

function AutoLevelSpells:Tick()
  	if not self.Menu.Enable:Value() then return end

  	local mylevel = myHero.levelData.lvl
  	if mylevel < self.Menu.Start:Value() then return end

    local mylevelpts = myHero.levelData.lvl - (myHero:GetSpellData(_Q).level + myHero:GetSpellData(_W).level + myHero:GetSpellData(_E).level + myHero:GetSpellData(_R).level)

	if mylevelpts ~= self.Levelpts then
  		self.Levelpts = mylevelpts
  		self.Timer = Game.Timer()
        self.Levelup = true
    end

  	if	self.Levelup then 
  		if mylevelpts > 0 and Game.Timer() > self.Timer + self.Menu.Delay:Value() then
	  		if self.Menu.ROnly:Value() then
	  			local R_Level = myHero:GetSpellData(_R).level
	  			if mylevel >= 6 and R_Level == 0 or mylevel >= 11 and R_Level == 1 or mylevel >= 16 and R_Level == 2 then
	  				self.Levelup = false
	  				Control.KeyDown(HK_LUS)
	                Control.KeyDown(HK_R)
	            	Control.KeyUp(HK_R)
	            	Control.KeyUp(HK_LUS)
	            end
	        else
	        	for index,value in pairs(self.OrderName) do
		        	if self.Menu.Custom[index]:Value() then
		        		self.Levelup = false
		        		local _KEY = self.SkillOrder[self.OrderName[index]][(mylevel + 1 - mylevelpts)]
		        		Control.KeyDown(HK_LUS)
		        		Control.KeyDown(self.HotKey[_KEY])
		        		Control.KeyUp(self.HotKey[_KEY])
		          		Control.KeyUp(HK_LUS)
		        	end
	        	end
	        end
	    end
  	end

end

AutoLevelSpells()
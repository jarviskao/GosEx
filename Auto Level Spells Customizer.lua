class "AutoLevelSpells"

lol = 7.11
ver = 1.2

function AutoLevelSpells:__init()
	myHeroName = myHero.charName
  customSkillOrder = {}
	currentLvPts = 0
	LvSpellTimer = nil
	self:LoadFile()
	self:LoadMenu()
	Callback.Add("Tick", function() self:Tick() end)
end

function AutoLevelSpells:LoadFile()
  local File = io.open(COMMON_PATH.."AutoLevel.txt", "r")
  local FileContent = File:read("*all")
  File:close()

  for s in string.gmatch(FileContent,'[^\r\n]+') do   --('+' is for skipping over empty lines
      local champion = AutoLevelSpells:GetChampionName(s)
      local str = s:sub(1, 1)
      if str ~= "-" and str ~= "/" and str ~= "*" then -- if it's not a comment then
          if champion:lower():find(myHeroName:lower()) then
              AutoLevelSpells:GetSkillOrder(s)
          end
     end
  end
  --PrintChat(customSkillOrder)
end

function AutoLevelSpells:GetChampionName(file)
  for i = 1, #file do
        local str1 = file:sub(i, i)
        local str2 = file:sub(i-1 , i-1)
        if str1 == ' ' and str2 ~= ' ' then
          return file:sub(1, i)
        end
  end
end

function AutoLevelSpells:GetSkillOrder(file)
        for i = 1, #file do
                local str1 = file:sub(i, i)
                local str2 = file:sub(i+1, i+1)
                if str1 == " " and str2 ~= " " then
                        for j = 1, 18 do
                                local spell = file:sub(i+j, i+j)
                                if spell == "1" or spell == "q" or spell == "Q" then
                                        customSkillOrder[j] = _Q
                                elseif spell == "2" or spell == "w" or spell == "W" then
                                        customSkillOrder[j] = _W
                                elseif spell == "3" or spell == "e" or spell == "E" then
                                        customSkillOrder[j] = _E
                                elseif spell == "4" or spell == "r" or spell == "R" then
                                        customSkillOrder[j] = _R
                                end
                        end
                end
        end
end

function AutoLevelSpells:LoadMenu()
	local MenuIcons			  =	"https://lh3.ggpht.com/N6pVC84qnooEsOCJ15dijaOIfiZwBi1t0z6IDwczm_xKO1E_y9NGaogv5jhjQDx3YRIF=w300"
	local EnableIcons		  =	"http://www.myiconfinder.com/uploads/iconsets/256-256-da4555b24380d442df41fc883fbe3411.png"
	local SequenceIcons		=	"http://www.basistechnologies.com/sites/default/files/04_Sequence.png"
	local lvlIcons			  =	"http://downloadicons.net/sites/default/files/right-arrow-icon-95235.png"
	local HumanizerIcons	=	"https://cdn4.iconfinder.com/data/icons/small-n-flat/24/clock-128.png"
	local KeyQ	          = "http://www.mobafire.com/images/key-q.png"
	local KeyW	          = "http://www.mobafire.com/images/key-w.png"
	local KeyE	          = "http://www.mobafire.com/images/key-e.png"
	local KeyR	          = "http://www.mobafire.com/images/key-r.png"
	local DefaultIcons	  =	"http://findicons.com/files/icons/1700/2d/512/star.png"
	--Main Menu
	self.Menu = MenuElement({type = MENU, id = "Menu", name = "Auto Level Spells: Customizer", leftIcon = MenuIcons})
	self.Menu:MenuElement({id = "UseAutoLvSpell", name = "Enable", value = true , leftIcon = EnableIcons })
	--Main Menu --Spells Order
	self.Menu:MenuElement({type = MENU, id = "SpellsOrder", name = "Spells Order", leftIcon = SequenceIcons})
	--Main Menu --Spells Order -- Q
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "Q", name = " Q First", leftIcon = KeyQ})
	self.Menu.SpellsOrder.Q:MenuElement({id = "QW", name = "Q > W > E > Q > Q (Max Q > W)", value = false, onclick =	function() self:SetMenuStatus(1)	end})
	self.Menu.SpellsOrder.Q:MenuElement({id = "QE", name = "Q > E > W > Q > Q (Max Q > E)", value = false, onclick =	function() self:SetMenuStatus(2)	end})
	--Main Menu --Spells Order -- W
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "W", name = " W First", leftIcon = KeyW})
	self.Menu.SpellsOrder.W:MenuElement({id = "WQ", name = "W > Q > E > W > W (Max W > Q)", value = false, onclick =	function() self:SetMenuStatus(3)	end})
	self.Menu.SpellsOrder.W:MenuElement({id = "WE", name = "W > E > Q > W > W (Max W > E)", value = false, onclick =	function() self:SetMenuStatus(4)	end})
	--Main Menu --Spells Order -- E
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "E", name = " E First", leftIcon = KeyE})
	self.Menu.SpellsOrder.E:MenuElement({id = "EQ", name = "E > Q > W > E > E (Max E > Q)", value = false, onclick =	function() self:SetMenuStatus(5)	end})
	self.Menu.SpellsOrder.E:MenuElement({id = "EW", name = "E > W > Q > E > E (Max E > W)", value = false, onclick =	function() self:SetMenuStatus(6)	end})
	--Main Menu --Spells Order -- R
	self.Menu.SpellsOrder:MenuElement({id = "ROnly", name = " R Only", value = false, leftIcon = KeyR, onclick = function() self:SetMenuStatus(7) end})
	--Main Menu --Spells Order -- Recommend
	self.Menu.SpellsOrder:MenuElement({type = MENU, id = "Default", name = myHero.charName.." - Custom", leftIcon = DefaultIcons})
	self.Menu.SpellsOrder.Default:MenuElement({id = "Order", name = self:ToString(customSkillOrder[1]).." > "..self:ToString(customSkillOrder[2]).." > "..
																																	self:ToString(customSkillOrder[3]).." > "..self:ToString(customSkillOrder[4]).." > "..
																																	self:ToString(customSkillOrder[5]).." > "..self:ToString(customSkillOrder[6]).." > "..
																																	self:ToString(customSkillOrder[7]).." > "..self:ToString(customSkillOrder[8]), value = false, onclick = function() self:SetMenuStatus(8)	end})
	--Main Menu --Spells Order
	self.Menu:MenuElement({id = "Start", name = "Start Above Level", value = 2, min = 1, max = 18, step = 1, leftIcon = lvlIcons })
	self.Menu:MenuElement({id = "Delay", name = "Level Up Spell Delay (seconds)", value = 0.8, min = 0, max = 2.5, step = 0.1, leftIcon = HumanizerIcons})
	self:SetMenuInit()
end

function AutoLevelSpells:SetMenuInit()
	self.Menu.SpellsOrder.Q.QW:Value(false)		self.Menu.SpellsOrder.Default.Order:Value()
	self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
	self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
	self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
end

function AutoLevelSpells:SetMenuStatus(num)
	local switch = {
	    [1] = function()    -- for case 1
				self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false)
	    end,
	    [2] = function()    -- for case 2
				self.Menu.SpellsOrder.Q.QW:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false)
	    end,
	    [3] = function()    -- for case 3
				self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.Q.QW:Value(false)
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false)
	    end,
			[4] = function()
				self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
				self.Menu.SpellsOrder.Q.QW:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false)
	    end,
			[5] = function()
				self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.Q.QW:Value(false)
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false)
	    end,
			[6] = function()
				self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
				self.Menu.SpellsOrder.Q.QW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false)
	    end,
			[7] = function()
				self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.Q.QW:Value(false)
				self.Menu.SpellsOrder.Default.Order:Value(false)
	    end,
			[8] = function()
				self.Menu.SpellsOrder.Q.QE:Value(false) 	self.Menu.SpellsOrder.W.WQ:Value(false)
				self.Menu.SpellsOrder.W.WE:Value(false) 	self.Menu.SpellsOrder.E.EQ:Value(false)
				self.Menu.SpellsOrder.E.EW:Value(false) 	self.Menu.SpellsOrder.ROnly:Value(false)
				self.Menu.SpellsOrder.Q.QW:Value(false)
	    end
	}
	switch[num]()
end

function AutoLevelSpells:ToString(spellNum)
	local spells = {"Q", "W", "E", "R"}
	return spells[spellNum+1]
end

function AutoLevelSpells:ToHK(spellNum)
	local HK = {HK_Q, HK_W, HK_E, HK_R}
	return HK[spellNum+1]
end

function AutoLevelSpells:OrderSelected()
	if self.Menu.SpellsOrder.Q.QW:Value() then
			SpellOrder = {0, 1, 2, 0, 0, 3, 0, 1, 0, 1, 3, 1, 1, 2, 2, 3, 2, 2}  	-- Order: Q>W>E>Q>Q (Max Q > W)
	elseif self.Menu.SpellsOrder.Q.QE:Value() then
			SpellOrder = {0, 2, 1, 0, 0, 3, 0, 2, 0, 2, 3, 2, 2, 1, 1, 3, 1, 1}		-- Order: Q>E>W>Q>Q (Max Q > E)
	elseif self.Menu.SpellsOrder.W.WQ:Value() then
			SpellOrder = {1, 0, 2, 1, 1, 3, 1, 0, 1, 0, 3, 0, 0, 2, 2, 3, 2, 2}		-- Order: W>Q>E>W>W (Max W > Q)
	elseif self.Menu.SpellsOrder.W.WE:Value() then
			SpellOrder = {1, 2, 0, 1, 1, 3, 1, 2, 1, 2, 3, 2, 2, 0, 0, 3, 0, 0}		-- Order: W>E>Q>W>W (Max W > E)
	elseif self.Menu.SpellsOrder.E.EQ:Value() then
			SpellOrder = {2, 0, 1, 2, 2, 3, 2, 0, 2, 0, 3, 0, 0, 1, 1, 3, 1, 1}		-- Order: E>Q>W>E>E (Max E > Q)
	elseif self.Menu.SpellsOrder.E.EW:Value() then
			SpellOrder = {2, 1, 0, 2, 2, 3, 2, 1, 2, 1, 3, 1, 1, 0, 0, 3, 0, 0}		-- Order: E>W>Q>E>E (Max E > W)
	else
			SpellOrder = nil
	end
end

function AutoLevelSpells:Tick()

	if not self.Menu.UseAutoLvSpell:Value() then return end

	if not self.Menu.SpellsOrder.Q.QW:Value() and not self.Menu.SpellsOrder.Q.QE:Value() and
		 not self.Menu.SpellsOrder.W.WQ:Value() and not self.Menu.SpellsOrder.W.WE:Value() and
		 not self.Menu.SpellsOrder.E.EQ:Value() and not self.Menu.SpellsOrder.E.EW:Value() and
		 not self.Menu.SpellsOrder.ROnly:Value() and not  self.Menu.SpellsOrder.Default.Order:Value() then
		 return
	end

	local level = myHero.levelData.lvl
	if level < self.Menu.Start:Value() then return end

	local levelpts = myHero.levelData.lvlPts
	if levelpts ~= currentLvPts then
			currentLvPts = levelpts
			LvSpellTimer = Game.Timer()
	end

	if self.Menu.SpellsOrder.ROnly:Value() then
			if (level + 1 - levelpts) ==  6 or (level + 1 - levelpts) == 11 or (level + 1 - levelpts) == 16 then
					if Game.Timer() > LvSpellTimer + self.Menu.Delay: Value() then
						Control.KeyDown(HK_LUS)
						Control.CastSpell(HK_R)
						Control.KeyUp(HK_LUS)
					end
			end
	elseif not self.Menu.SpellsOrder.ROnly:Value() then
			if level >= 1 and levelpts >= 1 then
					if Game.Timer() > LvSpellTimer + self.Menu.Delay: Value() then
							self:OrderSelected()
							Control.KeyDown(HK_LUS)
							if self.Menu.SpellsOrder.Default.Order:Value() then
								Control.CastSpell(self:ToHK(customSkillOrder[(level + 1 - levelpts)]))
							elseif SpellOrder ~= nil then
								Control.CastSpell(self:ToHK(SpellOrder[(level + 1 - levelpts)]))
							end
							Control.KeyUp(HK_LUS)
					end
			end
	end

end

function OnLoad()
	if not FileExist(COMMON_PATH.."AutoLevel.txt") then
		local  File = io.open(COMMON_PATH.."AutoLevel.txt", "w")
		File:close()
	end
	AutoLevelSpells()
end

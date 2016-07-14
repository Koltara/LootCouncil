local LootCouncil = LibStub("AceAddon-3.0"):NewAddon("LootCouncil", "AceConsole-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local AceTimer = LibStub("AceTimer-3.0")

local valueTable = {}


local options =
{
	name = "LootCouncil",
	handler = LootCouncil,
	type = 'group',
	args = {
	},
}

local defaults =
{
	profile = {
  	message = "LootCouncil Defaults",
 	},
}

function LootCouncil:OnInitialize()

	mainWindow = AceGUI:Create("Frame")
	mainWindow:SetTitle("Loot Council")
	mainWindow:SetStatusText("Loot Council Main Window")
	mainWindow:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	mainWindow:SetLayout("Flow")

	raidStartButton = AceGUI:Create("Button")
	raidStartButton:SetWidth(200)
	raidStartButton:SetText("Start Raid")
	raidStartButton:SetCallback("OnClick", "StartRaid")

	raidEndButton = AceGUI:Create("Button")
	raidEndButton:SetWidth(200)
	raidEndButton:SetText("End Raid")
	raidEndButton:SetCallback("OnClick", "EndRaid")

	mainWindow:AddChild(raidEndButton)
	mainWindow:AddChild(raidStartButton)

	self.db = LibStub("AceDB-3.0"):New("LootCouncilDB", defaults, true)

	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LootCouncil", "LootCouncil")

	LootCouncil:RegisterChatCommand("lcout", "ValueOutput")

	LibStub("AceConfig-3.0"):RegisterOptionsTable("LootCouncil", options, nil)

end

function LootCouncil:ValueOutput()

	local raidMembers = GetHomePartyInfo()

	--for i=0, 1
	--do
	local memberName = tostring(raidMembers[1])
		LootCouncil:Print(valueTable.memberName.name .. ", " .. valueTable.memberName.value)
	--end

end

function LootCouncil:StartRaid()
	-- Set Initial Raid Members

	SetLootMethod("master", "player")
	SetLootThreshold(4)

	local raidMembers = GetHomePartyInfo()

	LootCouncil:Print(raidMembers)

	for i=1, raidMembers.getn()
	do
		valueTable[tostring(raidMembers[i])] =
		{
			name = "raidMembers[i]",
			value = value + 50;
		}
		LootCouncil:Print(raidMembers[i])
	end

	valueTable.overallPresence = valueTable.overallPresence + 50

end

function LootCouncil:EndRaid()

	-- Store participation time and total time.
	local raidMembers = GetHomePartyInfo()
	LootCouncil:Print(raidMembers)

	for i=1, raidMembers.getn()
	do
		valueTable.raidMembers[i] =
		{
			name = raidMembers[i],
			value = value + 50;
			LootCouncil:Print(raidMembers[i])
		}
	end

	valueTable.overallPresence = valueTable.overallPresence + 50

end

function LootCouncil:OnEnable()
	 --mainWindow:SetDisabled(false)
end

function LootCouncil:OnDisable()
	-- Lots of Kappa
	-- Never Disable
	--mainWindow:SetDisabled(true)
end


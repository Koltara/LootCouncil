local LootCouncil = LibStub("AceAddon-3.0"):NewAddon("LootCouncil", "AceConsole-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local AceTimer = LibStub("AceTimer-3.0")

local valueTable = {}

local ScrollingTable = LibStub("ScrollingTable");

local cols =
{
	["Headers"] = {	-- Column 1 (Raid Participant)
		["name"] = "Raid Participant",
		["width"] = 50,
		["align"] = "RLEFT",
		["color"] = {
			["r"] = 0.5,
			["g"] = 0.5,
			["b"] = 1.0,
			["a"] = 1.0
		},
		["colorargs"] = nil,
		["bgcolor"] = {
			["r"] = 1.0,
			["g"] = 0.0,
			["b"] = 0.0,
			["a"] = 1.0
		}, -- red backgrounds, eww!
		["defaultsort"] = "dsc",
		["sortnext"]= 4,
		["comparesort"] = function (cella, cellb, column)
			return cella.value < cellb.value;
		end,
		["DoCellUpdate"] = nil,
	},
	{	-- Column 2 (Class)
		["name"] = "Class",
		["width"] = 50,
		["align"] = "LEFT",
		["color"] = {
			["r"] = 0.5,
			["g"] = 0.5,
			["b"] = 1.0,
			["a"] = 1.0
		},
		["colorargs"] = nil,
		["bgcolor"] = {
			["r"] = 1.0,
			["g"] = 0.0,
			["b"] = 0.0,
			["a"] = 1.0
		}, -- red backgrounds, eww!
		["defaultsort"] = "dsc",
		["sortnext"]= 4,
		["comparesort"] = function (cella, cellb, column)
			return cella.value < cellb.value;
		end,
		["DoCellUpdate"] = nil,
	},
	{	-- Column 3 (Presence)
		["name"] = "Presence",
		["width"] = 50,
		["align"] = "LEFT",
		["color"] = {
			["r"] = 0.5,
			["g"] = 0.5,
			["b"] = 1.0,
			["a"] = 1.0
		},
		["colorargs"] = nil,
		["bgcolor"] = {
			["r"] = 1.0,
			["g"] = 0.0,
			["b"] = 0.0,
			["a"] = 1.0
		}, -- red backgrounds, eww!
		["defaultsort"] = "dsc",
		["sortnext"]= 4,
		["comparesort"] = function (cella, cellb, column)
			return cella.value < cellb.value;
		end,
		["DoCellUpdate"] = nil,
	},
	{	-- Column 4 (Overall Presence)
		["name"] = "Class",
		["width"] = 50,
		["align"] = "LEFT",
		["color"] = {
			["r"] = 0.5,
			["g"] = 0.5,
			["b"] = 1.0,
			["a"] = 1.0
		},
		["colorargs"] = nil,
		["bgcolor"] = {
			["r"] = 1.0,
			["g"] = 0.0,
			["b"] = 0.0,
			["a"] = 1.0
		}, -- red backgrounds, eww!
		["defaultsort"] = "dsc",
		["sortnext"]= 4,
		["comparesort"] = function (cella, cellb, column)
			return cella.value < cellb.value;
		end,
		["DoCellUpdate"] = nil,
	},

}



local displayTable = ScrollingTable:CreateST(cols, nil, 50, nil, nil);





local function LootCouncil:DrawControlTab(container)
	--[[

	First Tab
	]]--

end

local function LootCouncil:DrawDisplayTab(container)
	--[[

	Second Tab
	]]--
end

function LootCouncil:OnInitialize()

	mainWindow = AceGUI:Create("Frame")
	mainWindow:SetTitle("Loot Council")
	mainWindow:SetStatusText("Loot Council Main Window")
	mainWindow:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	mainWindow:SetLayout("Flow")

	raidStartButton = AceGUI:Create("Button")
	raidStartButton:SetWidth(200)
	raidStartButton:SetText("Start Raid")
	raidStartButton:SetCallback("OnClick", StartRaid())

	raidEndButton = AceGUI:Create("Button")
	raidEndButton:SetWidth(200)
	raidEndButton:SetText("End Raid")
	raidEndButton:SetCallback("OnClick", EndRaid())

	mainWindow:AddChild(raidEndButton)
	mainWindow:AddChild(raidStartButton)



	local options =
	{
		name = "LootCouncil",
		handler = LootCouncil,
		type = 'group',
		args =
		{
			msg =
			{
				type = 'input',
				name = 'My Message',
				desc = 'The message for my addon',
				set = 'SetMyMessage',
				get = 'GetMyMessage',
			},
		}	,
	}



	self.db = LibStub("AceDB-3.0"):New("LootCouncilDB")

	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)

	LootCouncil:RegisterChatCommand("lcout", "ValueOutput")

	LibStub("AceConfig-3.0"):RegisterOptionsTable("LootCouncil", options, {"myslash"})

end

function LootCouncil:ValueOutput(input)
{
	raidMembers = GetHomePartyInfo()

	for i=0, raidMembers.getn()
	do
		LootCouncil:Print(valueTable.raidMembers[i].name .. ", " .. valueTable.raidMembers[i].value)
	end
}
end

function LootCouncil:StartRaid()
	-- Set Initial Raid Members

	SetLootMethod(["master", "player"])
	SetLootThreshold(4)

	raidMembers = GetHomePartyInfo()

	for i=0, raidMembers.getn()
	do
		valueTable.raidMembers[i] =
		{
			name = raidMembers[i],
			value = value + 50;
		}
	end

	valueTable.overallPresence = valueTable.overallPresence + 50

end

function LootCouncil:EndRaid()

	-- Store participation time and total time.
	raidMembers = GetHomePartyInfo()

	for i=0, raidMembers.getn()
	do
		valueTable.raidMembers[i] =
		{
			name = raidMembers[i],
			value = value + 50;
		}
	end

	valueTable.overallPresence = valueTable.overallPresence + 50

end

function LootCouncil:OnEnable()
	 mainWindow:SetDisabled(false)
end

function LootCouncil:OnDisable()
	-- Lots of Kappa
	-- Never Disable
	mainWindow:SetDisabled(true)
end


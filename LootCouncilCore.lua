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
local function DrawViewGroup(container)
	local desc = AceGUI:Create("Label")

	desc:SetText("View")
	desc:SetFullWidth(true)
	container:AddChild(desc)


end

local function DrawUpdateGroup(container)

	local toBeUpdated
	local amount

	--Tab Label
	local desc = AceGUI:Create("Label")
	desc:SetText("Update")
	desc:SetFullWidth(true)
	container:AddChild(desc)

	--Name Enter Box
	local nameBox = AceGUI:Create("EditBox")
	nameBox:SetLabel("Enter name of Raider in system: ")
	nameBox:SetWidth(200)
	nameBox:SetCallback("OnEnterPressed", function(widget, event, text) toBeUpdated = text end)
	container:AddChild(nameBox)

	local amountBox = AceGUI:Create("EditBox")
	amountBox:SetLabel("Amount:")
	amountBox:SetWidth(200)
	amountBox:SetNumeric(true)
	amountBox:SetNumber(0)
	amountBox:SetCallback("OnEnterPressed", function(widget, event, number) amount = number end)
	container:AddChild(amountBox)

	local addButton = AceGUI:Create("Button")
	addButton:SetWidth(50)
	addButton:SetText("+")
	addButton:SetCallback("OnClick", AddPointsToMember(toBeUpdated, amount))
	container:AddChild(addButton)

	local subButton = AceGUI:Create("Button")
	addButton:SetWidth(50)
	addButton:SetText("-")
	addButton:SetCallback("OnClick", SubPointsFromMember(toBeUpdated, amount))
	container:AddChild(addButton)


end

local function AddPointsToMember(member, amount)
	-- Add points to the raid member's total
end

local function SubPointsFromMember(member, amount)
	-- Subtract points from the raid member's total
end

local function DrawRaidGroup(container)
	local desc = AceGUI:Create("Label")

	local awardName
	local awardAmount


	desc:SetText("Raid")
	desc:SetFullWidth(true)
	container:AddChild(desc)

	local raidStartButton = AceGUI:Create("Button")
	raidStartButton:SetWidth(200)
	raidStartButton:SetText("Start Raid")
	raidStartButton:SetCallback("OnClick", StartRaid(raidStartButton))

	local raidEndButton = AceGUI:Create("Button")
	raidEndButton:SetWidth(200)
	raidEndButton:SetText("End Raid")
	raidEndButton:SetCallback("OnClick", EndRaid(raidStartButton))

	local mvpName = AceGUI:Create("Dropdown")
	mvpName:SetWidth(200)
	mvpName:SetLabel("MVP Name:")
	mvpName:SetList(GetHomePartyInfo())
	mvpName:SetCallback("OnValueChanged", NameEnter(widget, event, key, awardAmount))
	container:AddChild(mvpName)

	local mvpAmount = AceGUI:Create("EditBox")
	mvpAmount:SetWidth(200)
	mvpAmount:SetLabel("MVP Amount: ")
	mvpAmount:SetNumeric(true)
	mvpAmount:SetNumber(0))
	mvpAmount:SetCallback("OnEnterPressed", AmountEnter(mvpAmount, event, number, awardName))
	container:AddChild(mvpAmount)

	local mvpButton = AceGUI:Create("Button")
	mvpButton:SetWidth(200)
	mvpButton:SetText("Award MVP")
	mvpButton:SetDisabled(true)
	mvpButton:SetCallback("OnClick", AwardPoints(awardName, awardAmount))
	container:AddChild(mvpButton)

	local function AmountEnter(widget, event, number, name)
		awardAmount = number
		if name ~= nil then
			mvpButton:SetDisabled(false)
	end

	local function NameEnter(widget, event, key, awardAmount)
		awardName = key
		if awardAmount ~= nil then
			mvpButton:SetDisabled(false)
	end

	local function AwardPoints(name, points)
		--Award the MVP "points" to "name"

		--Disable the Button until a fresh entry has been made
		mvpButton:SetDisabled(true)
	end


	container:AddChild(raidStartButton)
	container:AddChild(raidEndButton)
end




local function SelectTab(container, event, group)

	container:ReleaseChildren()
	if group == "viewTab" then
		DrawViewGroup(container)
	elseif group == "raidTab" then
		DrawRaidGroup(container)
	elseif group == "updateTab" then
		DrawUpdateGroup(container)
	end
end

function LootCouncil:OnInitialize()

	mainWindow = AceGUI:Create("Frame")
	mainWindow:SetTitle("Loot Council")
	mainWindow:SetStatusText("Loot Council Main Window")
	mainWindow:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	mainWindow:SetLayout("Fill")

	local tab = AceGUI:Create("TabGroup")
	tab:SetLayout("Flow")
	tab:SetTabs({{text="View", value="viewTab"}, {text="Raid", value = "raidTab"}, {text="Update", value = "updateTab"}})
	tab:SetCallback("OnGroupSelected", SelectGroup)
	tab:SelectTab("View")

	mainWindow:AddChild(tab)


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

function LootCouncil:StartRaid(widget)
	-- Set Initial Raid Members


	widget:SetDisabled(true)



end

function LootCouncil:EndRaid(widget)

	-- Store participation time and total time.

	valueTable.overallPresence = valueTable.overallPresence + 50

	widget:SetDisabled(true)

end

function LootCouncil:OnEnable()
	 --mainWindow:SetDisabled(false)
end

function LootCouncil:OnDisable()
	-- Lots of Kappa
	-- Never Disable
	--mainWindow:SetDisabled(true)
end


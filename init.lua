gPlugin          = nil;
gConfig          = nil;
gCollectionClass = nil;

function Initialize(aPlugin)
	aPlugin:SetName("TinyWoodCutter")
	aPlugin:SetVersion(1)
	gPlugin = aPlugin

	LoadSettings()

	math.randomseed(os.time())

	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, OnPlayerBreakingBlock)

	LOG("Initialised " .. aPlugin:GetName() .. " v." .. aPlugin:GetVersion())
	return true
end

function OnDisable()
	LOG(gPlugin:GetName() .. "  v" .. gPlugin:GetVersion() .. " was disabled")
end
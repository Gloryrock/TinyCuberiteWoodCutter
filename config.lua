gConfigDefaults = 
[[
AxeRequired      = false,
Collection       = "pickups",
SurvivalOnly     = false,
ReplantSapling   = true,
SaplingPlantTime = 25,
ReplantSaplingRate = 0.2,
]]

function LoadDefaultSettings()
	gConfig = loadstring("return {" .. gConfigDefaults .. "}")()
	LoadItemCollection()
end

function LoadItemCollection()
	if (type(gConfig.Collection) ~= 'string') then
		LOGWARNING(gPlugin:GetName() .. " The item collection is malformed. \"pickups\" will be used.")
		gConfig.Collection = "pickups"
	end

	local CollType = gConfig.Collection:lower()
	if (CollType == 'pickups') then
		gCollectionClass = cPickupCollection
	elseif (CollType == "instantinventory") then
		gCollectionClass = cToInventoryCollection
	else
		LOGWARNING(gPlugin:GetName() .. " item collector \"" .. CollType .. "\" is unknown. \"pickups\" will be used.")
		gCollectionClass = cPickupCollection
	end
end

function LoadSettings()
	local Path = gPlugin:GetLocalFolder() .. "/config.cfg"
	if (not cFile:IsFile(Path)) then
		LOGWARNING(gPlugin:GetName() .. " The config file doesn't exist. TreeAssist will use the default settings for now")
		LoadDefaultSettings()
		return
	end

	local ConfigContent = cFile:ReadWholeFile(Path)
	if (ConfigContent == "") then
		LOGWARNING(gPlugin:GetName() .. " The config file is empty. TreeAssist will use the default settings for now")
		LoadDefaultSettings()
		return
	end

	local ConfigLoader, Error  = loadstring("return {" .. ConfigContent .. "}")
	if (not ConfigLoader) then
		LOGWARNING(gPlugin:GetName() .. " There is a problem in the config file. TreeAssist will use the default settings for now.")
		LoadDefaultSettings()
		return
	end

	local Result, ConfigTable, Error = pcall(ConfigLoader)
	if (not Result) then
		LOGWARNING(gPlugin:GetName() .. " There is a problem in the config file. TreeAssist will use the default settings for now.")
		LoadDefaultSettings()
		return
	end

	if (ConfigTable.ReplantSapling and (type(ConfigTable.SaplingPlantTime) ~= 'number')) then
		LOGWARNING(gPlugin:GetName() .. " ReplantSapling is activated, but there is no time set. TreeAssist will use the default time (20 ticks)")
		ConfigTable.SaplingPlantTime = 20
	end

	gConfig = ConfigTable

	LoadItemCollection()
end
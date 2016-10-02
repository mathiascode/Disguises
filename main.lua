DisguiseFor = {}

function Initialize(Plugin)
	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")

	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(g_PluginInfo.Version)

	cPluginManager:AddHook(cPluginManager.HOOK_WORLD_TICK, OnWorldTick)
	cPluginManager:AddHook(cPluginManager.HOOK_ENTITY_CHANGING_WORLD, OnEntityChangingWorld)
	cPluginManager:AddHook(cPluginManager.HOOK_TAKE_DAMAGE, OnTakeDamage)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICKING_ENTITY, OnPlayerRightClickingEntity)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_SPAWNED, OnPlayerSpawned)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_DESTROYED, OnPlayerDestroyed)

	RegisterPluginInfoCommands()

	LOG("Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end

function DestroyDisguise(Player)
	Player:GetWorld():DoWithEntityByID(DisguiseFor[Player:GetUUID()], cEntity.Destroy)
	DisguiseFor[Player:GetUUID()] = nil
	Player:SetVisible(true)
end

function OnDisable()
	local RemoveMob = function(Player)
		if DisguiseFor[Player:GetUUID()] ~= nil then
			DestroyDisguise(Player)
			Player:SendMessageInfo("You have been undisguised due to server reload")
		end
	end    
	cRoot:Get():ForEachPlayer(RemoveMob)
	LOG("Disabled " .. cPluginManager:GetCurrentPlugin():GetName() .. "!")
end

mobid = {}

function Initialize(Plugin)
        
	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")

	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(g_PluginInfo.Version)

	cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK, OnWorldTick)
	cPluginManager:AddHook(cPluginManager.HOOK_TAKE_DAMAGE, OnTakeDamage);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_DESTROYED, OnPlayerDestroyed);

	RegisterPluginInfoCommands();

	LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end

function OnDisable()
	local RemoveMob = function(Player)
		if mobid[Player:GetName()] ~= nil then
			Player:GetWorld():DoWithEntityByID(mobid[Player:GetName()], cEntity.Destroy)
			Player:SendMessageWarning("You've been undisguised because of server restart/reload")
			Player:SetVisible(true)
		end
	end    
	cRoot:Get():ForEachPlayer(RemoveMob)
end

mobid = {}

function Initialize(Plugin)
	Plugin:SetName("DisguiseCraft")
	Plugin:SetVersion(0.1)

	cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK, OnWorldTick)
	cPluginManager:AddHook(cPluginManager.HOOK_TAKE_DAMAGE, OnTakeDamage);	
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_DESTROYED, OnPlayerDestroyed);		
	cPluginManager.BindCommand("/d",      "disguisecraft.disguise", HandleDisguiseCommand, "- Disguise as a mob");
	cPluginManager.BindCommand("/ud",      "disguisecraft.undisguise", HandleUnDisguiseCommand, "- Undisguise");

	LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end

function OnDisable()
	local RemoveMob = function(Player)
		if mobid[Player:GetName()] ~= nil then
			Player:GetWorld():DoWithEntityByID(mobid[Player:GetName()], cEntity.Destroy)
			Player:SendMessageWarning(" You've been undisguised because of server restart/reload")
			Player:SetVisible(true)
		end
	end    
	cRoot:Get():ForEachPlayer(RemoveMob)
end    


        

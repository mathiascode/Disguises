mobid = {}

function Initialize(Plugin)
	Plugin:SetName("DisguiseCraft")
	Plugin:SetVersion(0)

	cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK, OnWorldTick)
	cPluginManager:AddHook(cPluginManager.HOOK_TAKE_DAMAGE, OnTakeDamage);	
    cPluginManager.BindCommand("/d",      "disguisecraft.disguise", HandleDisguiseCommand, "- Disguise as a mob");
    cPluginManager.BindCommand("/ud",      "disguisecraft.undisguise", HandleUnDisguiseCommand, "- Undisguise");

	LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end




function OnWorldTick(World, TimeDelta)
    local MoveMob = function(Entity)
        local Monster = tolua.cast(Entity,"cMonster")
        Monster:SetPosition(PlayerID:GetPosX(), PlayerID:GetPosY(), PlayerID:GetPosZ())
        Monster:MoveToPosition(PlayerID:GetPosition() + PlayerID:GetLookVector())
    end
    local Player = function(Player)
        PlayerID = Player
        local entityId = mobid[Player:GetName()];
        if entityId ~= nil then
            World:DoWithEntityByID(mobid[Player:GetName()], MoveMob)
        end
    end
    World:ForEachPlayer(Player)
end

function HandleDisguiseCommand(Split, Player)
    if Split[2] == nil then
        Player:SendMessageInfo("Usage: /d [mobtype]")
    else
        Mob = cMonster:StringToMobType(Split[2])
        if Mob == mtInvalidType then
            Player:SendMessageFailure("Invalid mob type")
        else
            Player:SetVisible(false)
            mobid[Player:GetName()] = Player:GetWorld():SpawnMob(Player:GetPosX(), Player:GetPosY(), Player:GetPosZ(), Mob)
        end
    end
    return true
end

function HandleUnDisguiseCommand(Split, Player)
    Player:SetVisible(true)
    local Delete = function(Entity)
        Entity:Destroy()
    end
    Player:GetWorld():DoWithEntityByID(mobid[Player:GetName()], Delete)
    mobid[Player:GetName()] = nil
    return true
end
             
             
function OnTakeDamage(Receiver, TDI)
    if TDI.Attacker == nil then
        return false
    elseif Receiver:IsPlayer() and TDI.Attacker:IsMob() then
        Player = tolua.cast(Receiver,"cPlayer")
        Mob = tolua.cast(TDI.Attacker, "cMonster")
        if Mob:GetUniqueID() == mobid[Player:GetName()] then
            return true
        end
    elseif Receiver:IsMob() and TDI.Attacker:IsPlayer() then
        Mob = tolua.cast(Receiver, "cMonster")
        Player = tolua.cast(TDI.Attacker, "cPlayer")    
        if Mob:GetUniqueID() == mobid[Player:GetName()] then
            return true
        end
    end
end    
                 

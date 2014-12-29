mobid = {}
timer = {}

function Initialize(Plugin)
	Plugin:SetName("DisguiseCraft")
	Plugin:SetVersion(0)

	cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK, OnWorldTick)
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
        World:DoWithEntityByID(mobid[Player:GetName()], MoveMob)
    end
    World:ForEachPlayer(Player)
end

function HandleDisguiseCommand(Split, Player)
    if Split[2] == nil then
        Player:SendMessageInfo("Usage: /d [mobtype]")
    else
        Mob = cMonster:StringToMobType(Split[2])
        print(Mob)
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
             

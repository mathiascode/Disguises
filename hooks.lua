function OnWorldTick(World, TimeDelta)
	local MoveMob = function(Entity)
		local Monster = tolua.cast(Entity,"cMonster")
		Monster:TeleportToCoords(PlayerID:GetPosX() + 1, PlayerID:GetPosY(), PlayerID:GetPosZ() + 1)
		Monster:SetSpeed(0,0,0)
		Monster:SetMaxHealth(99999)
		Monster:SetHealth(99999)
	end
	local Player = function(Player)
		PlayerID = Player
		local entityId = mobid[Player:GetName()];
		if entityId ~= nil then
			World:DoWithEntityByID(mobid[Player:GetName()], MoveMob)
		end
		if Player:IsVisible() == true and entityId ~= nil then
			Player:SendMessageInfo("You have been undisguised due to your visibility being set to true")
			World:DoWithEntityByID(mobid[Player:GetName()], cEntity.Destroy)
			mobid[Player:GetName()] = nil
		end
	end
	World:ForEachPlayer(Player)
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

function OnPlayerSpawned(Player)
	if mobid[Player:GetName()] ~= nil then
		Player:SetVisible(false)
	end
end

function OnPlayerDestroyed(Player)
	if mobid[Player:GetName()] ~= nil then
		Player:GetWorld():DoWithEntityByID(mobid[Player:GetName()], cEntity.Destroy)
		Player:SetVisible(true)
		mobid[Player:GetName()] = nil
	end
end

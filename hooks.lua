function OnWorldTick(World, TimeDelta)
	local MoveMob = function(Entity)
		local Monster = tolua.cast(Entity,"cMonster")
		Monster:TeleportToCoords(PlayerID:GetPosX(), PlayerID:GetPosY(), PlayerID:GetPosZ())
		Monster:MoveToPosition(PlayerID:GetPosition() + PlayerID:GetLookVector())
		if Monster:GetHealth() == 0 then
			PlayerID:SendMessageInfo("Your mob is dead, you've been undisguised")
			PlayerID:SetVisible(true)
			Monster:Destroy()
			mobid[Player:GetName()] = nil
		end
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

function OnPlayerDestroyed(Player)
	if mobid[Player:GetName()] ~= nil then
		Player:GetWorld():DoWithEntityByID(mobid[Player:GetName()], cEntity.Destroy)
		Player:SetVisible(true)
	end
end    

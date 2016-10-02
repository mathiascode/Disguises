function OnWorldTick(World, TimeDelta)
	local Player = function(Player)
		local MoveEntity = function(Entity)
			if Entity:IsMob() and Entity:GetMobType() == 53 or Entity:IsMob() and Entity:GetMobType() == 56 then
				Entity:TeleportToCoords(Player:GetPosX() + 2.6, Player:GetPosY(), Player:GetPosZ() + 2.6)
			elseif Entity:GetEntityType() == 7 then
				Entity:TeleportToCoords(Player:GetPosX() + 1.2, Player:GetPosY(), Player:GetPosZ() + 1.2)
			else
				Entity:TeleportToCoords(Player:GetPosX() + 1.1, Player:GetPosY(), Player:GetPosZ() + 1.1)
			end
			Entity:SetSpeed(0,0,0)
			Entity:SetMaxHealth(99999)
			Entity:SetHealth(99999)
			Entity:SetHeadYaw(Player:GetHeadYaw())
			Entity:SetYaw(Player:GetYaw())
			Entity:SetPitch(Player:GetPitch())
			Player:SetVisible(false)
			Player:SetInvulnerableTicks(5)
			if Entity:GetPosY() < 0.1 then
					DisguiseFor[Player:GetUUID()] = nil
					Player:SetVisible(true)
					Player:SendMessageInfo("Your visibility has been set to true due to your disguise disappearing")
			end
		end
		if DisguiseFor[Player:GetUUID()] ~= nil then
			World:DoWithEntityByID(DisguiseFor[Player:GetUUID()], MoveEntity)
		end
	end
	World:ForEachPlayer(Player)
end

function OnEntityChangingWorld(Entity, World)
	local ChangeWorld = function(Disguise)
		Disguise:MoveToWorld(World)
	end
	if Entity:IsPlayer() and DisguiseFor[Entity:GetUUID()] ~= nil then
		Entity:GetWorld():DoWithEntityByID(DisguiseFor[Entity:GetUUID()], ChangeWorld)
	end
end

function OnTakeDamage(Receiver, TDI)
	if TDI.Attacker and TDI.Attacker:IsPlayer() and Receiver:GetUniqueID() == DisguiseFor[TDI.Attacker:GetUUID()] then
		return true
	end
end

function OnPlayerRightClickingEntity(Player, Entity)
	if Entity:GetUniqueID() == DisguiseFor[Player:GetUUID()] then
		return true
	end
end

function OnPlayerSpawned(Player)
	if DisguiseFor[Player:GetUUID()] ~= nil then
		DestroyDisguise(Player)
		Player:SendMessageInfo("You have been undisguised due to respawning")
	end
end

function OnPlayerDestroyed(Player)
	if DisguiseFor[Player:GetUUID()] ~= nil then
		DestroyDisguise(Player)
	end
end

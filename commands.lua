function HandleDisguiseCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: "..Split[1].." <mobtype[:baby]> [customname ...]")
		Player:SendMessageInfo("Available types: arrow, bat, blaze, boat, cavespider, chicken, cow, creeper, egg, enderdragon, enderman, enderpearl, expbottle, fireball, firecharge, ghast, giant, guardian, horse, irongolem, magmacube, minecart, minecartchest, minecartfurnace, minecarthopper, minecarttnt, mooshroom, ocelot, pig, rabbit, sheep, silverfish, skeleton, slime, snowball, snowgolem, spider, splashpotion, squid, villager, witch, wither, witherskull, wolf, zombie, zombiepigman")
	else
		local IsBaby = false
		local EntityString = string.lower(Split[2])

		if string.find(EntityString, ":") then
			EntityString, data = string.match(EntityString, "(%w+):(%w+)")
			if data == "baby" then
				IsBaby = true
			end
		end

		local MobType = cMonster:StringToMobType(EntityString)
		local World = Player:GetWorld()
		local X = Player:GetPosX() + 1.1
		local Y = Player:GetPosY()
		local Z = Player:GetPosZ() + 1.1
		local Origin = Player:GetEquippedItem()
		local Speed = Vector3d():Move(0, 0, 0)

		if MobType ~= mtInvalidType or EntityString == "arrow" or EntityString == "boat" or EntityString == "egg" or EntityString == "enderpearl" or EntityString == "expbottle" or EntityString == "fireball" or EntityString == "firecharge" or EntityString == "minecart" or EntityString == "minecartchest" or EntityString == "minecartfurnace" or EntityString == "minecarthopper" or EntityString == "minecarttnt" or EntityString == "snowball" or EntityString == "splashpotion" or EntityString == "witherskull" then 
			if DisguiseFor[Player:GetUUID()] ~= nil then
				Player:GetWorld():DoWithEntityByID(DisguiseFor[Player:GetUUID()], cEntity.Destroy)
			end
		end

		if EntityString == "arrow" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 60, Player, Origin, Speed)
		elseif EntityString == "boat" then
			DisguiseFor[Player:GetUUID()] = World:SpawnBoat(X + 0.1, Y, Z + 0.1)
		elseif EntityString == "egg" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 62, Player, Origin, Speed)
		elseif EntityString == "enderpearl" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 65, Player, Origin, Speed)
		elseif EntityString == "expbottle" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 75, Player, Origin, Speed)
		elseif EntityString == "fireball" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 63, Player, Origin, Speed)
		elseif EntityString == "firecharge" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 64, Player, Origin, Speed)
		elseif EntityString == "giant" or EntityString == "ghast" then
			DisguiseFor[Player:GetUUID()] = World:SpawnMob(X + 1.5, Y, Z + 1.5, MobType, IsBaby)
		elseif EntityString == "minecart" then
			DisguiseFor[Player:GetUUID()] = World:SpawnMinecart(X, Y, Z, 328)
		elseif EntityString == "minecartchest" then
			DisguiseFor[Player:GetUUID()] = World:SpawnMinecart(X, Y, Z, 342)
		elseif EntityString == "minecartfurnace" then
			DisguiseFor[Player:GetUUID()] = World:SpawnMinecart(X, Y, Z, 343)
		elseif EntityString == "minecarthopper" then
			DisguiseFor[Player:GetUUID()] = World:SpawnMinecart(X, Y, Z, 408)
		elseif EntityString == "minecarttnt" then
			DisguiseFor[Player:GetUUID()] = World:SpawnMinecart(X, Y, Z, 407)
		elseif EntityString == "snowball" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 61, Player, Origin, Speed)
		elseif EntityString == "splashpotion" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 73, Player, Origin, Speed)
		elseif EntityString == "witherskull" then
			DisguiseFor[Player:GetUUID()] = World:CreateProjectile(X, Y, Z, 66, Player, Origin, Speed)
		elseif MobType ~= mtInvalidType then
			DisguiseFor[Player:GetUUID()] = World:SpawnMob(X, Y, Z, MobType, IsBaby)
		else
			Player:SendMessageFailure("Invalid disguise type \"" .. Split[2] .. "\"")
			return true
		end

		if MobType ~= mtInvalidType then
			Player:GetWorld():DoWithEntityByID(
				DisguiseFor[Player:GetUUID()],
				function(Entity)
					Entity:SetCustomName(table.concat( Split , " " , 3 ))
				end
			)
		end

		local StartsWith = string.sub(EntityString, 1, 1)
		if StartsWith == "e" or StartsWith == "i" or StartsWith == "o" then
			Player:SendMessageSuccess("You have been disguised as an " .. EntityString)
		else
			Player:SendMessageSuccess("You have been disguised as a " .. EntityString)
		end
	end
	return true
end

function HandleUnDisguiseCommand(Split, Player)
	if DisguiseFor[Player:GetUUID()] ~= nil then
		DestroyDisguise(Player)
		Player:SendMessageSuccess("You have been undisguised")
	else   
		Player:SendMessageFailure("You are not disguised") 
	end    
	return true
end

function HandleDisguiseCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: "..Split[1].." <mobtype[:baby]> [customname ...]")
		Player:SendMessageInfo("Available types: bat, blaze, cavespider, chicken, cow, creeper, enderdragon, enderman, ghast, giant, guardian, horse, irongolem, magmacube, mooshroom, ocelot, pig, rabbit, sheep, silverfish, skeleton, slime, snowgolem, spider, squid, villager, witch, wither, wolf, zombie, zombiepigman")
	else
		IsBaby = false
		MobString = Split[2]
		
		if string.find(MobString, ":") then
			MobString, data = string.match(MobString, "(%w+):(%w+)")
			if data == "baby" then
				IsBaby = true
			end
		end

		MobType = cMonster:StringToMobType(MobString)

		if MobType == mtInvalidType then
			Player:SendMessageFailure("That disguise type was not recognized")
		else
			if mobid[Player:GetName()] ~= nil then
				HandleUnDisguiseCommand(Split, Player)
			end    
			Player:SetVisible(false)
			mobid[Player:GetName()] = Player:GetWorld():SpawnMob(Player:GetPosX(), Player:GetPosY(), Player:GetPosZ(), MobType, IsBaby)

			Player:GetWorld():DoWithEntityByID(
				mobid[Player:GetName()],
				function(MobFunctions)
					SetMobFunction = tolua.cast(MobFunctions, "cMonster")
					SetMobFunction:SetMaxHealth(999999)
					SetMobFunction:SetHealth(999999)
					SetMobFunction:SetCustomName(table.concat( Split , " " , 3 ))
				end
			)

			StartsWith = string.sub(MobString, 1, 1)
			if StartsWith == "e" or StartsWith == "i" or StartsWith == "o" or StartsWith == "E" or StartsWith == "I" or StartsWith == "O" then
				Player:SendMessageSuccess("You have been disguised as an "..string.lower(MobString))
			else
				Player:SendMessageSuccess("You have been disguised as a "..string.lower(MobString))
			end
		end
	end
	return true
end

function HandleUnDisguiseCommand(Split, Player)
	if mobid[Player:GetName()] ~= nil then
		Player:SetVisible(true)
		Player:GetWorld():DoWithEntityByID(mobid[Player:GetName()], cEntity.Destroy)
		mobid[Player:GetName()] = nil
		Player:SendMessageSuccess("You have been undisguised")
	else   
		Player:SendMessageFailure("You're not disguised") 
	end    
	return true
end

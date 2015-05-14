function HandleDisguiseCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: "..Split[1].." [mobtype]")
	else
		Mob = cMonster:StringToMobType(Split[2])
		if Mob == mtInvalidType then
			Player:SendMessageFailure("Invalid mob type")
		else
			if mobid[Player:GetName()] ~= nil then
				HandleUnDisguiseCommand(Split, Player)
			end    
			Player:SetVisible(false)
			mobid[Player:GetName()] = Player:GetWorld():SpawnMob(Player:GetPosX(), Player:GetPosY(), Player:GetPosZ(), Mob)
			Player:SendMessageInfo("You have been disguised as a "..Split[2])
		end
	end
	return true
end

function HandleUnDisguiseCommand(Split, Player)
	if mobid[Player:GetName()] ~= nil then
		Player:SetVisible(true)
		Player:GetWorld():DoWithEntityByID(mobid[Player:GetName()], cEntity.Destroy)
		mobid[Player:GetName()] = nil
		Player:SendMessageInfo("You have been undisguised")
	else   
		Player:SendMessageFailure(cChatColor.Yellow.."You're not disguised") 
	end    
	return true
end

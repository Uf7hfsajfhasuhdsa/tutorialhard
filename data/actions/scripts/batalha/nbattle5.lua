
local time = 10 -- tempo em segundos para usar
local monster = "Gaara Battle" -- "Monstro" entre aspas
local pos = {x=1820, y=616, z=9} -- Posição que irá nascer.
local from,to = {x=1807, y=605, z=9},{x=1844, y=626, z=9} -- area total da area onde o monstro vai estar

function CheckArea(area)
	local var = 0
	for x = area[1].x - 1, area[2].x + 1 do
		for y = area[1].y - 1, area[2].y + 1 do
			local pos = {x=x, y=y, z=area[1].z}
			local m = getTopCreature(pos).uid
			if m ~= 0 and isMonster(m) then 
				var = var +1 
			end
		end
	end
	return var
end
function onUse(cid, item, frompos, itemex, topos)
	if getStorage(3124) - os.time() < 1 then
		if CheckArea({from,to}) == 0 then
			doSetStorage(3124, os.time() + time)
			addEvent(function() doCreateMonster(monster, pos) end, 5000)
			doCreatureSay(cid, "Prepare-se !", TALKTYPE_MONSTER)
		else
			doPlayerSendCancel(cid, "Retire seus Kuchyose Para Iniciar uma Nova Batalha ( Kai ) !")
			doSendMagicEffect(getThingPos(cid), CONST_ME_POFF) return true
		end
	else
		doPlayerSendCancel(cid, "Voce precisa esperar ".. getStorage(3124) - os.time() .." Segundos restantes")
		doSendMagicEffect(getThingPos(cid), CONST_ME_POFF) return true
	end	
	doTransformItem(item.uid, item.itemid % 2 == 1 and item.itemid + 1 or item.itemid + -1) 
	return true
end
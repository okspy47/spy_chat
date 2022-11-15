local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vrp","vRP_chatroles")
vRPsp = Proxy.getInterface("vRP_sponsor")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:muitzaqmessageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')
RegisterServerEvent('chat:kickSpammer')
AddEventHandler('chat:kickSpammer', function()
	TriggerClientEvent('chatMessage', -1, "^1[SPAM] ^2"..vRP.getPlayerName({source}).."^8 a primit kick pentru spam!")
	DropPlayer(source, 'Ai fost dat afara pentru spam!')
end)

local disabled = false

RegisterServerEvent("disableChat")
AddEventHandler("disableChat", function()
	local user_id = vRP.getUserId({source})
	local name = vRP.getPlayerName({source})
	if user_id ~= nil then 
		if vRP.isUserAdmin({user_id}) then
			disabled = not disabled
			if disabled then
				TriggerClientEvent('chatMessage', -1, "^3".. name .." (".. user_id .. ") a dezactivat chat-ul.")
			else
				TriggerClientEvent('chatMessage', -1, "^3".. name .." (".. user_id .. ") a activat chat-ul.")
			end
		end
	end
end)

local emojis = {
	[1] = {':facepalm:',"🤦"},
	[2] = {':joy:',"😂"},
	[3] = {':fire:',"🔥"},
	[4] = {':snake:',"🐍"},
	[5] = {":heart:","❤️"},
	[6] = {":muie:","🖕"},
	[7] = {":nerd:","🤓"}
	
}


AddEventHandler('_chat:muitzaqmessageEntered', function(author, color, message)

    if not message or not author then
        return
	end
	
	local user_id = vRP.getUserId({source})

	if user_id ~= nil then

		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local isVip = vRP.getUserVipRank({user_id})
		local pName = vRP.getPlayerName({player})
		local factionrank = vRP.getFactionRank({user_id})
		local author = "["..user_id.."] "..author
		if user_id ~= nil then
			TriggerEvent('chatMessage', source, author, message)
			if disabled then
				if vRP.isUserAdmin({user_id}) then
					tag = "STAFF "
					rgb = {255, 0, 0}
					TriggerClientEvent('chatMessage', -1, tag.." " ..author, rgb, " " ..  message)
				else
					CancelEvent()
					TriggerClientEvent('chatMessage', source, "^3[GitHub] ^1Chat-ul este momentan dezactivat de catre un admin. Nu poti vorbi!")
				end
				print(author.." » ".. message)
				elseif not WasEventCanceled() and not disabled then

-- Zona Grade Chat
					if vRP.isUserOwner({user_id}) then
						tag = "[OWNER]"
						rgb = {255, 0, 0}
					elseif vRP.isUserCoFondator({user_id}) then
						tag = "[CO FONDATOR]"
						rgb = {255,0,0}
					elseif vRP.isUserManagerStaff({user_id}) then
						tag = "[HEAD OF STAFF]"
						rgb = {154,94,219}
					elseif vRP.isUserHeadofAdministrators({user_id}) then
						tag = "[HEAD OF ADMINISTRATORS]"
						rgb = {43,201,0}
					elseif vRP.isUserAdministrator({user_id}) then	
						tag = "[ADMINISTRATOR]"
						rgb = {255,165,0}
					
					elseif vRP.isUserMod({user_id}) then	
						tag = "[MODERATOR]"
						rgb = {0,188,254}
				
					elseif vRP.isUserHelper({user_id}) then	
						tag = "[HELPER]"
						rgb = {43,201,0}
					elseif vRP.isUserHelperinTeste({user_id}) then	
						tag = "[Helper in Teste]"
						rgb = {43,201,0}
					elseif (isVip == 1) then
						tag = "[Vip Bronze]"
						rgb = {202, 143, 7}
					elseif (isVip == 2) then
						tag = "[Vip Silver]"
						rgb = {120, 120, 120}
					elseif (isVip == 3) then
						tag = "[Vip Gold]"
						rgb = {255, 216, 0}
					elseif (isVip == 4) then
						tag = "[Vip Diamond]"
						rgb = {0, 182, 255}
					elseif (isVip == 5) then
						tag = "[Vip Supreme]"
						rgb = {255, 0, 0}
					elseif vRP.hasGroup({user_id, "youtuber"}) then
						tag = "[Youtuber]"
						rgb = {255, 0, 0}
					elseif vRP.isUserInFaction({user_id,"Politie"}) then
						tag = "[Politia Romana]"
						rgb = {0, 97, 255}
					elseif vRP.isUserInFaction({user_id,"Smurd"}) then
						tag = "[Medic]"
						rgb = {153, 0, 50}
					elseif(vRP.hasUserFaction({user_id}) == false)then
						tag = "[Civil]"
						rgb = {255, 255, 255}
					else
						tag = "[Civil]"
						rgb = {255, 255, 255}
					end
-- Zona Grade Chat
					if vRP.hasUserFaction({user_id}) then
						local faction = vRP.getUserFaction({user_id})
						TriggerClientEvent('chatMessage', -1, tag.."  ["..faction.."]  "..author, rgb, " " ..  message)
					else
						TriggerClientEvent('chatMessage', -1, tag.." "..author, rgb, " " ..  message)
					end

					if(user_id == 0)then
						author = "^9"..author
					elseif(user_id == 0)then
						author = "^9"..author	
					elseif(user_id == 0)then
						author = "^9"..author
					end
					
				print(author.." » ".. message)
			end
		end
	end
end)


RegisterCommand('guns', function(source)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.isUserCoFondator({user_id}) then --- Grad de acces la comanda, modifica dupa bunul plac.
      vRPclient.giveWeapons(player,{{
            --- Arme primite, vezi https://wiki.rage.mp/index.php?title=Weapons pentru coduri.
              ["weapon_appistol"] = {ammo=200},
              ["weapon_assaultrifle"] = {ammo=200},
              ["weapon_gadgetpistol"] = {ammo=100}
          }})
      vRPclient.notify(player, {"Ai primit armele dorite."})
    else 
      vRPclient.notify(player, {"~r~Nu ai acces la aceasta comanda."})
    end     
end)


RegisterCommand("food", function(source)
    local user_id = vRP.getUserId({source})
    if vRP.isUserCoFondator({user_id}) then --- Grad de acces la comanda, modifica dupa bunul plac.
        vRP.varyHunger({user_id, -100})
        vRP.varyThirst({user_id, -100})
        vRPclient.varyHealth(source, {100})
        vRPclient.notify(source,{"Esti full acum!"})
   else
    vRPclient.notify(source,{"~r~Nu ai acces la aceasta comanda!"})
        end
  end)
  

RegisterCommand("job", function(source,args)
    local user_id = vRP.getUserId({source})
    id = parseInt(args[1])
    if id ~= nil then
        player = vRP.getUserSource({id})
        local locdemunca = vRP.getUserGroupByType({user_id,"job"})
        if user_id ~= nil then
            vRPclient.notify(source,{ "Ai jobul de: ~g~"..locdemunca..""})
        else
            vRPclient.notify(source,{"Eroare!: Acest jucator trebuie sa fie online!"})
        end
    else
        vRPclient.notify(source,{"~r~Jucator invalid!"})
    end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = vRP.getPlayerName({source})

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local pName = vRP.getPlayerName({player})
		local author = "["..user_id.."] "..name
		message = "/"..command
    end

    CancelEvent()
end)

RegisterCommand('say', function(source, args, rawCommand)
	if(source == 0)then
		TriggerClientEvent('chatMessage', -1, "[Consola]", {60, 179, 113}, rawCommand:sub(5))
	else
		TriggerClientEvent("chatMessage", source, "^1[GitHub]: ^0Nu ai acces la aceasta comanda.")
	end
end)

RegisterCommand('stats', function(source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local banicash = vRP.getMoney({user_id})
    local nume = GetPlayerName(player)
    local banibanca = vRP.getBankMoney({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
   
	local VIP = vRP.getUserVipRank({user_id})
    local locdemunca = vRP.getUserFaction({user_id})
	local rows = exports.ghmattimysql:executeSync("SELECT warns FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	warns = rows[1].warns
    CancelEvent()
		TriggerClientEvent('chatMessage', player, "--------------------------------------------------------------------")
        TriggerClientEvent('chatMessage', player, "^0Nume: ^1"..nume.."^0 || ID: ^1"..user_id.."^0")
        TriggerClientEvent('chatMessage', player, "^0Factiune: ^1"..locdemunca.."^0 || VIP: ^1"..VIP.."^0 || Ore jucate: ^1"..orejucate.."^0 || Diamante: ^1"..aur)
		TriggerClientEvent('chatMessage', player, "--------------------------------------------------------------------")
end)

RegisterCommand('ore', function(source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
    CancelEvent()
		TriggerClientEvent('chatMessage', player, "^3SMOKERP: ^0Tu ai ^3".. orejucate .." ^0ore")
end)


RegisterCommand("nc", function(player)
    local user_id = vRP.getUserId({player})
	if vRP.isUserHelper({user_id}) then
        vRPclient.toggleNoclip(player, {})
		local embed = {
		{
			["color"] = "15158332",
			["type"] = "rich",
			["title"] = "Noclip",
			["description"] = "**Noclip: ** " .. vRP.getPlayerName({player}) ..  " a folosit comanda /nc",
			["footer"] = {
			["text"] = "</>Neo vRP Hub"
			}
		}
	  }
	
	PerformHttpRequest('https://discord.com/api/webhooks/855090528248660028/cCPJa4rsneb2duiFxlZRkNDijlf4cC3M5y_dHE77g-XM9Fkpw_hL-KdM2470hCMIENaL', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
    else
        TriggerClientEvent("chatMessage", source, "^1[Eroare]: ^0Nu ai acces la aceasta comanda")
    end
end)

RegisterCommand("respawn", function(player, args)
    local user_id = vRP.getUserId({player})
    if vRP.isUserHelper({user_id}) then
        local target_id = parseInt(args[1])
        local target_src = vRP.getUserSource({target_id})
        if target_src then
            vRPclient.varyHealth(target_src,{100})
            vRP.varyHunger({target_src,-100})
            vRP.varyThirst({target_src,-100})
			vRPclient.teleport(target_src, {-146.67811584473,6297.4604492188,31.48952293396}) -- locatie de respawn
			local users = vRP.getUsers({})
			for uID, ply in pairs(users) do
				if vRP.isUserHelper({uID}) then
					TriggerClientEvent('chatMessage', ply,"^1[GitHub]: ^0Admin-ul ^3"..vRP.getPlayerName({player}).."^0 i-a dat respawn lui ^0[^3"..target_id.."^0]")
					local embed = {
					{
						["color"] = "15158332",
						["type"] = "rich",
						["title"] = "Respawn",
						["description"] = "**Respawn: **" .. vRP.getPlayerName({player}) ..  " i-a dat respawn lui " .. target_id .. "",
						["footer"] = {
						["text"] = "</>Neo vRP Hub"
						}
					}
				  }
				
				PerformHttpRequest('https://discord.com/api/webhooks/855091253708455948/UULWcfkoC1hOIv_8HhdFpYp0RxY2knoYEBpU8nVVP-R5X5JruNSJgSb9-YIrHhTIp2j9', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				end
			end
			vRPclient.notify(target_src, {"~g~Succes: ~w~Admin-ul ~r~"..vRP.getPlayerName({player}).." ["..user_id.."] ~w~ti-a dat respawn"})
        end
    end
end, false)

RegisterCommand("respawnall", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserOwner({user_id}) then
        local users = vRP.getUsers({})
        for k, v in pairs(users) do 
            Citizen.Wait(10)
            if v then
                vRPclient.teleport(v, {-146.67811584473,6297.4604492188,31.48952293396}) -- locatia de respawn
            end
        end
        TriggerClientEvent("chatMessage", -1, "^1[GitHub]: ^0Tot server-ul a primit respawn de la ^3"..GetPlayerName(player))
		local embed = {
		{
			["color"] = "15158332",
			["type"] = "rich",
			["title"] = "Respawn ALL",
			["description"] = "**Respawn: **" .. vRP.getPlayerName({player}) ..  " a dat respawn la tot server-ul",
			["footer"] = {
			["text"] = "</>Neo vRP Hub"
			}
		}
	  }
	
	PerformHttpRequest('https://discord.com/api/webhooks/855091253708455948/UULWcfkoC1hOIv_8HhdFpYp0RxY2knoYEBpU8nVVP-R5X5JruNSJgSb9-YIrHhTIp2j9', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
    else
        vRPclient.noAccess(player, {})
    end
end)

RegisterCommand("gotoevent", function(player)
    if eventOn then
        vRPclient.teleport(player, {evCoords[1], evCoords[2], evCoords[3]})
        TriggerClientEvent("zedutz:setFreeze", player, true)
    else
        TriggerClientEvent("chatMessage", player, "^1[Eroare]: ^0Nu exista nici un eveniment activ")
    end
end, false)

RegisterCommand('veh', function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserOwner({user_id}) then
	  BMclient.spawnVehicle(player,{args[1]})
	end
  end, false)

RegisterCommand("stopevent", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserCoOwner({user_id}) then
        if eventOn then
            evCoords = {}
            eventOn = false

            TriggerClientEvent("chatMessage", -1, "^1[GitHub]: ^0Event-ul a fost oprit")
			local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["title"] = "Stop Event",
				["description"] = "**Event: **Admin-ul " .. vRP.getPlayerName({player}) ..  " a oprit un eveniment",
				["footer"] = {
				["text"] = "</>Neo vRP Hub"
				}
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/845047930456244244/JeS7bs5Uy0AAJo0DK_UhGRNlNA9Uvt0KxQuo_2MAXwN1psCJ1VApzKkuZnXowHHZHmdq', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
        else
            TriggerClientEvent("chatMessage", player, "^1[Eroare]: ^0Nu exista nici un eveniment activ !")
        end
    else
        TriggerClientEvent("chatMessage", player, "^1[Eroare]: ^0Nu ai acces la aceasta comanda")
    end
end, false)


local function sendMsgToStaff(msg, user_id, staffOnline)
    local task = Task(staffOnline)
    local staffs = 0

    local users = vRP.getUsers({})
    for uID, ply in pairs(users) do
        if vRP.isUserHelper({user_id}) then
            TriggerClientEvent("chatMessage", ply, "^1[GitHub]: ^0Question ["..user_id.."]: "..msg)
            vRPclient.playSound(ply, {"HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING"})
            staffs = staffs + 1
        end
    end

    task({staffs})
end

local function getNrCifre(n)
    local cifs = 0
    while n ~= 0 do
        cifs = cifs + 1
        n = math.floor(n / 10)
    end
    
    return cifs
end

local questions = {}
local function autoDecremet(user_id)
    if questions[user_id] > 0 then
        questions[user_id] = questions[user_id] - 1
        Wait(1000)
        autoDecremet(user_id)
    else
        if questions[user_id] ~= -100 then
            TriggerClientEvent("chatMessage", vRP.getUserSource({user_id}), "^3>> (/n): ^6Din pacate nimeni nu ti-a raspuns la intrebare")
        end
        questions[user_id] = nil
    end
end

RegisterCommand("n", function(player, args, msg)
    local user_id = vRP.getUserId({player})
    if user_id then
        if not questions[user_id] then
            local question = msg:sub(3)
            if msg:len() > 5 then
                sendMsgToStaff(question, user_id, function(staffOnline)
                    if staffOnline then
                        TriggerClientEvent("chatMessage", player, "^3Intrebarea ta va fi revizuita de catre membrii staff-ului !")
                        questions[user_id] = 60
                        autoDecremet(user_id)
                    else
                        TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Nici un membru din staff nu este online")
                    end
                end)
            else
                TriggerClientEvent("chatMessage", player, "^7> ^1[GitHub]^0: /n <intrebare>")
            end
        else
            TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Ai pus deja o intrebare, asteapta ^5"..questions[user_id].." ^0secunde")
        end
    end
end)


RegisterCommand('level',function ( source )

	local level = vRP.getLevel({source})
	TriggerClientEvent("chatMessage", source , "Level-ul tau este : " .. level .. "")
end)

RegisterCommand("bonus",function(source,args)
	local user_id = vRP.getUserId({source})
	local pName = GetPlayerName(source)
	local suma = parseInt(args[1]) or 0
	if vRP.isUserOwner({user_id})then
		if suma > 0 then
			TriggerClientEvent('chatMessage',-1,"^1BONUS^0: ^0Adminul ^1"..pName.."^0 a oferit un bonus de ^2"..vRP.formatMoney({suma}).."$^0 la tot serverul!")
			local users = vRP.getUsers({})
			for k,v in pairs(users)do
				vRP.giveMoney({k,suma,"false"})
			end
		end
	end
end)
local ples_css = [[
	.div_rpg_stats{
		background-color: rgba(0,0,0,0.75);
		color: white;
		font-weight: bold;
		width: 500px;
		padding: 10px;
		margin: auto;
		margin-top: 150px;
		text-align: center;
		border-radius: 15px;
	}

	.strike {
		display: block;
		text-align: center;
		overflow: hidden;
		white-space: nowrap;
	}
	.strike > span {
		position: relative;
		display: inline-block;
	}
	.strike > span:before,
	.strike > span:after {
		content: "";
		position: absolute;
		top: 50%;
		width: 9999px;
		height: 1px;
		background: #f27515;
	}
	.strike > span:before {
		right: 100%;
		margin-right: 15px;
	}
	.strike > span:after {
		left: 100%;
		margin-left: 15px;
	}
]]
RegisterCommand("info",function(thePlayer,args)
	local user_id = vRP.getUserId({thePlayer})
	local isAdmin = vRP.isAdministrator({user_id})
	if isAdmin then
		local id = parseInt(args[1])
		if id ~= nil then
			exports.ghmattimysql:execute('SELECT * FROM `vrp_users` WHERE id = @uid',{["@uid"] = id},function(rows)
				if #rows > 0 then
					nume = rows[1].username
					last_login = rows[1].last_login
					aJailTime = rows[1].aJailTime
					aJailReason = rows[1].aJailReason
					adminLvl = rows[1].adminLvl
					vipLvl = rows[1].vipLvl

					diamonds = rows[1].diamonds
					walletMoney = rows[1].walletMoney
					bankMoney = rows[1].bankMoney
					hoursPlayed = rows[1].hoursPlayed
					faction = rows[1].faction
					factionRank = rows[1].factionRank
					if faction == "user" then 
						faction = "Civil"
					end
					local msg = ""
					msg = msg .. [[
						<div class="strike">
						   <span>STATS</span>
						</div><br/>
					]]
					msg = msg .. "ID: " .. id .. " | Nume: " .. nume .. " | Ore jucate: " .. hoursPlayed .. "<br/>"
					msg = msg .. "Diamante: " .. diamonds .. " | Bani Cash: " .. vRP.formatMoney({tonumber(walletMoney)}) .. "$ | Bani Bancar: " .. vRP.formatMoney({tonumber(bankMoney)}) .. "$<br/>"
					msg = msg .. "Factiune: " .. faction .. " | Rank Factiune: ".. factionRank.." | Admin Level: " .. adminLvl .. " <br/>"
					msg = msg .. "VIP Level: "..vipLvl.."  </br>"		
					msg = msg .. "Level: " .. lvl .. " | Experienta: " .. exp .. "/" .. need .. ""
					msg = msg .. [[
						<br/><br/><div class="strike">
						   <span>STATS</span>
						</div>
					]]
		
		
					vRPclient.setDiv(thePlayer, {"rpg_stats", ples_css, msg})
					vRP.request({thePlayer, "Inchide", 1000, function(player, ok)
					  vRPclient.removeDiv(thePlayer, {"rpg_stats"})
					end})
				else
					TriggerClientEvent('chatMessage',thePlayer,"^1[Eroare]: ^0Acest jucator nu a fost gasit in baza de date!")
				end
			end)
		else
			TriggerClientEvent('chatMessage',thePlayer,"^1[Sintaxa]: ^0/info <id>")
		end
	else
		TriggerClientEvent('chatMessage',thePlayer,"^1[Eroare]: ^0Nu ai acces la aceasta comanda!")
	end
end)


RegisterCommand("nr", function(player, args, msg)
    local user_id = vRP.getUserId({player})
    local target_id = parseInt(args[1])
    local response = msg:sub(4 + getNrCifre(target_id))
    if user_id then
        if vRP.isUserHelper({user_id}) then
            if target_id and response:len() > 0 then
                local target_source = vRP.getUserSource({target_id})
                if target_source then
                    if questions[target_id] then
                        TriggerClientEvent("chatMessage", target_source, "^3[GitHub]: ^0".. GetPlayerName(player) .. " ti-a raspuns la intrebare:")
                        TriggerClientEvent("chatMessage", target_source, "^3[GitHub]: ^0Raspuns: "..response)

                        local users = vRP.getUsers({})
                        for uID, ply in pairs(users) do
							if vRP.isUserHelper({user_id}) then
                                --TriggerClientEvent("chatMessage", ply, "^2Raspunsul dat la jucator este^0:^5 "..response)
                            end
                        end

                        questions[target_id] = -29
                    else
                        TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Acel jucator nu are o intrebare")
                    end
                else
                    TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Acel jucator nu mai este conectat")
                end
            else
                TriggerClientEvent("chatMessage", player, "^7>> ^1[Sintaxa]^0: /nr <User ID> <raspuns>")
            end
        else
            TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Nu ai acces la aceasta comanda")
        end
    end
end)

RegisterCommand("arevivearea", function(source,args)
	local user_id = vRP.getUserId({source})
	local src = vRP.getUserSource({user_id})
	local radius = args[1]
	local name = GetPlayerName(src)
	if vRP.isUserHelper({user_id}) then 
			vRPclient.getNearestPlayers(src,{tonumber(radius)}, function(nplayers)
				for k,v in pairs(nplayers) do 
					vRPclient.varyHealth(k,{100})
					vRPclient.notify(k,{"Ai primit revive de la adminul ~y~" .. name})
				end
			end)
			TriggerClientEvent("chatMessage",-1,"^3[GitHub]: ^0Adminul ^3" .. name ..  " ^0a dat revive pe o raza de " .. radius .. "m")
			local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["title"] = "Arevivearea",
				["description"] = "**Arevivearea: **" .. name ..  " a dat revive pe o raza de " .. radius .. "",
				["footer"] = {
				["text"] = "</>Neo vRP Hub"
				}
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/854463627776229407/lpgYAOT_tp5T-4ecCmJpA-CskBruyRSZ1qEPHRAEBcq9iEr5Gi3bdABS-OmUHQtAIx-G', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 

		else
		vRPclient.notify(src,{"~r~Eroare: ~w~Nu ai acces la aceasta comanda!"})
	end
end)



RegisterCommand('arevive', function(source, args, msg)
	local user_id = vRP.getUserId({source})
	msg = msg:sub(9)
	if msg:len() >= 1 then
	  msg = tonumber(msg)
	  local target = vRP.getUserSource({msg})
	  if target ~= nil then
		if vRP.isUserHelper({user_id}) then 
		  vRPclient.varyHealth(target,{100})
		  TriggerClientEvent('chatMessage', -1, "^4[GitHub]^7: Adminul ^4"..GetPlayerName(source).." ^7I-a dat revive lui "..GetPlayerName(target).."!")
		else
		  TriggerClientEvent('chatMessage', source, "^1[Eroare]^7: Nu deti acces-ul necesar pentru a folosi aceasta comanda.")
		end
	  else
		TriggerClientEvent('chatMessage', source, "^1[Eroare]^7: Player-ul nu este conectat.")
	  end
	else
	  TriggerClientEvent('chatMessage', source, "^1[Eroare]^7: /arevive <user-id>")
	end
  end)
------An ramas aici
RegisterCommand("startevent", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserOwner({user_id}) then
        if not eventOn then
            vRPclient.getPosition(player, {}, function(x, y, z)
                evCoords = {x, y, z + 0.5}
            end)
            eventOn = true
            TriggerClientEvent("chatMessage", -1, "^3[GitHub]: ^0Adminul ^3"..vRP.getPlayerName({player}).." ^0a pornit un eveniment!")
			TriggerClientEvent("chatMessage", -1, "^3[GitHub]: ^0Foloseste ^3/gotoevent ^0pentru a da tp acolo")
			local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["title"] = "Start Event",
				["description"] = "**Event: **Admin-ul " .. vRP.getPlayerName({player}) ..  " a pornit un eveniment",
				["footer"] = {
				["text"] = "</>Neo vRP Hub"
				}
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/855093514576592946/GAObCVgHAvuZdwb13kmwo9CgCTBrQrdlCRw1LKHIfKS4BqLQb7AnlJaFWqKlYs2KksSp', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
        end
    else
        TriggerClientEvent("chatMessage", player, "^1[Eroare]: ^0Nu ai acces la aceasta comanda")
    end
end, false)

RegisterCommand('clear', function(source)
    local user_id = vRP.getUserId({source});
    if user_id ~= nil then
        if vRP.isUserHelper({user_id}) then
            TriggerClientEvent("chat:clear", -1);
            TriggerClientEvent("chatMessage", -1, "^3[GitHub]: ^0Adminul ^3".. vRP.getPlayerName({source}) .."^0 a sters tot chat-ul.");
			local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["title"] = "Logs Clear",
				["description"] = "**Clear: **Admin-ul " .. vRP.getPlayerName({source}) ..  " a folost comanda /clear",
				["footer"] = {
				["text"] = "</>Neo vRP Hub"
				}
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/855094192493035540/nMU1KAxo4ZuvnyS_Zz_kES1X3QjmEJZajTgkn47gnQkYNU0l53krNpcLJvVtpen3CtAp', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
        else
            TriggerClientEvent("chatMessage", source, "^1[Eroare]^0: Nu ai acces la aceasta comanda.");
        end
    end
end)

local function giveAllBankMoney(amount, sphynx)  
    local users = vRP.getUsers({})
    for user_id, source in pairs(users) do
        if not sphynx then
			vRP.giveBankMoney({user_id, tonumber(amount)})
		end
    end
end

RegisterCommand("giveallmoney", function(player, args)
    if player == 0 then
        local theMoney = parseInt(args[1]) or 0
        if theMoney >= 1 then
            giveAllBankMoney(theMoney, false)
            TriggerClientEvent("chatMessage", -1, "^3[Eroare]: ^0Server-ul a oferit tuturor cetatenilor ^3"..vRP.formatMoney({theMoney}).." ^0(de) €.")
        else
            print("/giveallmoney <suma>")
        end
    else
        local user_id = vRP.getUserId({player})
        if vRP.isUserOwner({user_id}) then
            local theMoney = parseInt(args[1]) or 0
            if theMoney >= 1 then
                giveAllBankMoney(theMoney, false)
				TriggerClientEvent("chatMessage", -1, "^3[GitHub]: ^0Fondator-ul ^3"..vRP.getPlayerName({player}).."^0 a oferit tuturor jucatorilor ^3"..vRP.formatMoney({theMoney}).." ^0(de) €.")
            else
                TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: /giveallmoney <suma>")
            end
        else
            TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Nu ai acces la aceasta comanda")
        end
    end
end, false)

local function giveAllBankMoney(amount, sphynx)  
    local users = vRP.getUsers({})
    for user_id, source in pairs(users) do
        if not sphynx then
			vRP.giveKRCoins({user_id, tonumber(amount)})
		end
    end
end



RegisterCommand('a', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^1[Eroare]: ^0/"..rawCommand.." mesaj") 
		else
			if(vRP.isUserHelper({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserHelper({uID}) then
						TriggerClientEvent('chatMessage', ply, "^1[STAFF CHAT] ^0"..vRP.getPlayerName({source}).." ("..user_id..") » " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand('h', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^1[Eroare]: ^0/"..rawCommand.." mesaj") 
		else
			if(vRP.isAdministrator({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isAdministrator({uID}) then
						TriggerClientEvent('chatMessage', ply, "^4[HIGH STAFF] ^0"..vRP.getPlayerName({source}).." ("..user_id..") » " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand('f', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^1[Eroare]: ^0/"..rawCommand.." mesaj") 
		else
			if(vRP.isUserFondator({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserFondator({uID}) then
						TriggerClientEvent('chatMessage', ply, "^1[FOUNDERS CHAT] ^0"..vRP.getPlayerName({source}).." ("..user_id..") » " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand("aa2", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserHelper({user_id}) then
		vRPclient.teleport(player, {1701.1628417969,3249.810546875,40.968070983887})
	end
end, false)

RegisterCommand("serverdiscord",function( source )
		TriggerClientEvent('chatMessage', source, "Discord-ul serverului este ^3discord.gg/github") 
end)

RegisterCommand("tptome", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserHelper({user_id}) then
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local target_src = vRP.getUserSource({target_id})
			if target_src then
				vRPclient.getPosition(player, {}, function(x, y, z)
					vRPclient.teleport(target_src, {x, y, z})
					vRPclient.notify(player, {"~g~Succes: ~w~L-ai teleportat la tine pe "..vRP.getPlayerName({target_src}).." ["..target_id.."]"})
					vRPclient.notify(target_src, {"~g~Succes: ~w~Adminul "..vRP.getPlayerName({player}).." ["..user_id.."] te-a teleportat la el"})
					local embed = {
						{
						  ["color"] = 0xcf0000,
						  ["title"] = "".. "TpToMe".."",
						  ["description"] = "**TptoMe:** "..GetPlayerName(player).." i-a dat tp la el lui id "..target_id.."",
						  ["thumbnail"] = {
						  },
						  ["footer"] = {
						  ["text"] = "</>Neo vRP Hub",
						  },
						}
					  }
					  PerformHttpRequest('https://discord.com/api/webhooks/854463165671407627/F9oQKf6AzIvi_x2Bgc_D8Wmo3edeERpM7oGOxiVVXtw8jJ4k4FL7kbPxU0j16sg14rHc', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				end)
			else
				TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Jucatorul nu este conectat !")
			end
		else
			TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: /tptome <user_id>")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Nu ai acces la aceasta comanda !")
	end
end, false)

RegisterCommand("tpto", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserHelper({user_id}) then
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local target_src = vRP.getUserSource({target_id})
			if target_src then
				vRPclient.getPosition(target_src, {}, function(x, y, z)
					vRPclient.teleport(player, {x, y, z})
					vRPclient.notify(player, {"~g~Succes: ~w~Te-ai teleportat la "..vRP.getPlayerName({target_src}).." ["..target_id.."]"})
					vRPclient.notify(target_src, {"~g~Succes: ~w~Adminul "..vRP.getPlayerName({player}).." ["..user_id.."] s-a teleportat la tine"})
					local embed = {
						{
						  ["color"] = 0xcf0000,
						  ["title"] = "".. "TpTo".."",
						  ["description"] = "**Tpto:** "..GetPlayerName(player).." si-a dat tp la id "..target_id.."",
						  ["thumbnail"] = {
						  },
						  ["footer"] = {
						  ["text"] = "</>Neo vRP Hub",
						  },
						}
					  }
					  PerformHttpRequest('https://discord.com/api/webhooks/854461459722666014/nk1oiROMRQB9meB4aI87FDn1WppaproQUXLocP8p8N9ZpiHCvOeWk2829-mtRHAdSeNf', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				end)
			else
				TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Jucatorul nu este conectat !")
			end
		else
			TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: /tpto <user_id>")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Nu ai acces la aceasta comanda !")
	end
end, false)

RegisterCommand("tptow", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.isUserHelper({user_id}) then
		TriggerClientEvent("TpToWaypoint", player)
		local embed = {
			{
			  ["color"] = 0xcf0000,
			  ["title"] = "".. "TpToWaypoint".."",
			  ["description"] = "**TpToWaypoint:** "..GetPlayerName(player).." a folosit Tp To Waypoint",
			  ["thumbnail"] = {
			  },
			  ["footer"] = {
			  ["text"] = "</>Neo vRP Hub",
			  },
			}
		  }
		  PerformHttpRequest('https://discord.com/api/webhooks/854463329610367006/zv_R02xyXReCn7SDitAQvshr1OiaoITXmiPoh5r3RfyKLfTGh6EhHqxglX7P2QZrs23u', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
	else
		TriggerClientEvent("chatMessage", player, "^1[Eroare]^0: Nu ai acces la aceasta comanda !")
	end
end, false)

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_gps")

locatii = {
  ["[Spawn]"] = {-542.14282226562,-209.27868652344,37.649787902832},
  ["[Asigurare]"] = {-32.560409545898,-1110.9674072266,26.422374725342},
  ["[Showroom]"] = {-55.1921043396,-1107.8571777344,26.448907852173},
  ["[Sala de Forte]"] = {-1203.5948486328,-1565.8927001953,4.7516026496887},
  ["[Garaje VIP]"] = {32.682056427002,-1099.0487060547,29.453586578369},
  ["[Buletin]"] = {-543.28997802734,-216.52125549316,37.649780273438},
  ["[Crate System]"] = {-530.27398681641,-229.74563598633,36.703758239746},
  ["[Spital]"] = {290.53375244141,-591.57818603516,43.160572052002},
  ["[Sectia de Politie]"] = {440.81698608398,-981.89978027344,30.689504623413}
}

RegisterCommand("gps", function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local menu_gps = {}
    for k, v in pairs(locatii) do
      menu_gps[k] = {function(player, choice)
        vRPclient.setGPS(player, {v[1], v[2]})
        vRP.closeMenu({player})
      end, ""}
    end
    vRP.openMenu({player, menu_gps})
  end
end)

local anunturi = {
    "Orice job este profitabil , conteaza doar sa ai unul",
    "Daca esti pentru prima data pe server , mergi si fa-ti un buletin si ia un job !",
    "Suntem in cautare de medici, politie si staff , nu ezita sa aplici !"
	
}

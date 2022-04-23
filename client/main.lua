local QBCore = exports['qb-core']:GetCoreObject()

local training = false
local resting = false
local membership = false
local gotTicket = false
local minutes = 0
local seconds = 0



RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    FetchSkills()
    if Config.DeleteStats == true then
		while true do
			local seconds = Config.UpdateFrequency * 1000
			Wait(seconds)

			for skill, value in pairs(Config.Skills) do
				UpdateSkill(skill, value["RemoveAmount"])
			end

			TriggerServerEvent("qb-skills:update", json.encode(Config.Skills))
		end
	end
end)

local function round(num) 
    return math.floor(num+.5) 
end

function RefreshSkills()
    for type, value in pairs(Config.Skills) do
        if value["Stat"] then
            StatSetInt(value["Stat"], round(value["Current"]), true)
        end
    end
end

function FetchSkills()
    QBCore.Functions.TriggerCallback("qb-skills:fetchStatus", function(data)
		if data then
            for status, value in pairs(data) do
                if Config.Skills[status] then
                    Config.Skills[status]["Current"] = value["Current"]
                else
                  --  print("Removing: " .. status) 
                end
            end
		end
        RefreshSkills()
    end)
end


function UpdateSkill(skill, amount)

    if not Config.Skills[skill] then
       -- print("Skill " .. skill .. " doesn't exist")
        return
    end
    local SkillAmount = Config.Skills[skill]["Current"]
    if SkillAmount + tonumber(amount) < 0 then
        Config.Skills[skill]["Current"] = 0
    elseif SkillAmount + tonumber(amount) > 100 then
        Config.Skills[skill]["Current"] = 100
    else
        Config.Skills[skill]["Current"] = SkillAmount + tonumber(amount)
    end
    RefreshSkills()
    if tonumber(amount) > 0 then
        QBCore.Functions.Notify(skill .. ': + ' .. amount ..'%', 'success')
    end
	TriggerServerEvent("qb-skills:update", json.encode(Config.Skills))
end

local function CheckTraining()
	if resting == true then
        QBCore.Functions.Notify('You\'re resting', 'primary')
		resting = false
		Wait(15000)
		training = false
	end
	if resting == false then
        QBCore.Functions.Notify('You can now do exercise again', 'success')
	end
end

function buyMember()
    TriggerServerEvent('qb-gym:buyMembership')
    closeMenuFull()
end

function hasPlayerRunOutOfTime()
    return (minutes == 0 and seconds <= 1)
end

function playerBuyTicketMenu()
    exports['qb-menu']:openMenu({
        {
            header = "Gym Employee",
            isMenuHeader = true,
        },
        {
            header = "MemberShip Card $2500",
            txt = "Purchase",
			params = {
                event = "qb-gym:client:buyTicket",
                args = '1'
            }
        },
        {
            header = "Cancel",
			txt = "",
			params = {
                event = ""
            }
        },
    })
end

function returnTicketMenu()
    exports['qb-menu']:openMenu({
        {
            header = "Gym Employee",
            isMenuHeader = true,
        },
        {
            header = "Stop MemberShip",
			txt = "End MemberShip",
			params = {
                event = "qb-gym:client:returnTicket",
            }
        },
        {
            header = "Cancel",
			txt = "",
			params = {
                event = ""
            }
        },
    })
end
--------------------------------------------------------------------------------------------------------------------

function doesPlayerHaveTicket()
    return gotTicket
end

function countTime()
    seconds = seconds - 1
    if seconds == 0 then
        seconds = 59
        minutes = minutes - 1
    end

    if minutes == -1 then
        minutes = 0
        seconds = 0
    end
end

function displayTime()
    TriggerEvent('cd_drawtextui:ShowUI', 'show', "Gym MemberShip Time</br> "..minutes..":"..seconds)
end

RegisterNetEvent("qb-gym:client:openTicketMenu")
AddEventHandler("qb-gym:client:openTicketMenu", function()
    if gotTicket == false then
        playerBuyTicketMenu()
    else
        returnTicketMenu()
    end
end)

RegisterNetEvent('qb-gym:client:buyTicket')
AddEventHandler('qb-gym:client:buyTicket', function(args)
    local args = tonumber(args)
    if args == 1 then 
        TriggerServerEvent("qb-gym:server:buyTicket", 'gym_membership')
    else
        TriggerServerEvent("qb-gym:server:buyTicket", 'gym_membership')
    end
end)


RegisterNetEvent("qb-gym:clientticketResult")
AddEventHandler("qb-gym:clientticketResult", function(ticket)
    seconds = 1
    minutes = Config.ticketPrice[ticket].time
    gotTicket = true
    QBCore.Functions.Notify("MemberShip Time: "..Config.ticketPrice[ticket].time.." minutes", "primary")
end)

RegisterNetEvent('qb-gym:client:returnTicket')
AddEventHandler('qb-gym:client:returnTicket', function()
    minutes = 0
    seconds = 0 
    gotTicket = false
    QBCore.Functions.Notify("The Membership Card is no longer valid", "primary")
    TriggerEvent('cd_drawtextui:HideUI')
end)



local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

--count time
CreateThread(function()
    while true do
        Wait(1000)
        if gotTicket then
            if hasPlayerRunOutOfTime() then
                QBCore.Functions.Notify(".Your gym membership has expired")
                gotTicket = false
                SendNUIMessage({
                    type = "off",
                    game = "",
                })
                SetNuiFocus(false, false)
            end
            countTime()
            displayTime()
            if gotTicket == false then
                TriggerEvent('cd_drawtextui:HideUI')
            end
        end
    end
end)

CreateThread(function()
		while true do
			Wait(60000)
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
            
		if IsPedSwimmingUnderWater(ped) then
			UpdateSkill("Diving", 0.5)
		elseif IsPedShooting(ped) then
			UpdateSkill("Shooting", 0.1)
		elseif DoesEntityExist(vehicle) then
			local speed = GetEntitySpeed(vehicle) * 3.6

			if GetVehicleClass(vehicle) == 8 or GetVehicleClass(vehicle) == 13 and speed >= 5 then
				local rotation = GetEntityRotation(vehicle)
				if IsControlPressed(0, 210) then
					if rotation.x >= 25.0 then
						UpdateSkill("Raise front wheel", 0.5)
					end 
				end
			end
			if speed >= 140 then
				UpdateSkill("Driving", 0.1)
			end
		end
	end
end)

	
CreateThread(function()
	blip = AddBlipForCoord(Config.GymBlip)
	SetBlipSprite(blip, 311)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 7)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Gym')
	EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('qb-gym:trueMembership', function()
	membership = true
end)

RegisterNetEvent('qb-gym:falseMembership', function()
	membership = false
end)

CreateThread(function()
    while true do
        sleep = 1000
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
				for k, v in pairs(Config.Locations) do
					local dist = #(pos - vector3(Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z))
					if dist < 1.0 then		
						if dist < Config.Locations[k].viewDistance then
							sleep = 0
							DrawText3D(Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z, Config.Locations[k].Text3D)
							if IsControlJustReleased(0, 38) then
								if gotTicket then
									if training == false then
										TriggerServerEvent('qb-gym:checkChip')
										QBCore.Functions.Notify('Preparing exercise', 'success')
										Wait(1000)					
										if membership == true then
											SetEntityHeading(ped, Config.Locations[k].heading)
											SetEntityCoords(ped, Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z - 1)
											TaskStartScenarioInPlace(ped, Config.Locations[k].animation, 0, true)
											Wait(20000)
                                            for k, v in pairs(GetGamePool('CObject')) do
                                                if IsEntityAttachedToEntity(PlayerPedId(), v) then
                                                    SetEntityAsMissionEntity(v, true, true)
                                                    DeleteObject(v)
                                                    DeleteEntity(v)
                                                end
                                            end                                        
											ClearPedTasksImmediately(PlayerPedId())
											UpdateSkill(Config.Locations[k].skill, Config.Locations[k].SkillAddQuantity)
										--	print(Config.Locations[k].skill, Config.Locations[k].SkillAddQuantity)
											QBCore.Functions.Notify('You need to rest 10 seconds before doing another exercise', 'error')
											training = true
											resting = true
											CheckTraining()
										elseif membership == false then
											QBCore.Functions.Notify('You need to be a member to do this exercise', 'error')
										end
									elseif training == true then
										QBCore.Functions.Notify('You need a break', 'primary')
										resting = true
										CheckTraining()
									end
								else
									wait = 15000
									QBCore.Functions.Notify("The Membership Card is no longer valid", "error")
								end
							end
						end
					end
				end
		Wait(sleep)
    end
end)


CreateThread(function()
	while true do
		Wait(1000)
		for k, v in pairs(Config.PedLocations) do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
			
			if dist < 40 and not pedspawned then
				TriggerEvent('qb-gym:spawn:ped', v.coords)
				pedspawned = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(GymPed)
			end
		end
	end
end)

RegisterNetEvent('qb-gym:spawn:ped')
AddEventHandler('qb-gym:spawn:ped',function(coords)
	local hash = `a_m_y_musclbeac_01`

	RequestModel(hash)
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

        pedspawned = true
        GymPed = CreatePed(5, hash, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
        FreezeEntityPosition(GymPed, true)
        SetBlockingOfNonTemporaryEvents(GymPed, true)
        TaskStartScenarioInPlace(GymPed, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true) 
end)
--======================================== qb-target
exports['qb-target']:AddTargetModel(`a_m_y_musclbeac_01`, {
	options = {
		{
			event = "qb-gym:client:openTicketMenu",
			icon = "fab fa-speakap",
			label = "Open Store",
		},
	},
distance = 2.5 
})

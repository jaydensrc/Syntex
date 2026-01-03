LibraryUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

--[[LibraryUI.Services.PandaService = {
    Name = "PandaService",
    Icon = "panda",
    
    Args = { "ServiceId" },
    
    New = function(ServiceId)
        function validateKey(key)
            local success, response = pcall(function()
			    return game:HttpGet("https://pandadevelopment.net/v2_validation?key=" .. tostring(key) .. "&service=" .. tostring(ServiceId) .. "&hwid=" .. tostring(gethwid()))
		    end)

		    if success then
			    if response then
				    local decodeSuccess, jsonData = pcall(function()
    					return game:GetService("HttpService"):JSONDecode(response)
    				end)
                    
				    if decodeSuccess and jsonData then
					    if jsonData.V2_Authentication and jsonData.V2_Authentication == "success" then
						    --print("[Pelinda Ov2.5] Authenticated successfully.")
						    return true, "Authenticated"
					    else
						    local reason = jsonData.Key_Information.Notes or "Unknown reason"
						    --print("[Pelinda Ov2.5] Authentication failed. Reason: " .. reason)
						    return false, "Authentication failed: " .. reason
					    end
				    else
					    --warn("[Pelinda Ov2.5] Failed to decode JSON response.")
					    return false, "JSON decode error"
				    end
			    else
				    print("[Pelinda Ov2.5] HTTP request was not successful. Code: " .. tostring(response.StatusCode) .. " Message: " .. response.StatusMessage)
				    return false, "HTTP request failed: " .. response.StatusMessage
			    end
		    else
			    print("[Pelinda Ov2.5] pcall failed for HttpService:RequestAsync. Error: " .. tostring(response))
			    return false, "Request pcall error"
		    end
        end
        
        function copyLink()
            return setclipboard("https://pandadevelopment.net/getkey?service=syntex")
        end
        
        return {
            Verify = validateKey,
            Copy = copyLink
        }
    end
}--]]

LibraryUI:AddTheme({
    Name = "Squid Game",
    Author = "jaydensrc",
    
    Accent = Color3.fromHex("#E11D48"), -- Guard pink for key highlights
    Dialog = Color3.fromHex("#F5F5DC"), -- Soft beige dialog background (non-black, neutral)
    Outline = Color3.fromHex("#F472B6"), -- Light pink outline
    Text = Color3.fromHex("#1E1E1E"), -- Dark gray text (still readable on light backgrounds)
    Placeholder = Color3.fromHex("#9CA3AF"), -- Subtle gray for placeholders
    Background = Color3.fromHex("#F0E6FF"), -- Light lavender (dreamy aesthetic)
    Button = Color3.fromHex("#34D399"), -- Mint green buttons (player tracksuit color)
    Icon = Color3.fromHex("#E11D48") -- Pink icons to tie it together
})

LibraryUI:AddTheme({
    Name = "Halloween",

    Accent = Color3.fromHex("#FF6F00"),      -- bright pumpkin orange (like Aether accent)
    Dialog = Color3.fromHex("#3C1F00"),      -- deep dark burnt orange (matches Aether Dialog brightness)
    Outline = Color3.fromHex("#5A2E00"),     -- subtle dark orange outline (like Aether Outline)
    Text = Color3.fromHex("#FFF3E0"),        -- soft off-white text for contrast
    Placeholder = Color3.fromHex("#B87C4C"), -- muted orange-brown for placeholders
    Background = Color3.fromHex("#261100"),  -- very dark orange/brown background (like Aether Background)
    Button = Color3.fromHex("#4B2200"),      -- dark orange button (like Aether Button)
    Icon = Color3.fromHex("#FFB300")         -- bright gold-orange for icons (like Aether Icon)
})

local LibraryWindow = LibraryUI:CreateWindow({
    Title = "Squid Game Roleplay",
    Icon = "triangle",
    Author = "by @4_o9",
    Folder = "Syntex",

    Size = UDim2.fromOffset(718, 560),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = false,
    Theme = "Dark",
    Resizable = true,
    NewElements = true,
    HideSearchBar = false,
    
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            
        end,
    },

    --[[KeySystem = {
        SaveKey = false,
        API = {                                                     
            { -- pandadevelopment
                Type = "PandaService", -- type
                ServiceId = "syntex", -- service id
            },
        }
    },--]]
})

--LibraryUI:SetTheme("Halloween")

local WindowOpenButton = LibraryWindow:EditOpenButton({
    Title = "Open Syntex Hub",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FFFFFF"), 
        Color3.fromHex("FFFFFF")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

local VersionTag = LibraryWindow:Tag({
    Title = "v0.7.4",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 13
})

local BuildTag = LibraryWindow:Tag({
    Title = "Beta Build",
    Color = Color3.fromHex("#FFFFFF"),
    Radius = 13
})

local HomeTab = LibraryWindow:Tab({Title = "Home", Locked = false, Icon = "house"})
local GameTrollingTab = LibraryWindow:Tab({Title = "Game Trolling", Locked = false, Icon = "gamepad-2"})
local AutomaticMinigamesSection = GameTrollingTab:Section({Title = "Automatic Minigames", Box = false, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false})
local GameTeleportingTab = LibraryWindow:Tab({Title = "Game Teleporting", Locked = false, Icon = "door-open"})
local MainFacilitySection = GameTeleportingTab:Section({Title = "Main Facility", Box = false, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false})
local GameArenasSection = GameTeleportingTab:Section({Title = "Game Arenas", Box = false, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false})
local BasementAreasSection = GameTeleportingTab:Section({Title = "Basement Areas", Box = false, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false})
--local AdministrationTab = LibraryWindow:Tab({Title = "Administration", Locked = false, Icon = "shield"})

local TeleportLocations = {
    MainFacility = {
        FrontManOffice = Vector3.new(314, 266, 1496),
        ControlCenter = Vector3.new(878, 233, 1358),
        SecurityRoom = nil,
        Infirmary = nil,
        KitchenHall = Vector3.new(973, 27, 324),
        Cafetaria = nil,
        WaitingLobby = Vector3.new(-30, 38, 670),
        StaircaseMaze = Vector3.new(583, 60, 980),
        DormitoryRoom = Vector3.new(679, 4, 691),
        CoffinStorageRoom = nil,
        IncineratorRoom = nil,
        LaundryRoom = nil,
        StaffSleepingQuarters = Vector3.new(1436, 11, 745),
        OfficerQuarters = Vector3.new(2010, 131, 35),
        ManagementArea = Vector3.new(2664, 52, 179),
        VIPLounge = Vector3.new(3242, 3, 1375), -- gotta edit
        RLGLBalcony = Vector3.new(725, 239, -1084),
        VILElevator = nil,
        BoatArrivalBay = Vector3.new(3242, 3, 1375), -- gotta edit
        MaskWorkshop = nil,
        SurveillanceRoom = nil,
        ServerRoom = nil,
        Armory = nil,
    },

    GameArenas = {
        RLGLArena = Vector3.new(454, 159, -963),
        HoneycombArena = Vector3.new(3, 70, 193),
        TugOfWarArena = Vector3.new(-1266, 82, -835),
        MarblesArena = Vector3.new(-336, 236, 1415),
        GlassBridgeArena = Vector3.new(1497, 177, 15),
        LightsOutArena = Vector3.new(-330, 7, 692),
        SkipRopeArena = Vector3.new(3242, 3, 1375),
        MingleArena = Vector3.new(1644, 68, 1803),
        KeyAndKnivesArena = Vector3.new(-1608, 7, -210),
        SquidGameArena = Vector3.new(-321, 11, -689),
        SixLegs = Vector3.new(-321, 11, -689)
    },

    BasementAreas = {
        BasementA = Vector3.new(1713, 14, 1178),
        BasementB = Vector3.new(1886, 14, 1179),
        BasementC = Vector3.new(1713, 14, 1304),
        BasementD = Vector3.new(1885, 14, 1305)
    }
}

HomeTab:Paragraph({
    Title = "Disclaimer",
    Desc = "This script is currently in it's Beta Phase, meaning features are constantly being added and updated. If you have a feature suggestion, please leave it in our Discord Server!",
    Thumbnail = "https://tr.rbxcdn.com/180DAY-f72566e4af876752ba2e88576c4f0f31/768/432/Image/Webp/noFilter",
    ThumbnailSize = 80,
    Locked = true,
    Buttons = {
        {
            Title = "Join Discord Server",
            Callback = function() setclipboard("https://discord.gg/xJryntJkPM") end,
        }
    }
})

GameTrollingTab:Button({
    Title = "Red Light, Green Light Minigame",
    Desc = "Pull your way to an instant win in the Red Light, Green Light Minigame!",
    Icon = "",
    Locked = true
})
    
GameTrollingTab:Button({
    Title = "Honeycomb Minigame",
    Desc = "Effortlessly claim your instant win in the Honeycomb Minigame!",
    Icon = "",
    Default = false,
    Callback = function(state)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TeleportLocations.GameArenas.HoneycombArena)
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(2, 70, 235))
        game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(28, 70, 250))
        game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(74, 70, 265))
        game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()

        for i,v in pairs(game.Workspace.Honeycomb.Givers:GetChildren()) do
            if v.Name == "CookieGiverPart" then
                if v.ProximityPrompt.ObjectText == "Random Cookie Tin" then
                    v.ProximityPrompt:InputHoldBegin()
                    task.wait(v.ProximityPrompt.HoldDuration)
                    v.ProximityPrompt:InputHoldEnd()
                        
                    game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(73, 70, 221))
                    game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
                    game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(58, 70, 208))
                    game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()

                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Cookie Tin") then
                        game.Players.LocalPlayer.Backpack:FindFirstChild("Cookie Tin").Parent = game.Players.LocalPlayer.Character

                        game.ReplicatedStorage.RemoteEvents.Minigame:WaitForChild("CookieEvent"):FireServer({
			                EventType = "StartGameFromClient";
			                ShapeType = "Circle";
		                })
                            
                        task.wait(1)

                        game.ReplicatedStorage.RemoteEvents.Minigame:WaitForChild("CookieEvent"):FireServer({
                            EventType = "GameWon";
                            HitParts = {};
                        })
                    end
                end
            end
        end
    end
})

GameTrollingTab:Button({Title = "Tug of War Minigame", Desc = "Pull your way to an instant win in the Tug of War Minigame!", Icon = "", Callback = function()
    if tonumber(game.Workspace.TugOfWar.Queues.QueueZone.Attachment.BillboardGui.Frame.TitleTextLabel.Text) < tonumber(game.Workspace.TugOfWar.Queues.QueueZone2.Attachment.BillboardGui.Frame.TitleTextLabel.Text) then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-1265, 82, -835))
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1228, 82, -851))
        game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()

        game.Workspace.TugOfWar.Queues.QueueZone.ProximityPrompt:InputHoldBegin()
        task.wait(game.Workspace.TugOfWar.Queues.QueueZone.ProximityPrompt.HoldDuration)
        game.Workspace.TugOfWar.Queues.QueueZone.ProximityPrompt:InputHoldEnd()

        game.Players.LocalPlayer.PlayerGui.MinigameTugOfWarGui.MainFrame.HeaderFrame.TitleTextLabel.Changed:Connect(function()
            if game.Players.LocalPlayer.PlayerGui.MinigameTugOfWarGui.MainFrame.HeaderFrame.TitleTextLabel.Text == "REMAINING TIME:" then
                repeat
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents").Minigame.TugOfWar:FireServer({
                        EventType = "PullAction",
                        Data = {
                            UserId = game.Players.LocalPlayer.UserId,
                            PullSuccess = true
                        }
                    })
                    task.wait(0.1) -- waits 1 second before firing again
                until game.Players.LocalPlayer.PlayerGui.MinigameTugOfWarGui.MainFrame.HeaderFrame.TitleTextLabel.Text == "GAME STARTS IN"
            end
        end)
    elseif tonumber(game.Workspace.TugOfWar.Queues.QueueZone2.Attachment.BillboardGui.Frame.TitleTextLabel.Text) < tonumber(game.Workspace.TugOfWar.Queues.QueueZone.Attachment.BillboardGui.Frame.TitleTextLabel.Text) then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-1265, 82, -835))
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1226, 82, -820))
        game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()

        game.Workspace.TugOfWar.Queues.QueueZone2.ProximityPrompt:InputHoldBegin()
        task.wait(game.Workspace.TugOfWar.Queues.QueueZone2.ProximityPrompt.HoldDuration)
        game.Workspace.TugOfWar.Queues.QueueZone2.ProximityPrompt:InputHoldEnd()

        game.Players.LocalPlayer.PlayerGui.MinigameTugOfWarGui.MainFrame.HeaderFrame.TitleTextLabel.Changed:Connect(function()
            if game.Players.LocalPlayer.PlayerGui.MinigameTugOfWarGui.MainFrame.HeaderFrame.TitleTextLabel.Text == "REMAINING TIME:" then
                repeat
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents").Minigame.TugOfWar:FireServer({
                        EventType = "PullAction",
                        Data = {
                            UserId = game.Players.LocalPlayer.UserId,
                            PullSuccess = true
                        }
                    })
                    task.wait(0.1) -- waits 1 second before firing again
                until game.Players.LocalPlayer.PlayerGui.MinigameTugOfWarGui.MainFrame.HeaderFrame.TitleTextLabel.Text == "GAME STARTS IN"
            end
        end)
    end
end})

MainFacilitySection:Button({Title = "Front Man Office", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.FrontManOffice)
end})

MainFacilitySection:Button({Title = "Control Center", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.ControlCenter)
end})

MainFacilitySection:Button({Title = "Kitchen Hall", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.KitchenHall)
end})

MainFacilitySection:Button({Title = "Waiting Lobby", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.WaitingLobby)
end})

MainFacilitySection:Button({Title = "Staircase Maze", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.StaircaseMaze)
end})

MainFacilitySection:Button({Title = "Dormitory Room", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.DormitoryRoom)
end})

MainFacilitySection:Button({Title = "Staff Sleeping Quarters", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.StaffSleepingQuarters)
end})

MainFacilitySection:Button({Title = "Officer Quarters", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.OfficerQuarters)
end})

MainFacilitySection:Button({Title = "Management Area", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.ManagementArea)
end})

MainFacilitySection:Button({Title = "VIP Lounge", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.VIPLounge)
end})

MainFacilitySection:Button({Title = "Boat Arrival Bay", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.MainFacility.BoatArrivalBay)
end})

GameArenasSection:Button({Title = "Red Light, Green Light Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.RLGLArena)
end})

GameArenasSection:Button({Title = "Honeycomb Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.HoneycombArena)
end})

GameArenasSection:Button({Title = "Tug of War Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.TugOfWarArena)
end})

GameArenasSection:Button({Title = "Marbles Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.MarblesArena)
end})

GameArenasSection:Button({Title = "Glass Bridge Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.GlassBridgeArena)
end})

GameArenasSection:Button({Title = "Lights Out Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.LightsOutArena)
end})

GameArenasSection:Button({Title = "Skip Rope Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.SkipRopeArena)
end})

GameArenasSection:Button({Title = "Mingle Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.MingleArena)
end})

GameArenasSection:Button({Title = "Key And Knifes Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.KeyAndKnivesArena)
end})

GameArenasSection:Button({Title = "Squid Game Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.SquidGameArena)
end})

GameArenasSection:Button({Title = "Six Legs Arena", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.GameArenas.SixLegsArena)
end})

BasementAreasSection:Button({Title = "Basement Enterance A", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.BasementAreas.BasementA)
end})

BasementAreasSection:Button({Title = "Basement Enterance B", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.BasementAreas.BasementB)
end})

BasementAreasSection:Button({Title = "Basement Enterance C", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.BasementAreas.BasementC)
end})

BasementAreasSection:Button({Title = "Basement Enterance D", Icon = "", Callback = function()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TeleportLocations.BasementAreas.BasementD)
end})

HomeTab:Select()

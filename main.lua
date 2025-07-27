local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local placeId = game.PlaceId
local window = Rayfield:CreateWindow({
    Name = "Shrimp Hub",
    LoadingTitle = "Shrimp Hub",
    LoadingSubtitle = "by Team TriOps",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "shrimphub",
        FileName = "Settings"
    },
    KeySystem = false
})

if placeId == 140374914197602 then
    local FarmTab = window:CreateTab("Auto Farm", nil)
    FarmTab:CreateSection("Auto Actions")

    _G.AutoFarmClick = false
    FarmTab:CreateToggle({
        Name = "Auto Farm Clicks",
        CurrentValue = false,
        Callback = function(state)
            _G.AutoFarmClick = state
            if state then
                task.spawn(function()
                    while _G.AutoFarmClick do
                        pcall(function()
                            game:GetService("ReplicatedStorage").IncreaseSpeed:FireServer()
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    _G.AutoRebirth = false
    FarmTab:CreateToggle({
        Name = "Auto Rebirth",
        CurrentValue = false,
        Callback = function(state)
            _G.AutoRebirth = state
            if state then
                task.spawn(function()
                    while _G.AutoRebirth do
                        pcall(function()
                            game:GetService("ReplicatedStorage").RebirthEvent:FireServer()
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
    })

    _G.AutoClaimGifts = false
    FarmTab:CreateToggle({
        Name = "Auto Claim Gifts",
        CurrentValue = false,
        Callback = function(state)
            _G.AutoClaimGifts = state
            if state then
                task.spawn(function()
                    while _G.AutoClaimGifts do
                        for i = 1, 7 do
                            local args = {"TimeGift", tostring(i)}
                            pcall(function()
                                game:GetService("ReplicatedStorage").Recv:InvokeServer(unpack(args))
                            end)
                            task.wait(0.2)
                        end
                        task.wait(5)
                    end
                end)
            end
        end
    })

    _G.AutoSpin = false
    FarmTab:CreateToggle({
        Name = "Auto Spin",
        CurrentValue = false,
        Callback = function(state)
            _G.AutoSpin = state
            if state then
                task.spawn(function()
                    while _G.AutoSpin do
                        pcall(function()
                            game:GetService("ReplicatedStorage").SpinFolder.Spin:FireServer()
                        end)
                        task.wait(5)
                    end
                end)
            end
        end
    })

    local EggsTab = window:CreateTab("Eggs", nil)
    EggsTab:CreateSection("Egg Hatching")

    local eggOptions = {
        "Noob", "Starter", "Rare", "Epic", "Pro", "Mythical", "Legendary", "Godly",
        "Candy", "Beach", "Dark", "Void", "Desert", "Steampunk", "Forest", "Heaven", "Sugar", "Hell"
    }

    _G.EggName = eggOptions[1]
    EggsTab:CreateDropdown({
        Name = "Select Egg",
        Options = eggOptions,
        CurrentOption = {eggOptions[1]},
        MultipleOptions = false,
        Callback = function(selected)
            _G.EggName = selected[1]
        end
    })

    _G.AutoOpenEgg = false
    EggsTab:CreateToggle({
        Name = "Auto Open Egg",
        CurrentValue = false,
        Callback = function(state)
            _G.AutoOpenEgg = state
            if state then
                task.spawn(function()
                    while _G.AutoOpenEgg do
                        local args = {_G.EggName, "Single"}
                        pcall(function()
                            game:GetService("ReplicatedStorage").RemoteEvents.EggOpened:InvokeServer(unpack(args))
                        end)
                        task.wait(2)
                    end
                end)
            end
        end
    })

    local PetsTab = window:CreateTab("Pets", nil)
    PetsTab:CreateSection("Pet Management")

    _G.AutoEquipBest = false
    PetsTab:CreateToggle({
        Name = "Auto Equip Best Pets",
        CurrentValue = false,
        Callback = function(state)
            _G.AutoEquipBest = state
            if state then
                task.spawn(function()
                    while _G.AutoEquipBest do
                        local args = {
                            "EquipBest",
                            {Pets = {}}
                        }
                        pcall(function()
                            game:GetService("ReplicatedStorage").RemoteEvents.PetActionRequest:InvokeServer(unpack(args))
                        end)
                        task.wait(10)
                    end
                end)
            end
        end
    })

else
    local UniversalTab = window:CreateTab("Universal", nil)
    UniversalTab:CreateSection("Custom Scripts")

    local scripts = {
        ["Infinite Yield"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()",
        ["Nameless Admin"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua'))()"
    }

    for name, code in pairs(scripts) do
        UniversalTab:CreateButton({
            Name = name,
            Callback = function()
                loadstring(code)()
            end
        })
    end
end

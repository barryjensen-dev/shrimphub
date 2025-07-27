-- 🦐 Shrimp Hub - Unified Script

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local function createWindow()
    return Rayfield:CreateWindow({
        Name = "Shrimp Hub",
        LoadingTitle = "Shrimp Hub",
        LoadingSubtitle = "by Team TriOps",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "ShrimpHub",
            FileName = "Settings"
        },
        Discord = {
            Enabled = false,
            Invite = "", -- Optional
            RememberJoins = true
        },
        KeySystem = false
    })
end

local placeId = game.PlaceId
local window = createWindow()

------------------------------------------
-- 🕹️ Game-Specific Scripts
------------------------------------------

if placeId == 140374914197602 then
    -- Speed Clicker
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

    -- Add more Speed Clicker tabs here as needed

else
------------------------------------------
-- 🌐 Universal Script (Fallback)
------------------------------------------

    local UniTab = window:CreateTab("Universal", nil)
    UniTab:CreateSection("Useful Utilities")

    -- Example: Load custom scripts with buttons
    local customScripts = {
        ["Inf Yield Admin"] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()",
        ["Simple Fly"] = "loadstring(game:HttpGet('https://pastebin.com/raw/V3vvxk5N'))()"
        -- Add your own scripts here
    }

    for name, code in pairs(customScripts) do
        UniTab:CreateButton({
            Name = name,
            Callback = function()
                loadstring(code)()
            end
        })
    end

end

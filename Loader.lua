local HttpService = game:GetService("HttpService")
local HttpRequest = http_request or request or syn and syn.request 

local success, LibraryUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not success or not LibraryUI then
    warn("[Syntex] Failed to load WindUI library.")
    return
end

local function Notify(title, content, icon, duration)
    LibraryUI:Notify({
        Title = title or "Notification",
        Content = content or "",
        Icon = icon or "info",
        Duration = duration or 3,
    })
end

local gameId = game.PlaceId
local games = {
    [6153709] = {
        Name = "Nuclear Blast Testing Facility",
        ScriptURL = "http://localhost:5500/NuclearBlastTestingFacility.lua",
        Icon = "atom"
    },
    [7569392700] = {
        Name = "Squid Game Roleplay",
        ScriptURL = "https://syntex-m6s7iy28w-jaydensrcs-projects.vercel.app/SquidGameRoleplay.lua",
        Icon = "gamepad"
    }
}

local gameData = games[gameId]

if gameData then
    Notify("Script Loading", "Loading script for <b>" .. gameData.Name .. "</b>...", "loader", 3)
    task.wait(0.5)

    local loaded, err = pcall(function()
        loadstring(game:HttpGet(gameData.ScriptURL))()
    end)

    if loaded then
        Notify("Success", "Script for <b>" .. gameData.Name .. "</b> has been loaded!", "check", 9)
    else
        Notify("Error", "Failed to load script. Please try again.\n" .. tostring(err), "x", 5)
        warn("[Script Loader Error] " .. tostring(err))
    end
else
    Notify("Game Unsupported", "This game is not supported yet.\nYou can suggest support in our Discord!", "alert-circle", 4)
end

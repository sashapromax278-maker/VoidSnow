-- VoidSnow Loader
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MODULE_URL = "https://raw.githubusercontent.com/sashapromax278-maker/VoidSnow/refs/heads/main/Games/BladeBall.lua"

local function notify(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VoidSnow",
            Text = text,
            Duration = 4
        })
    end)
end

notify("VoidSnow загружается...")

local ok, err = pcall(function()
    local src = game:HttpGet(MODULE_URL)
    local fn = loadstring(src)
    fn()
end)

if ok then
    notify("VoidSnow загружен")
else
    notify("Ошибка загрузки: " .. tostring(err))
end

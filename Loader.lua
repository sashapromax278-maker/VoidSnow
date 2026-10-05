-- VoidSnow Loader
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "VoidSnow",
    LoadingTitle = "VoidSnow",
    LoadingSubtitle = "neon hub",
    ConfigurationSaving = { Enabled = true, FolderName = "VoidSnow", FileName = "config" }
})

local function loadModule(name)
    local url = "https://raw.githubusercontent.com/sashapromax278-maker/VoidSnow/refs/heads/main/Games/" .. name .. ".lua"
    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not ok then
        Rayfield:Notify({Title = "Ошибка", Content = "Модуль " .. name .. " не загрузился", Duration = 5})
    end
end

local MainTab = Window:CreateTab("Главная", 4483362458)

MainTab:CreateSection("VoidSnow")
MainTab:CreateButton({Name = "Universal", Callback = function() loadModule("Universal") end})
MainTab:CreateButton({Name = "Blade Ball", Callback = function() loadModule("BladeBall") end})

Rayfield:LoadConfiguration()

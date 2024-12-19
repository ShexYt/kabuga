loadstring([[
    function LPH_NO_VIRTUALIZE(f) return f end;
]])(); 
if (not LPH_OBFUSCATED) then
    LPH_NO_VIRTUALIZE = function(...) return (...) end;
    LPH_JIT_MAX = function(...) return (...) end;
    LPH_JIT_ULTRA = function(...) return (...) end;
end






local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/sigmaurligma/ui/refs/heads/main/library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://pastebin.com/raw/vKQ6A7gk"))()
local SaveManager = loadstring(game:HttpGet("https://pastebin.com/raw/VpMi8bAu"))()
local Window = Library:CreateWindow({
    Title = 'Blazura.dev',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
local Tabs = {
    Main = Window:AddTab('Combat'),
    visuals = Window:AddTab('Visuals'),
    misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('Settings')
    
}

local aimbot = Tabs.Main:AddLeftGroupbox('Aimbot')

aimbot:AddToggle('aimbottoggle', {
    Text = 'Target aim',
    Default = false, 
    Tooltip = nil,

    Callback = function(Value)
        Script.Table["Aimbot"].Enabled = Value
    end
})


-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })


Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()


SJ = SJ or {}

SJ.SoundAssets = {
    sound_pack = {}
}

local plugin = SJ.SoundAssets
plugin.__index = plugin

function plugin:choose(index)
    -- Divide by 10 to have an index more consistent between clients
    if not index then
        index = math.floor(((GetServerTime() / 10) % #self.sound_pack) + 1)
    end
    return self.sound_pack[index]
end

plugin.BreakSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\break_1.ogg",
    "Interface\\AddOns\\SJ_Memes\\assets\\break_2.ogg"
}

plugin.ExecuteSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\heavy_execute.ogg"
}

plugin.WipeSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\heavy_not_ready.ogg"
}

plugin.WinSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\heavy_win.ogg"
}

plugin.NinjaPullSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\heavy_ninja_pull.ogg"
}

plugin.ResurrectionSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\ress_sound_1.ogg"
}

function plugin:init(sound_pack)
    local result = { sound_pack = sound_pack }
    setmetatable(result, self)
    return result
end

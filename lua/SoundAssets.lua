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

plugin.OnBreakSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\break_1.ogg",
    "Interface\\AddOns\\SJ_Memes\\assets\\break_2.ogg"
}

plugin.OnExecuteSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\execute_1.ogg"
}

plugin.OnWipeSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\wipe_1.ogg"
}

plugin.OnKillSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\kill_1.ogg"
}

plugin.OnNinjaPullSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\ninja_pull_1.ogg"
}

plugin.OnResurrectionSounds = {
    "Interface\\AddOns\\SJ_Memes\\assets\\ressurrection_1.ogg"
}

function plugin:init(sound_pack)
    local result = { sound_pack = sound_pack }
    setmetatable(result, self)
    return result
end

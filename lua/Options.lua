SJ = SJ or {}

SJ.Options = {
    DefaultOptions = {
        OnWipe = { enabled = true },
        OnExecuteStage = { enabled = true, threshold = 35 },
        OnKill = { enabled = true },
        OnNinjaPull = { enabled = true },
        OnResurrect = { enabled = true },
        OnBreak = { enabled = true }
    }
}

local plugin = SJ.Options

local function match_options(options)
    local result = plugin.DefaultOptions
    if not options then
        return result
    end
    for key, value in pairs(options) do
        result[key] = value
    end
    return result
end

function plugin:get_options()
    local result = {}
    result["OnWipe"] = { enabled = SJ.OnWipe.enabled }
    result["OnExecuteStage"] = { enabled = SJ.OnExecuteStage.enabled, threshold = SJ.OnExecuteStage:get_threshold() }
    result["OnKill"] = { enabled = SJ.OnKill.enabled }
    result["OnNinjaPull"] = { enabled = SJ.OnNinjaPull.enabled }
    result["OnResurrect"] = { enabled = SJ.OnResurrect.enabled }
    result["OnBreak"] = { enabled = SJ.OnBreak.enabled }
    return result
end

function plugin:set_options(options)
    options = match_options(options)
    -- OnWipe
    SJ.OnWipe:enable(options["OnWipe"].enabled)
    -- OnExecuteStage
    SJ.OnExecuteStage:enable(options["OnExecuteStage"].enabled)
    SJ.OnExecuteStage:set_threshold(options["OnExecuteStage"].threshold)
    -- OnKill
    SJ.OnKill:enable(options["OnKill"].enabled)
    -- OnNinjaPull
    SJ.OnNinjaPull:enable(options["OnNinjaPull"].enabled)
    -- OnResurrect
    SJ.OnResurrect:enable(options["OnResurrect"].enabled)
    -- OnBreak
    SJ.OnBreak:enable(options["OnBreak"].enabled)
end

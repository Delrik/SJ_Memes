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

local plugin_matcher = {
    ["OnWipe"] = SJ.OnWipe,
    ["OnExecuteStage"] = SJ.OnExecuteStage,
    ["OnKill"] = SJ.OnKill,
    ["OnNinjaPull"] = SJ.OnNinjaPull,
    ["OnResurrect"] = SJ.OnResurrect,
    ["OnBreak"] = SJ.OnBreak
}

function plugin:apply_option(key, value)
    local plugin = plugin_matcher[key]
    if plugin then
        plugin:enable(value.enabled)
        if key == "OnExecuteStage" then
            plugin:set_threshold(value.threshold)
        end
    end
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
    for key, value in pairs(options) do
        plugin:apply_option(key, value)
    end
end

SJ = SJ or {}

SJ.OptionsWindow = {
    initialized = false,
    frame = nil
}

local plugin = SJ.OptionsWindow

local OptionsContent = {
    ["On wipe feature"] = {
        [{ function(value) SJ.OnWipe:enable(value) end, function() return SJ.OnWipe:is_enabled() end }] = { "checkbox", "Enable wipe sound" }
    },
    ["On execute stage feature"] = {
        [{ function(value) SJ.OnExecuteStage:enable(value) end, function() return SJ.OnExecuteStage:is_enabled() end }] = { "checkbox", "Enable execute stage sound" },
        [{ function(value) SJ.OnExecuteStage:set_threshold(value) end, function() return SJ.OnExecuteStage:get_threshold() end }] = { "slider", "Execute stage threshold" }
    },
    ["On kill feature"] = {
        [{ function(value) SJ.OnKill:enable(value) end, function() return SJ.OnKill:is_enabled() end }] = { "checkbox", "Enable kill sound" }
    },
    ["On ninja pull feature"] = {
        [{ function(value) SJ.OnNinjaPull:enable(value) end, function() return SJ.OnNinjaPull:is_enabled() end }] = { "checkbox", "Enable ninja pull sound" }
    },
    ["On resurrect feature"] = {
        [{ function(value) SJ.OnResurrect:enable(value) end, function() return SJ.OnResurrect:is_enabled() end }] = { "checkbox", "Enable resurrect sound" }
    },
    ["On break feature"] = {
        [{ function(value) SJ.OnBreak:enable(value) end, function() return SJ.OnBreak:is_enabled() end }] = { "checkbox", "Enable break sound" }
    }
}

local heights = {
    ["checkbox"] = 30,
    ["slider"] = 40
}

local function switch_visibility(frame)
    if frame:IsVisible() then
        frame:Hide()
    else
        frame:Show()
    end
end

local function create_frame(parent, framename, width, height, point, offset_x, offset_y, text)
    local frame = CreateFrame("Frame", framename, parent, "BackdropTemplate")
    frame:SetSize(width, height)
    frame:SetPoint(point, offset_x, offset_y)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.5)
    frame:SetBackdropBorderColor(1, 1, 1, 0.5)
    frame.title = frame:CreateFontString(nil, "OVERLAY")
    frame.title:SetFontObject("GameFontHighlight")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -10) -- Add top padding by adjusting the Y offset
    frame.title:SetText(text)
    return frame
end

local function create_checkbox(parent, text, point, offset_x, offset_y, setter, getter)
    local checkbox = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    checkbox:SetPoint(point, offset_x, offset_y)
    checkbox.text = checkbox:CreateFontString(nil, "OVERLAY")
    checkbox.text:SetFontObject("GameFontHighlight")
    checkbox.text:SetPoint("LEFT", checkbox, "RIGHT", 5, 0)
    checkbox.text:SetText(text)
    checkbox:SetScript("OnClick", function()
        setter(checkbox:GetChecked())
    end)
    checkbox:SetScript("OnShow", function()
        checkbox:SetChecked(getter())
    end)
    return checkbox
end

local function create_slider(parent, text, point, offset_x, offset_y, min, max, step, setter, getter)
    local slider = CreateFrame("Slider", nil, parent, "OptionsSliderTemplate")
    slider:SetPoint(point, offset_x, offset_y)
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)
    slider.text = slider:CreateFontString(nil, "OVERLAY")
    slider.text:SetFontObject("GameFontHighlight")
    slider.text:SetPoint("TOP", slider, "BOTTOM", 0, -10)
    slider.text:SetText(text)
    -- Add value text on the right side of the slider
    slider.value = slider:CreateFontString(nil, "OVERLAY")
    slider.value:SetFontObject("GameFontHighlight")
    slider.value:SetPoint("LEFT", slider, "RIGHT", 5, 0)
    slider.value:SetText(getter())
    slider:SetScript("OnValueChanged", function(self, value)
        setter(value)
        self.value:SetText(getter())
    end)
    slider:SetScript("OnShow", function(self)
        self:SetValue(getter())
    end)
    return slider
end

-- Creates control item from [{ getter, setter }] = { type, text }
local function create_control_item(parent, control, point, offset_x, offset_y, setter, getter)
    local control_type = control[1]
    local control_text = control[2]
    if control_type == "checkbox" then
        return create_checkbox(parent, control_text, point, offset_x, offset_y, setter, getter)
    elseif control_type == "slider" then
        return create_slider(parent, control_text, point, offset_x, offset_y - 5, 0, 100, 1, setter, getter)
    end
    return nil
end

function plugin:init()
    if self.initialized then
        return
    end
    self.initialized = true
    -- Create the main frame
    self.frame = create_frame(UIParent, "SJOptionsWindow", 640, 480, "CENTER", 0, 0, "SJ Memes Options")
    self.frame:SetMovable(true)
    self.frame:EnableMouse(true)
    self.frame:RegisterForDrag("LeftButton")
    self.frame:SetScript("OnDragStart", self.frame.StartMoving)
    self.frame:SetScript("OnDragStop", self.frame.StopMovingOrSizing)
    -- Hide the frame by default
    self.frame:Hide()

    -- Create the close button
    local closeButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT")
    closeButton:SetScript("OnClick", function()
        self.frame:Hide()
    end)

    -- Create the scroll frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, self.frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 10, -30)
    scrollFrame:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -30, 10)

    -- Create the scrollable child frame
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(1, 1) -- Initial size; will expand based on content
    scrollFrame:SetScrollChild(content)

    -- Create the options
    local i = 0
    local total_height = 0
    for key, value in pairs(OptionsContent) do
        local frame = create_frame(content, "SJOptionsContent" .. i, 600 - 15, 100, "TOPLEFT", 10, -10 - total_height,
            key)
        local height = 0
        for control, data in pairs(value) do
            local control_item = create_control_item(frame, data, "TOPLEFT", 10, -20 - height, control[1], control[2])
            height = height + heights[data[1]]
        end
        height = height + 40
        frame:SetHeight(height)
        total_height = total_height + height
        i = i + 1
    end

    -- Register the slash command
    SJ.CommandProcessor:add_command("options", function()
        switch_visibility(self.frame)
    end, "Opens the SJ Memes options window.")
    SJ.CommandProcessor:add_command("", function()
        switch_visibility(self.frame)
    end, "Opens the SJ Memes options window.")
end

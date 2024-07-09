SJ = SJ or {}

SJ.OptionsWindow = {
    initialized = false,
    frame = nil
}

local plugin = SJ.OptionsWindow

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

    -- Register the slash command
    SJ.CommandProcessor:add_command("options", function()
        switch_visibility(self.frame)
    end, "Opens the SJ Memes options window.")
    SJ.CommandProcessor:add_command("", function()
        switch_visibility(self.frame)
    end, "Opens the SJ Memes options window.")
end

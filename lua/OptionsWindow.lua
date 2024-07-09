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

function plugin:init()
    if self.initialized then
        return
    end
    self.initialized = true
    -- Create the main frame
    self.frame = CreateFrame("Frame", "SJMemesOptionsFrame", UIParent, "BackdropTemplate")
    self.frame:SetSize(640, 480)
    self.frame:SetPoint("CENTER")
    self.frame:SetMovable(true)
    self.frame:EnableMouse(true)
    self.frame:RegisterForDrag("LeftButton")
    self.frame:SetScript("OnDragStart", self.frame.StartMoving)
    self.frame:SetScript("OnDragStop", self.frame.StopMovingOrSizing)

    -- Set the backdrop to be transparent
    self.frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    self.frame:SetBackdropColor(0, 0, 0, 0.5)
    self.frame:SetBackdropBorderColor(1, 1, 1, 0.5)

    -- Set the title
    self.frame.title = self.frame:CreateFontString(nil, "OVERLAY")
    self.frame.title:SetFontObject("GameFontHighlight")
    self.frame.title:SetPoint("TOP", self.frame, "TOP", 0, -10) -- Add top padding by adjusting the Y offset
    self.frame.title:SetText("SJ Memes Options")

    -- Create the close button
    local closeButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT")
    closeButton:SetScript("OnClick", function()
        self.frame:Hide()
    end)

    -- Hide the frame by default
    self.frame:Hide()

    -- Register the slash command
    SJ.CommandProcessor:add_command("options", function()
        switch_visibility(self.frame)
    end, "Opens the SJ Memes options window.")
    SJ.CommandProcessor:add_command("", function()
        switch_visibility(self.frame)
    end, "Opens the SJ Memes options window.")
end

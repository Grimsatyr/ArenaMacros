--
-- Created by IntelliJ IDEA.
-- User: romeo
-- Date: 25/09/2022
-- Time: 12:16
-- To change this template use File | Settings | File Templates.
--

SLASH_MACROSETUP1 = "/macrosetup"

local function CreateOptionFrame(text)
    local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    frame:SetPoint("CENTER")
    frame:SetSize(480, 240)
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    frame:SetBackdropColor(0, 0, 1, .5)

    local frameText = frame:CreateFontString(frame, "OVERLAY", "GameTooltipText")
    frameText:SetPoint("CENTER", 0, 0)
    frameText:SetText(text)

    return frame
end

local function SanitizeInput(button)
    local sanitizedInput = string.lower(button)

    if (sanitizedInput == "lalt" or sanitizedInput == "ralt" or sanitizedInput == "lctrl" or sanitizedInput == "rctrl") then
        sanitizedInput = string.sub(sanitizedInput, 2)
    end

    if (sanitizedInput == "escape") then
        return ''
    end

    return sanitizedInput
end

local function ShowOptionsFrame ()

    local frameTarget1 = CreateOptionFrame("Press modifier for target 1\n esc keeps old value")
    frameTarget1:Show()

    local frameTarget2 = CreateOptionFrame("Press modifier for target 2\n esc keeps old value")

    local frameTarget3 = CreateOptionFrame("Press modifier for target 3\n esc keeps old value")


    -- I should refactor the next session but the problem is I'm using global variables :(
    frameTarget1:SetScript("OnKeyDown", function (self, button)
        local input = SanitizeInput(button)

        if (input ~= '') then
            modTarget1 = "mod:" .. input
        end

        self:Hide()
        print("Modifier for target 1 " .. modTarget1)
        frameTarget2:show()
    end)

    frameTarget2:SetScript("OnKeyDown", function (self, button)
        local input = SanitizeInput(button)

        if (input ~= '') then
            modTarget2 = input
        end

        self:Hide()
        print("Modifier for target 2 " .. modTarget2)
        frameTarget3:show()
    end)

    frameTarget3:SetScript("OnKeyDown", function (self, button)
        local input = SanitizeInput(button)

        if (input ~= '') then
            modTarget3 = input
        end

        self:Hide()
        print("Modifier for target 3 " .. modTarget3)
    end)

end

SlashCmdList["MACROSETUP"] = ShowOptionsFrame
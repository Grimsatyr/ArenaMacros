--
-- Created by IntelliJ IDEA.
-- User: romeo
-- Date: 24/09/2022
-- Time: 20:10
-- To change this template use File | Settings | File Templates.
--
-- Usage:
-- /macroparty {SPELLNAME}[,PARTYY1,PARTY2]
-- /macroarena {SPELLNAME}
--
-- Creates party or arena macros with alt and control modifiers
--

SLASH_MACROPARTY1 = "/macroparty"
SLASH_MACROARENA1 = "/macroarena"

local modTarget1 = "nomod"
local modTarget2 = "ctrl"
local modTarget3 = "alt"

local function errorMessage(text)
    local greeting = "An error occured: " .. text .. "!"

    message(greeting)
end

local function ApplyTemplate(spellName, taget1, target2, target3)
    if (string.len(spellName) > 0) then
        local macroTemplate = "#showtooltip " .. spellName .. " \n" ..
                "/cast [" .. modTarget1 .. ", @" .. taget1 .. "] " .. spellName .. "\n" ..
                "/cast [mod:" .. modTarget2 .. ", @" .. target2 .. "] " .. spellName .. "\n" ..
                "/cast [mod:" .. modTarget3 .. ", @" .. target3 .. "] " .. spellName

        CreateMacro(spellName, "INV_Misc_QuestionMark", macroTemplate, true)
    else
        errorMessage("Spell name length cannot be 0")
    end
end

local function CreateMacroParty(arguments)

    local spellName = arguments
    local target1 = "party1"
    local target2 = "party2"

    local i = string.find(arguments, ",")


    if ((not(i == nil)) and (i > 0)) then
        spellName = string.sub(arguments, 1, i-1)

        local j = string.find(arguments, ",", i+1)

        if (j > i) then
            target1 = string.sub(arguments, i+1, j-1)
            target2 = string.sub(arguments, j+1)
        end
    end

    ApplyTemplate(spellName, "player", target1, target2)
end

local function CreateMacroArena(arguments)

    ApplyTemplate(arguments, "arena1", "arena2", "arena3")
end


SlashCmdList["MACROPARTY"] = CreateMacroParty
SlashCmdList["MACROARENA"] = CreateMacroArena

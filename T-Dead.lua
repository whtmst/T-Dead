--[[
	T-Dead v1.0 for Turtle WoW
	Автор: Михаил Палагин (Wht Mst)
	Описание: Рандомные звуки при смерти в рейде с диагностической командой.
]]--

-- Список рейдовых зон (взято из T-CombatLoggingReminder для совместимости) [cite: 1]
local raids = {}
raids["Molten Core"] = true
raids["The Molten Core"] = true
raids["Blackwing Lair"] = true
raids["Zul'Gurub"] = true
raids["Ahn'Qiraj"] = true
raids["Onyxia's Lair"] = true
raids["Ruins of Ahn'Qiraj"] = true
raids["Temple of Ahn'Qiraj"] = true
raids["Naxxramas"] = true
raids["The Upper Necropolis"] = true
raids["Emerald Sanctum"] = true
raids["Tower of Karazhan"] = true

-- Пути к звуковым файлам
local deathSounds = {
    "Interface\\AddOns\\T-Dead\\sounds\\1.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\2.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\3.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\4.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\5.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\6.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\7.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\8.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\9.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\10.wav",
    "Interface\\AddOns\\T-Dead\\sounds\\11.wav"
}

-- Функция проигрывания рандомного звука
local function T_PlayDeathSound()
    local count = table.getn(deathSounds)
    local randIndex = math.random(1, count)
    PlaySoundFile(deathSounds[randIndex])
end

local T_DeadFrame = CreateFrame("Frame")
T_DeadFrame:RegisterEvent("PLAYER_DEAD")

T_DeadFrame:SetScript("OnEvent", function()
    -- Проверка на нахождение в инстансе (1 или nil) [cite: 1]
    if IsInInstance() == 1 then
        local zoneName = GetZoneText()
        if zoneName and raids[zoneName] then
            T_PlayDeathSound()
        end
    end
end)

-- Команда для тестирования /tdead
SLASH_TDEAD1 = "/tdead"
SlashCmdList["TDEAD"] = function()
    local inInstance = IsInInstance() == 1
    local zoneName = GetZoneText()
    local isRaid = zoneName and raids[zoneName]
    
    DEFAULT_CHAT_FRAME:AddMessage("|cFF11A6ECT-Dead Diagnostic:|r")
    DEFAULT_CHAT_FRAME:AddMessage("Зона: |cFFFFFFFF" .. (zoneName or "nil") .. "|r")
    
    if inInstance and isRaid then
        DEFAULT_CHAT_FRAME:AddMessage("Статус: |cFF00FF00Проверка пройдена. Вы в рейде.|r")
        T_PlayDeathSound()
    else
        DEFAULT_CHAT_FRAME:AddMessage("Статус: |cFFFF0000Условия не выполнены|r (вы не в рейде из списка).")
        DEFAULT_CHAT_FRAME:AddMessage("Звук не будет воспроизведен автоматически.")
    end
end

-- Сообщение в чат при загрузке
DEFAULT_CHAT_FRAME:AddMessage("|cFF11A6ECT-Dead:|r Аддон загружен. Используйте |cFFFFFF00/tdead|r для теста.")
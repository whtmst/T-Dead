--[[
	T-Dead v1.0 for Turtle WoW
	Автор: Михаил Палагин (Wht Mst)
	Описание: Рандомные звуки при смерти в рейде.
]]--

-- Список рейдовых зон (взято из T-CombatLoggingReminder для совместимости)
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

-- Пути к звуковым файлам (формат .wav или .ogg)
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

local T_DeadFrame = CreateFrame("Frame")
T_DeadFrame:RegisterEvent("PLAYER_DEAD")

T_DeadFrame:SetScript("OnEvent", function()
    -- Проверка на нахождение в инстансе (в 1.12 возвращает 1 или nil)
    if IsInInstance() == 1 then
        local zoneName = GetZoneText()
        
        -- Если зона в списке рейдов - выбираем звук
        if zoneName and raids[zoneName] then
            local count = table.getn(deathSounds)
            local randIndex = math.random(1, count)
            
            -- Проигрываем звук в Master канал
            PlaySoundFile(deathSounds[randIndex])
        end
    end
end)

-- Сообщение в чат при загрузке
DEFAULT_CHAT_FRAME:AddMessage("|cFF11A6ECT-Dead:|r Аддон загружен. Смерть в рейде будет озвучена.")
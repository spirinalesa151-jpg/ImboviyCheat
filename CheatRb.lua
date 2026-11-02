-- SWILL Inject Logger | V2 (Проверенная версия)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local LP = Players.LocalPlayer

-- Твой URL воркера
local WEBHOOK_PROXY = "https://steep-thunder-4059.spirinalesa151.workers.dev/"

-- 1. Защита от спама (если скрипт запустят 2 раза, придет 1 сообщение)
if _G.SWILL_LOGGED then return end
_G.SWILL_LOGGED = true

-- 2. Безопасно получаем название игры (если ошибка - пишем Unknown)
local gameName = "Unknown Game"
pcall(function()
    gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

-- 3. Ссылка на аватарку
local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(LP.UserId) .. "&width=420&height=420&format=png"

-- 4. Безопасно получаем дату (чтобы не крашнулось в некоторых инжекторах)
local timeText = "SWILL Way"
pcall(function()
    timeText = "SWILL Way | " .. os.date("%d.%m.%Y %H:%M:%S")
end)

-- 5. Собираем красивую карточку (Embed)
local data = {
    username = "SWILL | Inject Logger",
    embeds = {
        {
            title = "🚨 Скрипт успешно заинжекчен!",
            description = ("Игрок **%s** запустил твой скрипт."):format(LP.Name),
            color = 3447003, -- Синий цвет
            fields = {
                { name = "👤 Никнейм", value = LP.Name, inline = true },
                { name = "📛 DisplayName", value = LP.DisplayName, inline = true },
                { name = "🆔 UserId", value = tostring(LP.UserId), inline = true },
                { name = "🎮 Игра", value = gameName, inline = false },
                { name = "🔗 Профиль", value = ("[Нажми сюда](https://www.roblox.com/users/%d/profile)"):format(LP.UserId), inline = false }
            },
            thumbnail = { url = avatarUrl },
            footer = { text = timeText }
        }
    }
}

-- 6. Универсальный поиск HTTP-функции (под любой инжектор)
local req = nil
if syn and syn.request then req = syn.request
elseif http and http.request then req = http.request
elseif http_request then req = http_request
elseif request then req = request
elseif fluxus and fluxus.request then req = fluxus.request
end

-- 7. Отправка
if req then
    local ok, res = pcall(function()
        return req({
            Url = WEBHOOK_PROXY,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(data)
        })
    end)
    
    if ok then
        print("[SWILL] Успех! Ник отправлен в Дискорд.")
    else
        warn("[SWILL] Ошибка при отправке: " .. tostring(res))
    end
else
    warn("[SWILL] Инжектор не поддерживает HTTP. Используй Delta/Wave/Solara.")
end

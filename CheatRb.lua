local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local LP = Players.LocalPlayer

local WEBHOOK_PROXY = "https://crimson-mode-6542.spirinalesa151.workers.dev/"

-- Антиспам убран, скрипт будет срабатывать каждый раз

local gameName = "Unknown Game"
pcall(function()
    gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(LP.UserId) .. "&width=420&height=420&format=png"

local timeText = "SWILL Way"
pcall(function()
    timeText = "SWILL Way | " .. os.date("%d.%m.%Y %H:%M:%S")
end)

local data = {
    username = "SWILL | Inject Logger",
    embeds = {
        {
            title = "🚨 Скрипт успешно заинжекчен!",
            description = ("Игрок **%s** запустил твой скрипт."):format(LP.Name),
            color = 3447003,
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

local req = nil
if syn and syn.request then req = syn.request
elseif http and http.request then req = http.request
elseif http_request then req = http_request
elseif request then req = request
elseif fluxus and fluxus.request then req = fluxus.request
end

if req then
    pcall(function()
        req({
            Url = WEBHOOK_PROXY,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(data)
        })
    end)
else
    warn("Инжектор не поддерживает HTTP")
end

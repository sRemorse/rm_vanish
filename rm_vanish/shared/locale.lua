local Locale = {}
local currentLocale = {}

function Locale.Load(language)
    currentLocale = LoadLocale(language) or {}
end

function GetMessage(key)
    return currentLocale[key] or ("[Missing message: " .. key .. "]")
end

return Locale


function LoadLocale(language)
    local filePath = ("locales/%s.json"):format(language:lower())
    local raw = LoadResourceFile(GetCurrentResourceName(), filePath)

    if not raw then
        print(("^1[ERROR]^r Locale file for '%s' not found."):format(language))
        return {}
    end

    local parsed = json.decode(raw)
    if type(parsed) == "table" then
        return parsed
    else
        print(("^1[ERROR]^r Failed to parse JSON locale file for '%s'."):format(language))
        return {}
    end
end

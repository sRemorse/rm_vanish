config = {}

-- Provide extra printing to the console.
config.debug = false

config.language = "en" 
-- Supported Languages (Case-Sensitive)
-- EN

local language = string.lower(config.language or "en")
Locale.Load(language)
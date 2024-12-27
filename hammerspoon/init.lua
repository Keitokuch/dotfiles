-- hs.application.enableSpotlightForNameSearches(true)

-- AppToggle
local app_mod = "alt"
local apps = {
  { app_mod, "z", "Notion" },
  { app_mod, "c", "company.thebrowser.Browser" },
  { app_mod, "v", "Slack" },
  { app_mod, "b", "Finder" },
  { app_mod, "n", "Numi" },
  { app_mod, "d", "Dash" },
  { app_mod, "s", "Reminders" },
  { app_mod, "space", "com.googlecode.iterm2" },
  { { "alt" }, "e", "Calendar" }
}
hs.loadSpoon("AppToggle")
spoon.AppToggle:setMap(apps)

-- ShiftIt
local shiftit = {
  left = {{ 'ctrl', 'cmd' }, 'left' },
  right = {{ 'ctrl', 'cmd' }, 'right' },
  up = {{ 'ctrl', 'cmd' }, 'up' },
  down = {{ 'ctrl', 'cmd' }, 'down' },
  maximum = {{ 'ctrl', 'cmd' }, 'm' },
}

hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys(shiftit)

-- hs.loadSpoon("AppKeyMap")
-- spoon.AppKeyMap:setAppMap("Google Chrome", {
--     { {'ctrl'}, 'c', {}, 'escape' },
--   })
-- spoon.AppKeyMap:setAppMap("Dash", {
--     { {'ctrl'}, 'd', {}, 'down' },
--     { {'ctrl'}, 'u', {}, 'up' }
--   })
-- spoon.AppKeyMap:setAppMap("PDF Expert", {
--     { {'ctrl'}, 'd', {'ctrl'}, 'down' },
--     { {'ctrl'}, 'u', {'ctrl'}, 'up' }
--   })

status, err = pcall(require, "initLocal")

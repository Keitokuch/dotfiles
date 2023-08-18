hs.application.enableSpotlightForNameSearches(true)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)


local app_mod = "alt"
local apps = {
  { app_mod, "z", "Notion" },
  -- { app_mod, "z", "Mark Text" },
  { app_mod, "x", "PDF Expert" },
  { app_mod, "c", "Google Chrome" },
  { app_mod, "v", "WeChat" },
  { app_mod, "b", "Finder" },
  { app_mod, "n", "Numi" },
  { app_mod, "d", "Dash" },
  { app_mod, "f", "Opera" },
  { app_mod, "s", "Things" },
  { app_mod, "space", "iTerm2" },
  { { "alt", "shift" }, "c", "Calendar" }
}

hs.loadSpoon("AppToggle")
spoon.AppToggle:setMap(apps)

local shiftit = {
  left = {{ 'ctrl', 'cmd' }, 'left' },
  right = {{ 'ctrl', 'cmd' }, 'right' },
  up = {{ 'ctrl', 'cmd' }, 'up' },
  down = {{ 'ctrl', 'cmd' }, 'down' },
  maximum = {{ 'ctrl', 'cmd' }, 'm' },
}

hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys(shiftit)

hs.loadSpoon("AppKeyMap")
spoon.AppKeyMap:setAppMap("Google Chrome", {
    { {'ctrl'}, 'c', {}, 'escape' },
  })
spoon.AppKeyMap:setAppMap("Dash", {
    { {'ctrl'}, 'j', {}, 'down' },
    { {'ctrl'}, 'k', {}, 'up' }
  })
spoon.AppKeyMap:setAppMap("PDF Expert", {
    { {'ctrl'}, 'j', {'ctrl'}, 'down' },
    { {'ctrl'}, 'k', {'ctrl'}, 'up' }
  })

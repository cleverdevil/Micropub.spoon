# Micropub.spoon

Publish to a [Micropub](https://indieweb.org/Micropub) endpoint in Hammerspoon.

## Example

```lua
-- Micropub
hs.loadSpoon('Micropub')
spoon.Micropub.micropub_endpoint_url = 'https://example.com/micropub'
spoon.Micropub.micropub_token = 'XXXXXXXXXXXXXXXXXXXXXXX'

hs.hotkey.bind(hyper, 'p', function()
    local btn, note = hs.dialog.textPrompt(
      'New Note',
      'Your note:',
      '',
      'Publish',
      'Cancel'
    )

    if btn ~= 'Publish' then
        return
    end

    spoon.Micropub:publishNote(note)
end)
```

The `publish` method accepts MF2 structured data as a lua table, if you want to
send across other data.

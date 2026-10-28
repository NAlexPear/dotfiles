-- Rex config. Theme, font, and other app settings live in Rex Settings, not here.

-- Shift+Enter types a newline, as in Ghostty (keybind = shift+enter=text:\n).
rex.bind("shift+enter", function(ctx, ev)
  rex.block.call("com.superlogical.terminal", "write", { data = "\n" })
  return true
end)

-- Vi-style pane mode, like Vim's Ctrl-W window commands.
-- Cmd+Escape enters it. Escape, i, or Enter goes back to typing.
rex.mode("pane", { exclusive = true })
rex.bind("cmd+escape", "client.mode.enter", { name = "pane" })

rex.bind("pane/i", "client.mode.exit")
rex.bind("pane/enter", "client.mode.exit")

rex.bind("pane/h", "pane.focus.left")
rex.bind("pane/j", "pane.focus.down")
rex.bind("pane/k", "pane.focus.up")
rex.bind("pane/l", "pane.focus.right")
rex.bind("pane/w", "pane.focus_next")
rex.bind("pane/shift+w", "pane.focus_previous")

rex.bind("pane/shift+h", "pane.move.left")
rex.bind("pane/shift+j", "pane.move.down")
rex.bind("pane/shift+k", "pane.move.up")
rex.bind("pane/shift+l", "pane.move.right")

rex.bind("pane/ctrl+h", "pane.resize", { direction = "left" })
rex.bind("pane/ctrl+j", "pane.resize", { direction = "down" })
rex.bind("pane/ctrl+k", "pane.resize", { direction = "up" })
rex.bind("pane/ctrl+l", "pane.resize", { direction = "right" })
rex.bind("pane/=", "pane.balance")

rex.bind("pane/s", "pane.split.down")
rex.bind("pane/v", "pane.split.right")
rex.bind("pane/z", "pane.zoom")
rex.bind("pane/q", "pane.close")

rex.bind("pane/g>t", "client.tab.next")
rex.bind("pane/g>shift+t", "client.tab.previous")
rex.bind("pane/t", "client.tab.new")

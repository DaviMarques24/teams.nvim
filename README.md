# team.nvim

> Real-time collaboration for Neovim via TCP — simple, fast, and minimal.

## ✨ Overview

`team.nvim` allows two or more users to share the same buffer in real time using just Neovim and TCP connections. Perfect for pair programming, collaborative TDD sessions, or teaching.

---

## 📦 Installation

### Lazy.nvim
```lua
{
  "DaviMarques24/teams.nvim",
  config = function()
    require("team").setup()
  end
},
```

### Packer.nvim
```lua
use {
  "your-user/team.nvim",
  config = function()
    require("team").setup()
  end
},
```

---

## Commands

### `:TeamStart [port]`
Starts a local TCP server (default port: `7777`).

### `:TeamJoin host:port`
Connects to a remote host running `:TeamStart`.

---

## Example usage (in two terminals):

**Terminal A:**
```vim
:TeamStart
```

**Terminal B:**
```vim
:TeamJoin 127.0.0.1:7777
```

Edits made on either side are reflected in real time.

---

## ⚠️ Limitations (v0.1)
- Sync sends the entire buffer (not just diffs).
- Only the current buffer is synchronized.
- No support for multiple buffers or ghost cursors yet.

---

## Roadmap
- [ ] Ghost cursor
- [ ] Multi-buffer support
- [ ] Built-in chat interface
- [ ] Optional WebRTC / TLS
- [ ] Review or read-only mode

---

## 👥 Contributing
Pull requests are welcome! Any improvements in performance, UI, or security are appreciated.

---

## Contact
davifm2010@icloud.com

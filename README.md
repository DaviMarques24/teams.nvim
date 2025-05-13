<img src="https://sdmntpreastus.oaiusercontent.com/files/00000000-7ac0-61f9-9292-1d101f6cdde8/raw?se=2025-05-13T21%3A48%3A47Z&sp=r&sv=2024-08-04&sr=b&scid=00000000-0000-0000-0000-000000000000&skoid=31bc9c1a-c7e0-460a-8671-bf4a3c419305&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-05-13T20%3A33%3A03Z&ske=2025-05-14T20%3A33%3A03Z&sks=b&skv=2024-08-04&sig=pN1AgUH9zW/%2BPMsHF00HEokfzWCwIGzxiD10dfnDi40%3D">

# team.nvim


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
  "DaviMarques24/teams.nvim",
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

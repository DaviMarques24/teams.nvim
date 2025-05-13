-- team.nvim - MVP inicial para colaboração em tempo real no Neovim
-- Requer Neovim 0.8+ (com suporte a vim.loop)

local uv = vim.loop
local M = {}

-- estado interno
local server = nil
local client = nil
local peers = {}

-- Inicializa servidor TCP
function M.start_server(port)
	port = port or 7777
	server = uv.new_tcp()
	server:bind("0.0.0.0", port)
	server:listen(128, function(err)
		if err then
			vim.schedule(function()
				vim.notify("[team.nvim] Erro no servidor: " .. err, vim.log.levels.ERROR)
			end)
			return
		end
		local peer = uv.new_tcp()
		server:accept(peer)
		table.insert(peers, peer)
		vim.schedule(function()
			vim.notify("[team.nvim] Novo cliente conectado")
		end)

		peer:read_start(function(err2, chunk)
			if err2 then
				vim.schedule(function()
					vim.notify("[team.nvim] Erro no cliente: " .. err2, vim.log.levels.ERROR)
				end)
				return
			end
			if chunk then
				local ok, data = pcall(vim.fn.json_decode, chunk)
				if ok and data.lines then
					vim.api.nvim_buf_set_lines(0, 0, -1, false, data.lines)
				end
			end
		end)
	end)
	vim.schedule(function()
		vim.notify("[team.nvim] Servidor iniciado na porta " .. port)
	end)
end

-- Conecta como cliente TCP
function M.connect_to_server(host, port)
	port = tonumber(port) or 7777
	client = uv.new_tcp()
	client:connect(host, port, function(err)
		if err then
			vim.schedule(function()
				vim.notify("[team.nvim] Erro ao conectar: " .. err, vim.log.levels.ERROR)
			end)
			return
		end
		vim.schedule(function()
			vim.notify("[team.nvim] Conectado a " .. host .. ":" .. port)
		end)
	end)
end

-- Observa mudanças no buffer e envia
function M.attach_buffer()
	vim.api.nvim_buf_attach(0, false, {
		on_lines = function(_, _, _, first, last, _, new_last)
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			local msg = vim.fn.json_encode({ lines = lines })
			if client then
				client:write(msg)
			end
			for _, peer in ipairs(peers) do
				peer:write(msg)
			end
		end,
	})
	vim.schedule(function()
		vim.notify("[teams.nvim] Buffer attached to team")
	end)
end

-- comandos do usuário
vim.api.nvim_create_user_command("TeamStart", function(opts)
	M.start_server(tonumber(opts.args))
	M.attach_buffer()
end, { nargs = "?" })

vim.api.nvim_create_user_command("TeamJoin", function(opts)
	local host, port = string.match(opts.args, "([^:]+):?(%d*)")
	M.connect_to_server(host, port)
	M.attach_buffer()
end, { nargs = 1 })

return M

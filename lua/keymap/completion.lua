local bind = require("keymap.bind")
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local plug_map = {
	["n|<A-f>"] = map_cmd("<Cmd>FormatToggle<CR>"):with_noremap():with_desc("Formater: Toggle format on save"),
}
bind.nvim_load_mapping(plug_map)

local function diagnostic_goto(next, severity)
	local diagnostic = require("lspsaga.diagnostic")
	severity = severity and vim.diagnostic.severity[severity] or nil

	return function()
		if next then
			diagnostic:goto_next({ severity = severity })
		else
			diagnostic:goto_prev({ severity = severity })
		end
	end
end

local mapping = {}

function mapping.lsp(buf)
	local map = {
		-- LSP-related keymaps, work only when event = { "InsertEnter", "LspStart" }
		["n|<leader>li"] = map_cr("LspInfo"):with_buffer(buf):with_desc("lsp: Info"),
		["n|<leader>lr"] = map_cr("LspRestart"):with_buffer(buf):with_nowait():with_desc("lsp: Restart"),
		["n|<leader>o"] = map_cr("Lspsaga outline"):with_buffer(buf):with_desc("lsp: Toggle outline"),
		["n|[w"] = map_callback(diagnostic_goto(false, "WARN")):with_buffer(buf):with_desc("lsp: Prev warning"),
		["n|]w"] = map_callback(diagnostic_goto(true, "WARN")):with_buffer(buf):with_desc("lsp: Next warning"),
		["n|]e"] = map_callback(diagnostic_goto(false, "ERROR")):with_buffer(buf):with_desc("lsp: Prev error"),
		["n|[e"] = map_callback(diagnostic_goto(true, "ERROR")):with_buffer(buf):with_desc("lsp: Next error"),
		["n|<leader>ld"] = map_cr("Lspsaga show_line_diagnostics"):with_buffer(buf):with_desc("lsp: Line diagnostic"),
		["n|gs"] = map_callback(function()
			vim.lsp.buf.signature_help()
		end):with_desc("lsp: Signature help"),
		["n|ra"] = map_cr("Lspsaga rename"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		["n|<leader>ra"] = map_cr("Lspsaga rename ++project")
			:with_buffer(buf)
			:with_desc("lsp: Rename in project range"),
		["n|K"] = map_cr("Lspsaga hover_doc"):with_buffer(buf):with_desc("lsp: Show doc"),
		["nv|<leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action for cursor"),
		["n|gD"] = map_cr("Lspsaga peek_definition"):with_buffer(buf):with_desc("lsp: Preview definition"),
		["n|gd"] = map_cr("Lspsaga goto_definition"):with_buffer(buf):with_desc("lsp: Goto definition"),
		["n|gr"] = map_cr("Lspsaga lsp_finder"):with_buffer(buf):with_desc("lsp: Show reference"),
		["n|<leader>ci"] = map_cr("Lspsaga incoming_calls"):with_buffer(buf):with_desc("lsp: Show incoming calls"),
		["n|<leader>co"] = map_cr("Lspsaga outgoing_calls"):with_buffer(buf):with_desc("lsp: Show outgoing calls"),
	}
	bind.nvim_load_mapping(map)
end

return mapping

local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {
	-- format
	["n|<leader>fm"] = map_callback(function()
		vim.lsp.buf.format({ async = true })
	end):with_desc("edit: LSP format"),

	-- Plugin: accelerate-jk
	["n|j"] = map_callback(function()
		return et("<Plug>(accelerated_jk_gj)")
	end):with_expr(),
	["n|k"] = map_callback(function()
		return et("<Plug>(accelerated_jk_gk)")
	end):with_expr(),

	-- Plugin: auto_session
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sr"] = map_cu("SessionRestore"):with_noremap():with_silent():with_desc("session: Restore"),
	["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: nvim-bufdel
	["n|<leader>x"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("buffer: Close current"),
	["n|<leader>X"] = map_cr("BufDelOthers"):with_noremap():with_silent():with_desc("buffer: Close other buffers"),

	-- Plugin: clever-f
	["n|;"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-forward)")
	end):with_expr(),
	["n|,"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-back)")
	end):with_expr(),

	["n|<A-O>"] = map_callback(function()
		local ts = require("typescript").actions
		ts.addMissingImports({ sync = true })
		ts.organizeImports()
		ts.removeUnused()
	end):with_desc("Organize imports"),

	-- Plugin: comment.nvim
	["n|<C-/>"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|<C-\\>"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	-- ["n|<C-/>"] = map_cmd("<Plug>(comment_toggle_linewise)")
	-- 	:with_silent()
	-- 	:with_noremap()
	-- 	:with_desc("edit: Toggle comment for line with operator"),
	-- ["n|<C-\\>"] = map_cmd("<Plug>(comment_toggle_blockwise)")
	-- 	:with_silent()
	-- 	:with_noremap()
	-- 	:with_desc("edit: Toggle comment for block with operator"),
	["v|<C-/>"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["v|<C-\\>"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin: diffview
	["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: vim-easy-align
	["nx|gea"] = map_cr("EasyAlign"):with_desc("edit: Align with delimiter"),

	-- Plugin: hop
	["nv|<leader>w"] = map_cmd("<Cmd>HopWord<CR>"):with_noremap():with_desc("jump: Goto word"),
	["nv|<leader>j"] = map_cmd("<Cmd>HopLine<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>k"] = map_cmd("<Cmd>HopLine<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>c"] = map_cmd("<Cmd>HopChar1<CR>"):with_noremap():with_desc("jump: Goto one char"),
	["nv|<leader>cc"] = map_cmd("<Cmd>HopChar2<CR>"):with_noremap():with_desc("jump: Goto two chars"),

	-- Plugin: treehopper
	["o|m"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin: tabout
	-- ["i|<A-l>"] = map_cmd("<Plug>(TaboutMulti)"):with_silent():with_noremap():with_desc("edit: Goto end of pair"),
	-- ["i|<A-h>"] = map_cmd("<Plug>(TaboutBackMulti)"):with_silent():with_noremap():with_desc("edit: Goto begin of pair"),

	-- Plugin suda.vim
	["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("editn: Save file using sudo"),
}

bind.nvim_load_mapping(plug_map)

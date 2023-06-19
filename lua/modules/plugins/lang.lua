local lang = {}

lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	ft = "markdown",
	build = ":call mkdp#util#install()",
}
lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
lang["jose-elias-alvarez/typescript.nvim"] = {
	dependencies = "neovim/nvim-lspconfig",
	event = "LspAttach",
	config = function()
		require("typescript").setup({
			server = {
				root_dir = require("lspconfig").util.root_pattern("package.json"),
				single_file_support = false,
			},
		})
	end,
}
return lang

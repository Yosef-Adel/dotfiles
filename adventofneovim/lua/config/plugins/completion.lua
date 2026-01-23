return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },

	version = '1.*',

	opts = {
		keymap = { preset = 'default' },
		appearance = {
			nerd_font_variant = 'mono'
		},

		-- here you can add the llms as sources
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		signature = { enable = true },
	},
}

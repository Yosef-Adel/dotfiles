local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("gitcommit", {
	-- feat snippet
	s("feat", {
		t("feat"),
		i(1, "(scope)"),
		t(": "),
		i(2, "description"),
		t({ "", "" }),
		i(3, "Optional body"),
		t({ "", "" }),
		i(4, "Optional footer"),
	}),

	-- fix snippet
	s("fix", {
		t("fix"),
		i(1, "(scope)"),
		t(": "),
		i(2, "description"),
		t({ "", "" }),
		i(3, "Optional body"),
		t({ "", "" }),
		i(4, "Optional footer"),
	}),

	-- chore snippet
	s("chore", {
		t("chore"),
		i(1, "(scope)"),
		t(": "),
		i(2, "description"),
		t({ "", "" }),
		i(3, "Optional body"),
		t({ "", "" }),
		i(4, "Optional footer"),
	}),

	-- docs snippet
	s("docs", {
		t("docs"),
		i(1, "(scope)"),
		t(": "),
		i(2, "description"),
		t({ "", "" }),
		i(3, "Optional body"),
		t({ "", "" }),
		i(4, "Optional footer"),
	}),

	-- BREAKING CHANGE snippet
	s("breaking", {
		t("BREAKING CHANGE: "),
		i(1, "description"),
		t({ "", "" }),
		i(2, "Optional body"),
		t({ "", "" }),
		i(3, "Optional footer"),
	}),

	-- Custom type snippet
	s("type", {
		i(1, "type"),
		t("("),
		i(2, "scope"),
		t("): "),
		i(3, "description"),
		t({ "", "" }),
		i(4, "Optional body"),
		t({ "", "" }),
		i(5, "Optional footer"),
	}),

	-- Revert snippet
	s("revert", {
		t("revert: "),
		i(1, "description"),
		t({ "", "" }),
		t("Refs: "),
		i(2, "commit SHA"),
		t({ "", "" }),
		i(3, "Optional body"),
	}),

	-- Commit with ! for breaking change
	s("bang", {
		i(1, "type"),
		t("!"),
		i(2, "(scope)"),
		t(": "),
		i(3, "description"),
		t({ "", "" }),
		i(4, "Optional body"),
		t({ "", "" }),
		i(5, "Optional footer"),
	}),
})

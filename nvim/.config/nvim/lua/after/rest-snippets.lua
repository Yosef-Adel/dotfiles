local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("rest", {
	-- GET request snippet
	s("get", {
		t("# GET Request"),
		t({ "", "" }),
		i(1, "https://example.com"),
		t({ "", "GET " }),
		i(2, "/resource"),
		t({ "", "" }),
	}),

	-- POST request snippet
	s("post", {
		t("# POST Request"),
		t({ "", "" }),
		i(1, "https://example.com"),
		t({ "", "POST " }),
		i(2, "/resource"),
		t({ "", "Content-Type: application/json; charset=UTF-8", "" }),
		t("{"),
		t({ "", '  "' }),
		i(3, "key"),
		t('": "'),
		i(4, "value"),
		t('"'),
		t({ "", "}" }),
		t({ "", "" }),
	}),

	-- PUT request snippet
	s("put", {
		t("# PUT Request"),
		t({ "", "" }),
		i(1, "https://example.com"),
		t({ "", "PUT " }),
		i(2, "/resource"),
		t({ "", "Content-Type: application/json; charset=UTF-8", "" }),
		t("{"),
		t({ "", '  "id": ' }),
		i(3, "1"),
		t(","),
		t({ "", '  "' }),
		i(4, "key"),
		t('": "'),
		i(5, "updated value"),
		t('"'),
		t({ "", "}" }),
		t({ "", "" }),
	}),

	-- DELETE request snippet
	s("delete", {
		t("# DELETE Request"),
		t({ "", "" }),
		i(1, "https://example.com"),
		t({ "", "DELETE " }),
		i(2, "/resource"),
		t({ "", "" }),
	}),

	-- PATCH request snippet
	s("patch", {
		t("# PATCH Request"),
		t({ "", "" }),
		i(1, "https://example.com"),
		t({ "", "PATCH " }),
		i(2, "/resource"),
		t({ "", "Content-Type: application/json; charset=UTF-8", "" }),
		t("{"),
		t({ "", '  "' }),
		i(3, "key"),
		t('": "'),
		i(4, "patched value"),
		t('"'),
		t({ "", "}" }),
		t({ "", "" }),
	}),

	-- HEAD request snippet
	s("head", {
		t("# HEAD Request"),
		t({ "", "" }),
		i(1, "https://example.com"),
		t({ "", "HEAD " }),
		i(2, "/resource"),
		t({ "", "" }),
	}),

	-- Header snippet
	s("header", {
		t("Content-Type: "),
		i(1, "application/json"),
		t({ "; charset=UTF-8", "", "Authorization: Bearer " }),
		i(2, "your-token-here"),
		t({ "", "" }),
	}),
})
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

vim.keymap.set({ "i", "s" }, "<A-n>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set({ "i", "s" }, "<A-n>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<A-p>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- React component snippet
ls.add_snippets("typescriptreact", {
	s("rfc", {
		t("import React from 'react';"),
		t({ "", "" }),
		t("interface Props {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "}" }),
		t({ "", "" }),
		t("const "),
		i(2, "ComponentName"),
		t(": React.FC<Props> = ({ "),
		i(3),
		t(" }) => {"),
		t({ "", "\treturn (" }),
		t({ "", "\t\t<div>" }),
		i(4),
		t({ "", "\t\t</div>" }),
		t({ "", "\t);" }),
		t({ "", "};" }),
		t({ "", "" }),
		t("export default "),
		rep(2),
		t(";"),
	}),
})

-- useState hook snippet
ls.add_snippets("typescriptreact", {
	s("us", {
		t("const ["),
		i(1, "state"),
		t(", set"),
		rep(1),
		t("] = useState("),
		i(2),
		t(");"),
	}),
})

-- useEffect hook snippet
ls.add_snippets("typescriptreact", {
	s("ue", {
		t("useEffect(() => {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "" }),
		t("}, ["),
		i(2),
		t("]);"),
	}),
})

-- React Router Link snippet
ls.add_snippets("typescriptreact", {
	s("link", {
		t("import { Link } from 'react-router-dom';"),
		t({ "", "" }),
		t('<Link to="'),
		i(1, "/path"),
		t('">'),
		i(2, "Link Text"),
		t("</Link>"),
	}),
})

-- Next.js getServerSideProps snippet
ls.add_snippets("typescriptreact", {
	s("gssp", {
		t("export const getServerSideProps: GetServerSideProps = async (context) => {"),
		t({ "", "\t" }),
		t("return {"),
		t({ "", "\t\tprops: { " }),
		i(1, "data"),
		t(" },"),
		t({ "", "\t};" }),
		t({ "", "};" }),
	}),
})

-- Next.js getStaticProps snippet
ls.add_snippets("typescriptreact", {
	s("gsp", {
		t("export const getStaticProps: GetStaticProps = async (context) => {"),
		t({ "", "\t" }),
		t("return {"),
		t({ "", "\t\tprops: { " }),
		i(1, "data"),
		t(" },"),
		t({ "", "\t};" }),
		t({ "", "};" }),
	}),
})

-- Next.js getStaticPaths snippet
ls.add_snippets("typescriptreact", {
	s("gspaths", {
		t("export const getStaticPaths: GetStaticPaths = async () => {"),
		t({ "", "\t" }),
		t("return {"),
		t({ "", "\t\tpaths: []," }), -- Add paths logic as needed
		t({ "", "\t\tfallback: false," }),
		t({ "", "\t};" }),
		t({ "", "};" }),
	}),
})

-- React Context snippet
ls.add_snippets("typescriptreact", {
	s("context", {
		t("import React, { createContext, useContext, useState } from 'react';"),
		t({ "", "" }),
		t("const "),
		i(1, "ContextName"),
		t("Context = createContext<"),
		i(2, "ContextType"),
		t(" | undefined>(undefined);"),
		t({ "", "" }),
		t("const "),
		rep(1),
		t("Provider: React.FC = ({ children }) => {"),
		t({ "", "\tconst [state, setState] = useState<" }),
		rep(2),
		t(">();"),
		t({ "", "" }),
		t({ "", "\treturn (" }),
		t({ "", "\t\t<" }),
		rep(1),
		t("Context.Provider value={{ state, setState }}>"),
		t({ "", "\t\t\t{children}" }),
		t({ "", "\t\t</" }),
		rep(1),
		t("Context.Provider>"),
		t({ "", "\t);" }),
		t({ "", "};" }),
		t({ "", "" }),
		t("const use"),
		rep(1),
		t(" = () => {"),
		t({ "", "\tconst context = useContext(" }),
		rep(1),
		t("Context);"),
		t({ "", "\tif (context === undefined) {", "\t\t" }),
		t("throw new Error('use"),
		rep(1),
		t(" must be used within a "),
		rep(1),
		t("Provider');"),
		t({ "", "\t}" }),
		t({ "", "\treturn context;" }),
		t({ "", "};" }),
		t({ "", "" }),
		t("export { "),
		rep(1),
		t("Provider, use"),
		rep(1),
		t(" };"),
	}),
})

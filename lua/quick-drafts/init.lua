local M = {}

function DraftDatedFile(path)
	local date = os.date("%Y-%m-%d %H%M")
	return drafts_root .. path .. date .. ".md"
end

function DraftNew()
	vim.cmd("e" .. DraftDatedFile(""))
end

function DraftStandup()
	vim.cmd("e" .. DraftDatedFile("standup/"))
end

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*/standup/*.md",
	callback = function(_)
		vim.cmd("0r ~/dotvim/templates/standup.skeleton")
	end,
	desc = "Template standup",
})

M.draft_new = DraftNew
M.draft_standup = DraftStandup

function M.setup(opts)
	opts = opts or {}
	drafts_root = opts.root
	vim.keymap.set("n", "<Leader>dn", "<cmd>lua DraftNew()<CR>", { silent = true })
	vim.keymap.set("n", "<Leader>ds", "<cmd>lua DraftStandup()<CR>", { silent = true })
	vim.keymap.set("n", "<Leader>dt", "<cmd>15split " .. drafts_root .. "tasks.md<CR>", { silent = true })
end
return M

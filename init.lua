require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

 -- gen.nvim
require('gen').prompts['1_Explain_Code'] = {
  prompt = "Explain following code:\n$text",
  replace = false
}
require('gen').prompts['2_Generate_Docs'] = {
  prompt = "Generate documentation for the following code block:\n$text\n Use the most popular documentation tool for the language $filetype. If you don't know infer the tool.",
  replace = false
}
require('gen').prompts['3_Commit_Msg'] = {
  prompt = "You are a helpful assistant to a programmer. Generate concise git commit message, based on following diff. Do not explain the code. Make the message short and concise. Use bullet points when necessary:\n$text",
  replace = false
}
require('gen').prompts['4_Add_Tests'] = {
  prompt = "Write unit tests for the following code block:\n$text\n Please use gtest testing library suitable for the language of the code. The language is: $filetype. ",
  replace = false
}
require('gen').prompts['5_Add_Mock'] = {
  prompt = "Write mock for the following code block:\n$text\n Please use gmock testing library suitable for the language of the code. The language is: $filetype. ",
  replace = false
}
require('gen').prompts['Elaborate_Text'] = {
  prompt = "Elaborate the following text:\n$text",
  replace = true
}
require('gen').prompts['Fix_Code'] = {
  prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  replace = true,
  extract = "```$filetype\n(.-)```"
}

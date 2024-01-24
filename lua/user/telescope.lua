local M = {
  'nvim-telescope/telescope.nvim',
  name = 'telescope',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  -- local trouble = require('trouble.providers.telescope')
  local actions = require('telescope.actions')
  local telescope = require('telescope')
  telescope.load_extension('dap')
  telescope.setup {
    defaults = {
      prompt_prefix = '  ',
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = {
        ".git/",
        "target/",
        "docs/",
        "vendor/*",
        "%.lock",
        "__pycache__/*",
        "%.sqlite3",
        "%.ipynb",
        "node_modules/*",
        -- "%.jpg",
        -- "%.jpeg",
        -- "%.png",
        "%.svg",
        "%.otf",
        "%.ttf",
        "%.webp",
        ".dart_tool/",
        ".github/",
        ".gradle/",
        ".idea/",
        ".settings/",
        ".vscode/",
        "__pycache__/",
        "build/",
        "env/",
        "gradle/",
        "node_modules/",
        "%.pdb",
        "%.dll",
        "%.class",
        "%.exe",
        "%.cache",
        "%.ico",
        "%.pdf",
        "%.dylib",
        "%.jar",
        "%.docx",
        "%.met",
        "smalljre_*/*",
        ".vale/",
        "%.burp",
        "%.mp4",
        "%.mkv",
        "%.rar",
        "%.zip",
        "%.7z",
        "%.tar",
        "%.bz2",
        "%.epub",
        "%.flac",
        "%.tar.gz",
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<c-d>"] = require("telescope.actions").delete_buffer,

          -- ["<C-u>"] = actions.preview_scrolling_up,
          -- ["<C-d>"] = actions.preview_scrolling_down,

          -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<Tab>"] = actions.close,
          ["<S-Tab>"] = actions.close,
          -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-h>"] = actions.which_key,   -- keys from pressing <C-h>
          ["<esc>"] = actions.close,
          -- ["<c-t>"] = trouble.open_with_trouble,
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,

          -- ["<Tab>"] = actions.close,
          -- ["<S-Tab>"] = actions.close,
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,
          ["q"] = actions.close,
          ["dd"] = require("telescope.actions").delete_buffer,
          ["s"] = actions.select_horizontal,
          ["v"] = actions.select_vertical,
          ["t"] = actions.select_tab,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
          -- ["<c-t>"] = trouble.open_with_trouble
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
      },
      grep_string = {
        theme = "dropdown",
      },
      find_files = {
        theme = "dropdown",
        previewer = false,
        hidden = true
      },
      git_files = {
        theme = "dropdown",
        previewer = false,
        hidden = true
      },
      fd = {
        theme = "dropdown",
        previewer = false,
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      colorscheme = {
        -- enable_preview = true,
      },
      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
  }

  local wk = require 'which-key'
  wk.register {
    ['<leader>?'] = {require('telescope.builtin').oldfiles, '[?] Find recently opened files'},
    ['<leader><space>'] = {require('telescope.builtin').buffers, '[ ] Find existing buffers'},
    ['<leader>/'] = {
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      '[/] Fuzzily search in current buffer'
    },
    ['<leader>fG'] = { require('telescope.builtin').git_files, 'Git Files' },
    ['<leader>ff'] = { require('telescope.builtin').find_files, 'Files' },
    ['<leader>fh'] = { require('telescope.builtin').help_tags, 'Help' },
    ['<leader>fw'] = { require('telescope.builtin').grep_string, 'Current Word' },
    ['<leader>fg'] = { require('telescope.builtin').live_grep, 'Grep' },
    ['<leader>fd'] = { require('telescope.builtin').diagnostics, 'Diagnostics' },
  }
end

return M

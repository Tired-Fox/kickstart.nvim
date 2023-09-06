return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
    keymaps = {
      { "n", "<leader>ns", "<cmd>Neorg sync-parsers<cr>",     desc = "Sync neorg parsers" },
      { "n", "<leader>nf", "<cmd>Neorg sync-filters<cr>",     desc = "Sync neorg filters" },
      { "n", "<leader>ni", "<cmd>Neorg index<cr>",            desc = "Neorg workspace index" },
      { "n", "<leader>nt", "<cmd>Neorg toggle-concealer<cr>", desc = "Neorg toggle concealer" },
    },
    opts = {
    },
    config = function()
      vim.keymap.set("n", "<leader>ns", "<cmd>Neorg sync-parsers<cr>")
      vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<cr>")
      vim.keymap.set("n", "<leader>nc", "<cmd>Neorg toggle-concealer<cr>")
      vim.keymap.set("n", "<leader>nt", "<cmd>Neorg toc<cr>")
      vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<cr>")
      vim.keymap.set("n", "<leader>nf", "<cmd>Telescope neorg find_norg_files<cr>")
      vim.keymap.set("n", "<leader>nw", "<cmd>Telescope neorg switch_workspace<cr>")
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.integrations.telescope"] = {},
          ["core.journal"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          },
          ["core.qol.toc"] = {
            config = {
              close_after_use = true,
            }
          },
          ["core.keybinds"] = {
            config = {
              neorg_leader = ",",
            }
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Documents/notes"
              },
              index = "index.norg",
              default_workspace = "notes"
            }
          }
        }
      })

      local neorg_callbacks = require("neorg.core.callbacks")

      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = { -- Bind keys in normal mode
            { "<C-s>", "core.integrations.telescope.search_headings" },
          },

          i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
            { "<C-f>", "core.integrations.telescope.insert_file_link" },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)
    end
  },
}

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>oo', '<cmd>Obsidian open<CR>', desc = 'Obsidian: Open in app' },
    { '<leader>on', '<cmd>Obsidian new<CR>', desc = 'Obsidian: New note' },
    { '<leader>ot', '<cmd>Obsidian template<CR>', desc = 'Obsidian: Insert template' },
    { '<leader>od', '<cmd>Obsidian today<CR>', desc = 'Obsidian: Today' },
    { '<leader>oy', '<cmd>Obsidian yesterday<CR>', desc = 'Obsidian: Yesterday' },
    { '<leader>ob', '<cmd>Obsidian backlinks<CR>', desc = 'Obsidian: Backlinks' },
    { '<leader>os', '<cmd>Obsidian search<CR>', desc = 'Obsidian: Search' },
    { '<leader>ol', '<cmd>Obsidian links<CR>', desc = 'Obsidian: Links' },
    { '<leader>op', '<cmd>Obsidian paste_img<CR>', desc = 'Obsidian: Paste Img' },
    { '<leader>of', '<cmd>Obsidian follow_link vsplit<CR>', desc = 'Obsidian: Open Link vsplit' },
  },

  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = 'personal',
        path = vim.fn.expand '~/obsidian/obsvault',
      },
    },

    attachments = {
      img_folder = '/Attachments',
    },

    notes_subdir = '00 - Inbox',

    daily_notes = {
      folder = '05 - Daily',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      template = 'daily.md',
    },

    templates = {
      subdir = 'Templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },

    preferred_link_style = 'wiki',
    new_notes_location = 'notes_subdir',

    completion = {
      blink = true,
      nvim_cmp = false,
      min_chars = 1,
    },

    note_id_func = function(title)
      local today = os.date '%Y-%m-%d'

      -- Daily notes: title == today's date
      if title == today then
        return title
      end

      -- Normal notes: date + slug
      local suffix = ''
      if title then
        suffix = '-' .. title:gsub(' ', '-'):lower()
      end

      return today .. suffix
    end,

    formatter_func = function(note)
      local out = {
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
      }
      if note.metadata and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
  },
}

local t = require('test.testutil')
local n = require('test.functional.testnvim')()

local eq = t.eq
local exec_lua = n.exec_lua
local pcall_err = t.pcall_err
local matches = t.matches

describe('lsp-handlers', function()
  describe('vim.lsp._with_extend', function()
    it('should return a table with the default keys', function()
      eq(
        { hello = 'world' },
        exec_lua(function()
          return vim.lsp._with_extend('test', { hello = 'world' })
        end)
      )
    end)

    it('should override with config keys', function()
      eq(
        { hello = 'universe', other = true },
        exec_lua(function()
          return vim.lsp._with_extend(
            'test',
            { other = true, hello = 'world' },
            { hello = 'universe' }
          )
        end)
      )
    end)

    it('should not allow invalid keys', function()
      matches(
        '.*Invalid option for `test`.*',
        pcall_err(exec_lua, function()
          return vim.lsp._with_extend('test', { hello = 'world' }, { invalid = true })
        end)
      )
    end)
  end)
end)

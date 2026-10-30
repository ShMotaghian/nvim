-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- Appearance of diagnostics
vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
    -- Add a custom format function to show error codes
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = 'always', -- Or "if_many"
  },
  -- Make diagnostic background transparent
  on_ready = function()
    vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
  end,
}

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets('matlab', {
  s('func', {
    t 'function ',
    i(1, 'out'),
    t ' = ',
    i(2, 'name'),
    t '(',
    i(3),
    t ')',
    t { '', '    ' },
    i(0),
    t { '', 'end' },
  }),

  s('fori', {
    t 'for ',
    i(1, 'i'),
    t ' = ',
    i(2, '1'),
    t ':',
    i(3, 'n'),
    t { '', '    ' },
    i(0),
    t { '', 'end' },
  }),

  s('if', {
    t 'if ',
    i(1, 'condition'),
    t { '', '    ' },
    i(0),
    t { '', 'end' },
  }),

  s('classdef', {
    t 'classdef ',
    i(1, 'MyClass'),
    t ' < ',
    i(2, 'handle'),
    t { '', '    properties' },
    t { '', '        ' },
    i(3, 'PropertyName'),
    t { '', '    end', '', '    methods' },
    t { '', '        function obj = ' },
    i(4, 'MyClass'),
    t '(',
    i(5),
    t ')',
    t { '', '            ' },
    i(6, '% constructor code'),
    t { '', '        end', '', '        ' },
    i(0, '-- other methods'),
    t { '', '    end', 'end' },
  }),

  s('methods', {
    t 'methods ',
    t '(',
    t 'Access ',
    t '=',
    i(1, ' public'),
    t ')',
    t { '', '    ' },
    i(0),
    t { '', 'end' },
  }),
})

-- Helper to read file content
local function read_lines(path)
  local lines = {}
  for line in io.lines(path) do
    table.insert(lines, line)
  end
  return lines
end

local acthermoLicense = function()
  return s('refSim_license', {
    t(read_lines(vim.fn.expand '~/.config/nvim/lua/core/RefSim_license.txt')),
  })
end

local staticComment = function()
  return s('static_comment', {
    t '/********************************* Static Member Functions **********************************/',
  })
end

local constructorComment = function()
  return s('constructor_comment', {
    t '/********************************* Constructors **********************************/',
  })
end

local memberComment = function()
  return s('member_comment', {
    t '/********************************* Member Functions **********************************/',
  })
end

local privatComment = function()
  return s('privateMember_comment', {
    t '/********************************* Private Member Functions **********************************/',
  })
end

local operatorComment = function()
  return s('operators_comment', {
    t '/********************************* Operator Member Functions **********************************/',
  })
end

local genericComment = function()
  return s('longComment', {
    t '/********************************* ',
    i(1, 'Comment'),
    t ' **********************************/',
  })
end

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local makehFile = function()
  return s(
    'make_h_file',
    fmt(
      [[
{}

/******************************************************************************
Class:
{}

Description:


******************************************************************************/

#ifndef {}_H
#define {}_H

namespace
{{

class {} {{
public:


/********************************* Constructors **********************************/

    {}();
	
	// Copy constructor and assignment
    {}(const {}& other) = delete;
	
	{} operator=(const {}& other) = delete;
	
	//Move constructor and assignment
	{}({}&&) noexcept = delete;
	
	{}& operator=({}&&) noexcept = delete;
	
	//Destructor
    ~{}();

/********************************* Member Functions **********************************/

private:
    // Member variables
}};
}}

#endif // {}_H
]],
      {
        t(read_lines(vim.fn.expand '~/.config/nvim/lua/core/RefSim_license.txt')),
        rep(1), -- include guard (uppercased)
        f(function(args)
          return args[1][1]:upper()
        end, { 1 }),
        f(function(args)
          return args[1][1]:upper()
        end, { 1 }),
        i(1, 'CLASSNAME'), -- include guard (uppercased)
        rep(1), -- include guard (uppercased)
        rep(1), -- class name
        rep(1), -- constructor
        rep(1), -- copy constructor
        rep(1), -- copy constructor
        rep(1), -- copy assignment
        rep(1), -- copy assignment
        rep(1), -- move constructor
        rep(1), -- move assignment
        rep(1), -- move assignment
        f(function(args)
          return args[1][1]:upper()
        end, { 1 }),
      }
    )
  )
end

local makeCFile = function()
  return s(
    'make_C_file',
    fmt(
      [[
{}


#include <{}.h>

namespace
{{


/********************************* Constructors **********************************/



/********************************* Member Functions **********************************/
}}
]],
      {
        t(read_lines(vim.fn.expand '~/.config/nvim/lua/core/RefSim_license.txt')),
        i(1, 'CLASSNAME'), -- include guard (uppercased)
      }
    )
  )
end

ls.add_snippets('cpp', {

  acthermoLicense(),

  staticComment(),

  constructorComment(),

  memberComment(),

  privatComment(),

  operatorComment(),

  genericComment(),

  makehFile(),

  makeCFile(),
})

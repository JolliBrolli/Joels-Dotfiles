local lush = require('lush')
local hsl = lush.hsl
local colors = {
  vietred100    = hsl(0, 71, 80),
  vietred300    = hsl(0, 71, 65),
  vietred500    = hsl(0, 71, 50),
  vietred700    = hsl(0, 71, 35),
  vietred900    = hsl(0, 71, 20),

  vietyellow100 = hsl(56, 92, 80),
  vietyellow300 = hsl(56, 92, 65),
  vietyellow500 = hsl(56, 92, 50),
  vietyellow700 = hsl(56, 92, 35),
  vietyellow900 = hsl(56, 92, 20),

  blue100       = hsl(217, 80, 80),
  blue300       = hsl(217, 80, 65),
  blue500       = hsl(217, 80, 50),
  blue700       = hsl(217, 80, 35),
  blue900       = hsl(217, 80, 20),

  cyan100       = hsl(181, 59, 80),
  cyan300       = hsl(181, 59, 65),
  cyan500       = hsl(181, 59, 50),
  cyan700       = hsl(181, 59, 35),
  cyan900       = hsl(181, 59, 20),

  green100      = hsl(127, 47, 80),
  green300      = hsl(127, 47, 65),
  green500      = hsl(127, 47, 50),
  green700      = hsl(127, 47, 35),
  green900      = hsl(127, 47, 20),

  orange100     = hsl(24, 97, 80),
  orange300     = hsl(24, 97, 65),
  orange500     = hsl(24, 97, 50),
  orange700     = hsl(24, 97, 35),
  orange900     = hsl(24, 97, 20),

  yellow100     = hsl(46, 100, 80),
  yellow300     = hsl(46, 100, 65),
  yellow500     = hsl(46, 100, 50),
  yellow700     = hsl(46, 100, 35),
  yellow900     = hsl(46, 100, 20),

  pink100       = hsl(314, 82, 80),
  pink300       = hsl(314, 82, 65),
  pink500       = hsl(314, 82, 50),
  pink700       = hsl(314, 82, 35),
  pink900       = hsl(314, 82, 20),

  mist100       = hsl(190, 16, 80),
  mist300       = hsl(190, 16, 65),
  mist500       = hsl(190, 16, 50),
  mist700       = hsl(190, 16, 35),
  mist900       = hsl(190, 16, 20),

  bg100         = hsl(233, 36, 73),
  bg300         = hsl(233, 36, 58),
  bg500         = hsl(233, 36, 43),
  bg700         = hsl(233, 36, 28),
  bg900         = hsl(233, 36, 13),
}

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- Core Editor UI
    Normal { bg = colors.bg900, fg = colors.mist100 },        -- Main editor background and default text
    Visual { bg = colors.bg500, fg = Normal.fg.lighten(50) }, -- Selected text highlight
    Comment { fg = colors.mist700, gui = "italic" },          -- Explanatory notes in code

    -- Navigation and Gutters
    CursorLine { bg = Normal.bg.lighten(10) },                                               -- Horizontal highlight of the current line
    CursorColumn { CursorLine },                                                             -- Vertical highlight of the current column
    LineNr { Comment, gui = "italic" },                                                      -- Default line numbers in the gutter
    LineNrBelow { fg = colors.vietred500.mix(Normal.bg, 80).lighten(15), gui = "italic" },   -- Relative line numbers below cursor
    CursorLineNr { fg = colors.vietyellow500.mix(Normal.bg, 30).lighten(10), gui = "bold" }, -- The line number at the cursor position
    LineNrAbove { LineNrBelow },                                                             -- Relative line numbers above cursor

    -- Basic Syntax
    String { fg = colors.green300 },                            -- Text wrapped in quotes
    Function { fg = colors.blue300, gui = "bold" },             -- Named procedures and methods
    Statement { fg = colors.blue100 },                          -- Control flow (if, else, return, etc.)
    Keyword { Statement },                                      -- Reserved words in the language
    Constant { fg = colors.orange300 },                         -- Non-changing values (numbers, specific labels)
    Type { fg = colors.cyan300 },                               -- Classes, structs, and data type definitions
    Boolean { fg = colors.vietred300.mix(colors.pink300, 40) }, -- true or false values
    Number { Constant },                                        -- Integer and decimal values
    Float { Constant },                                         -- Floating point values
    Operator { fg = colors.mist500 },                           -- Mathematical and logical symbols (+, -, ==, etc.)
    Identifier { fg = colors.mist100 },                         -- Variable names and basic labels
    PreProc { fg = colors.orange500 },                          -- Preprocessor directives (import, include, macros)
    Special { Keyword },                                        -- Special characters, escape sequences (\n)

    -- Treesitter (High-Definition Syntax)
    sym("@punctuation.delimiter") { fg = colors.blue100.mix(Normal.fg, 40) }, -- Commas, semicolons, and dots
    sym("@variable") { Identifier },                                          -- Variable names in modern parsers
    sym("@variable.builtin") { fg = colors.pink300, gui = "italic" },         -- Language-provided variables (self, this)
    sym("@property") { fg = colors.blue100 },                                 -- Attributes of an object or table
    sym("@parameter") { fg = colors.mist300, gui = "italic" },                -- Arguments inside function definitions
    sym("@constructor") { fg = colors.cyan300 },                              -- Functions that initialize objects
    sym("@punctuation.bracket") { sym("@punctuation.delimiter") },            -- Braces {}, parentheses (), and brackets []

    -- Search and UI Feedback
    Search { bg = Normal.bg.lighten(30), fg = colors.mist100, gui = "bold" },    -- Found search matches

    IncSearch { bg = Normal.bg.lighten(30), fg = colors.mist300 },               -- Search match while typing
    Pmenu { bg = colors.bg500, fg = colors.mist100 },                            -- Autocomplete popup menu background
    PmenuSel { bg = Pmenu.bg.lighten(20), fg = colors.mist100, gui = "bold" },   -- Current selection in popup menu
    PmenuSbar { bg = colors.bg700 },                                             -- The background of the scrollbar (the track)
    PmenuThumb { bg = PmenuSel.bg.lighten(10) },                                 -- Making it 'blue500' or 'mist500' makes it easy to see the
    WinSeparator { fg = colors.bg100 },                                          -- Dividing line between vertical/horizontal splits
    MatchParen { bg = colors.mist700, fg = colors.vietyellow500, gui = "bold" }, -- Highlight of the matching bracket pair


    NormalFloat { bg = PmenuSbar.bg, fg = colors.mist100 }, -- The background of the hover window
    -- The border around that hover window
    -- Using 'cyan300' or 'blue300' gives it a nice techy feel
    FloatBorder { fg = colors.cyan300, bg = NormalFloat.bg },
    -- The area at the very bottom for messages (e.g., "written")
    MsgArea { fg = colors.mist300 },
    -- The "INSERT" or "VISUAL" text at the bottom
    ModeMsg { fg = colors.blue300, gui = "bold" },
    -- The prompt when you type a command
    Question { fg = colors.vietyellow500 },
    StatusLine { bg = colors.bg500, fg = colors.mist100 },           -- Active window bottom bar
    StatusLineNC { bg = Normal.bg.lighten(8), fg = colors.mist300 }, -- Inactive window bottom bar

    -- Code Folding
    Folded { bg = colors.bg700, fg = colors.mist500 }, -- Line shown for collapsed code blocks
    FoldColumn { fg = colors.mist700 },                -- The gutter column where folds are indicated

    -- The vertical 80-character guide
    ColorColumn { bg = Normal.bg.lighten(5) },
    -- The column where signs (Git, LSP) are displayed
    SignColumn { bg = Normal.bg },

    -- Diagnostics (LSP / Linter)
    DiagnosticError { fg = colors.vietred300 },   -- Serious code issues
    DiagnosticWarn { fg = colors.vietyellow300 }, -- Potential code issues
    DiagnosticInfo { fg = colors.cyan700.lighten(15) },       -- General code information
    DiagnosticHint { fg = colors.cyan100 },       -- Code optimization suggestions

    TodoFGTODO { DiagnosticInfo },

    NeoTreeGitUntracked { fg = colors.green300 },
    NeoTreeFileName { fg = Normal.fg },

    -- Misc Treesittier options that are playing up.

    -- If you want library macros (like println!) to be special:
    sym("@lsp.typemod.macro.defaultLibrary") { fg = colors.pink100 },
    -- Force LSP macros to look like Functions (solving the priority 125 issue)
    sym("@lsp.type.macro") { sym("@lsp.typemod.macro.defaultLibrary") },

  }
end)
return theme

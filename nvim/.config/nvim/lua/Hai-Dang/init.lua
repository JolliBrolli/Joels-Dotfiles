local lush = require('lush')
local hsl = lush.hsl
local colors = {
  vietred100    = hsl(0, 71, 80),
  vietred300    = hsl(0, 71, 65),
  vietred500    = hsl(0, 71, 50),
  vietred700    = hsl(0, 71, 35),
  vietred900    = hsl(0, 71, 20),

  vietyellow100 = hsl(56, 92, 84),
  vietyellow300 = hsl(56, 92, 69),
  vietyellow500 = hsl(56, 92, 54),
  vietyellow700 = hsl(56, 92, 39),
  vietyellow900 = hsl(56, 92, 24),

  blue100    = hsl(217, 80, 75),
  blue300    = hsl(217, 80, 60),
  blue500    = hsl(217, 80, 45),
  blue700    = hsl(217, 80, 30),
  blue900    = hsl(217, 80, 15),

  cyan100    = hsl(181, 59, 78),
  cyan300    = hsl(181, 59, 63),
  cyan500    = hsl(181, 59, 48),
  cyan700    = hsl(181, 59, 33),
  cyan900    = hsl(181, 59, 18),

  green100   = hsl(127, 47, 81),
  green300   = hsl(127, 47, 66),
  green500   = hsl(127, 47, 51),
  green700   = hsl(127, 47, 36),
  green900   = hsl(127, 47, 21),

  orange100  = hsl(24, 97, 76),
  orange300  = hsl(24, 97, 61),
  orange500  = hsl(24, 97, 46),
  orange700  = hsl(24, 97, 31),
  orange900  = hsl(24, 97, 16),

  yellow100  = hsl(46, 100, 84),
  yellow300  = hsl(46, 100, 69),
  yellow500  = hsl(46, 100, 54),
  yellow700  = hsl(46, 100, 39),
  yellow900  = hsl(46, 100, 24),

  pink100 = hsl(314, 82, 63),
  pink300 = hsl(314, 82, 48),
  pink500 = hsl(314, 82, 33),
  pink700 = hsl(314, 82, 28),
  pink900 = hsl(314, 82, 13),

  mist100    = hsl(190, 16, 75),
  mist300    = hsl(190, 16, 60),
  mist500    = hsl(190, 16, 45),
  mist700    = hsl(190, 16, 30),
  mist900    = hsl(190, 16, 15),

  bg100      = hsl(233, 36, 51),
  bg300      = hsl(233, 36, 36),
  bg500      = hsl(233, 36, 21),
  bg700      = hsl(233, 36, 16),
  bg900      = hsl(233, 36, 11),
}

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- Core Editor UI
    Normal { bg = colors.bg900, fg = colors.mist100 },        -- Main editor background and default text
    Visual { bg = colors.bg100, fg = Normal.fg.lighten(50) }, -- Selected text highlight
    Comment { fg = colors.mist700, gui = "italic" },          -- Explanatory notes in code

    -- Navigation and Gutters
    CursorLine { bg = Normal.bg.lighten(10) },                                -- Horizontal highlight of the current line
    CursorColumn { CursorLine },                                              -- Vertical highlight of the current column
    LineNr { Comment, gui = "italic" },                                       -- Default line numbers in the gutter
    LineNrBelow { fg = colors.vietred500.mix(Normal.bg, 70).lighten(20), gui = "italic" },   -- Relative line numbers below cursor
    CursorLineNr { fg = colors.vietyellow500.mix(Normal.bg, 30).lighten(10), gui = "bold" }, -- The line number at the cursor position
    LineNrAbove { LineNrBelow },                                              -- Relative line numbers above cursor

    -- Basic Syntax
    String { fg = colors.green300 },                -- Text wrapped in quotes
    Function { fg = colors.blue100, gui = "bold" }, -- Named procedures and methods
    Statement { fg = colors.cyan300 },              -- Control flow (if, else, return, etc.)
    Keyword { Statement },                          -- Reserved words in the language
    Constant { fg = colors.orange300 },             -- Non-changing values (numbers, specific labels)
    Type { fg = colors.orange100 },                 -- Classes, structs, and data type definitions
    Boolean { fg = colors.vietred500.mix(colors.pink300, 40) },                -- true or false values
    Number { Constant },                            -- Integer and decimal values
    Float { Constant },                             -- Floating point values
    Operator { fg = colors.mist500 },               -- Mathematical and logical symbols (+, -, ==, etc.)
    Identifier { fg = colors.mist100 },             -- Variable names and basic labels
    PreProc { fg = colors.orange500 },              -- Preprocessor directives (import, include, macros)
    Special { fg = colors.blue100 },                -- Special characters, escape sequences (\n)

    -- Treesitter (High-Definition Syntax)
    sym("@punctuation.delimiter") { fg = colors.blue100.mix(Normal.fg, 40) },            -- Commas, semicolons, and dots
    sym("@variable") { Identifier },                                  -- Variable names in modern parsers
    sym("@variable.builtin") { fg = colors.pink100, gui = "italic" }, -- Language-provided variables (self, this)
    sym("@property") { fg = colors.cyan300 },                         -- Attributes of an object or table
    sym("@parameter") { fg = colors.mist300, gui = "italic" },        -- Arguments inside function definitions
    sym("@constructor") { fg = colors.blue100 },                    -- Functions that initialize objects
    sym("@punctuation.bracket") { sym("@punctuation.delimiter") },              -- Braces {}, parentheses (), and brackets []

    -- Search and UI Feedback
    Search { bg = Normal.bg.lighten(30), fg = colors.mist100, gui = "bold" }, -- Found search matches
    
    IncSearch { bg = Normal.bg.lighten(30), fg = colors.mist300 },                                -- Search match while typing
    Pmenu { bg = colors.bg300, fg = colors.mist100 },                                      -- Autocomplete popup menu background
    PmenuSel { bg = Pmenu.bg.lighten(20), fg = colors.mist100, gui = "bold" },                   -- Current selection in popup menu
    PmenuSbar  { bg = colors.bg700 },                                                      -- The background of the scrollbar (the track)
    PmenuThumb { bg = PmenuSel.bg.lighten(10) },                                                    -- Making it 'blue500' or 'mist500' makes it easy to see the
    WinSeparator { fg = colors.bg100 },                                                    -- Dividing line between vertical/horizontal splits
    MatchParen { bg = colors.mist700, fg = colors.vietyellow500, gui = "bold" },              -- Highlight of the matching bracket pair


    NormalFloat { bg = PmenuSbar.bg, fg = colors.mist100 },                                -- The background of the hover window
    -- The border around that hover window
    -- Using 'cyan300' or 'blue300' gives it a nice techy feel
    FloatBorder { fg = colors.cyan300, bg = NormalFloat.bg },
    -- The area at the very bottom for messages (e.g., "written")
    MsgArea { fg = colors.mist300 },
    -- The "INSERT" or "VISUAL" text at the bottom
    ModeMsg { fg = colors.blue300, gui = "bold" },
    -- The prompt when you type a command
    Question { fg = colors.vietyellow500 },
    StatusLine { bg = colors.bg100, fg = colors.mist100 },                                 -- Active window bottom bar
    StatusLineNC { bg = Normal.bg.lighten(8),  fg = colors.mist300 },                               -- Inactive window bottom bar

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
    DiagnosticInfo { fg = colors.blue300 },    -- General code information
    DiagnosticHint { fg = colors.cyan100 },    -- Code optimization suggestions

    NeoTreeGitUntracked { fg = colors.green300},
    NeoTreeFileName { fg = Normal.fg },

    -- Misc Treesittier options that are playing up.

    -- Force LSP macros to look like Functions (solving the priority 125 issue)
    sym("@lsp.type.macro") { Function },
    -- If you want library macros (like println!) to be special:
    sym("@lsp.typemod.macro.defaultLibrary") { Function },
 }
end)
return theme



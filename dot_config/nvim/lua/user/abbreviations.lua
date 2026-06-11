-- ============================================================================
-- {{ Global & Text Abbreviations }}
-- ============================================================================
-- ============================================================================
-- {{ Global & Text Abbreviations }}
-- ============================================================================
local abbrev = function(lhs, rhs)
    -- Safe execution via standard Vim script evaluation string
    vim.cmd(string.format("iabbrev %s %s", lhs, rhs))
end

-- Shebangs & System Core
abbrev("_SH",   "#!/bin/bash")
abbrev("_PL",   "#!/usr/bin/perl")

-- Markdown / Note Taking Emojis
abbrev(":white_check_mark:", "✅")
abbrev(":bulb:",             "💡")
abbrev(":smile:",            "☺")
abbrev(":pushpin:",          "📌")
abbrev(":construction:",     "🚧")
abbrev(":point_right:",      "👉")
abbrev(":link:",             "🔗")
abbrev(":wrench:",           "🔧")
abbrev(":email:",            "📧")
abbrev(":computer:",         "💻")
abbrev(":keyboard:",         "⌨️")
abbrev(":whale:",            "🐋")

-- ============================================================================
-- {{ Web Development (CSS & JS) }}
-- ============================================================================
abbrev(":bc:",   "background-color:")
abbrev(":fs:",   "font-size:")
abbrev(":fw:",   "font-weight:")
abbrev(":pa:",   "position: absolute;")
abbrev(":pr:",   "position: relative;")
abbrev(":br:",   "border-radius:")
abbrev(":bi:",   "background-image:")
abbrev(":tt:",   "text-transform:")
abbrev(":ttu:",  "text-transform: uppercase;")
abbrev(":ttl:",  "text-transform: lowercase;")

-- Multiline Blocks (Sanitized using sequential Vim keycodes)
abbrev(":df:",   "display: flex;<CR>align-items: center;<CR>")
abbrev(":media:", "@media only screen and (max-width: scss-var){<CR><CR>}<CR><Up><Up>")
abbrev(":svg:",  '<svg class=""><CR><use xlink:href="{2}#{3}"><CR></use></svg>')

-- JavaScript / React Quickstrings
abbrev("_csl",      "console.log(")
abbrev("_usestate", "import { useState } from 'react';")
abbrev("_reactcss", "import './cssfile.css';")

-- ============================================================================
-- {{ Computer Science Education (Java) }}
-- ============================================================================
abbrev("_sout",  "System.out.println(")
abbrev("_soutf", 'System.out.printf("", val);<Left><Left><Left><Left><Left><Left><Left><Left>')
abbrev("_psvm",  "public static void main(String[] args) {<CR><CR>}<Up>")

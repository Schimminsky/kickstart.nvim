-- Java: nvim-jdtls statt nacktem jdtls über lspconfig
-- Bringt Debugging (java-debug-adapter), Test-Runner (java-test) und Refactorings mit
-- https://github.com/mfussenegger/nvim-jdtls
--
-- WICHTIG: `jdtls` darf NICHT zusätzlich in `servers` in der init.lua stehen, sonst laufen zwei Server.
-- Mason-Pakete (in init.lua ensure_installed): jdtls, java-debug-adapter, java-test

local mason = vim.fn.stdpath 'data' .. '/mason/packages'
local asdf_java = vim.env.HOME .. '/.asdf/installs/java'

-- Das globale `java` (asdf) ist nur ein JRE. Das reicht weder zum Kompilieren noch für den Debugger
-- (java-debug braucht das Modul jdk.jdi, das es nur im JDK gibt). Deshalb läuft jdtls explizit mit dem JDK 25.
local jdk25 = asdf_java .. '/temurin-25.0.2+10.0.LTS'

-- JDKs, mit denen Projekte kompiliert/ausgeführt werden; welches genutzt wird, steht in pom.xml/build.gradle
local runtimes = {
  { name = 'JavaSE-21', path = asdf_java .. '/temurin-21.0.2+13.0.LTS' },
  { name = 'JavaSE-25', path = jdk25, default = true },
}

-- Debug- und Test-Erweiterungen als jdtls-Bundles
local function bundles()
  local b = vim.fn.glob(mason .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true, true)
  for _, jar in ipairs(vim.fn.glob(mason .. '/java-test/extension/server/*.jar', true, true)) do
    -- Diese beiden Jars sind keine OSGi-Bundles und lassen jdtls sonst mit Fehlern starten
    local name = vim.fn.fnamemodify(jar, ':t')
    if not name:match '^com%.microsoft%.java%.test%.runner%-jar%-with%-dependencies' and not name:match '^jacocoagent' then table.insert(b, jar) end
  end
  return b
end

local function start()
  local jdtls = require 'jdtls'
  local root = vim.fs.root(0, { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', '.git' }) or vim.fn.getcwd()
  -- Pro Projekt ein eigener Workspace-Ordner (jdtls legt dort Index und Build-Ergebnisse ab)
  local workspace = vim.fn.stdpath 'cache' .. '/jdtls/workspace/' .. vim.fn.fnamemodify(root, ':p:h:t') .. '-' .. vim.fn.sha256(root):sub(1, 8)

  jdtls.start_or_attach({
    cmd = {
      vim.fn.stdpath 'data' .. '/mason/bin/jdtls',
      '--java-executable=' .. jdk25 .. '/bin/java',
      '--jvm-arg=-javaagent:' .. mason .. '/jdtls/lombok.jar',
      '-data',
      workspace,
    },
    root_dir = root,
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    init_options = { bundles = bundles() },
    settings = {
      java = {
        configuration = { runtimes = runtimes },
        -- Formatieren übernimmt conform.nvim mit google-java-format
        format = { enabled = false },
        signatureHelp = { enabled = true },
        inlayHints = { parameterNames = { enabled = 'literals' } },
        completion = {
          favoriteStaticMembers = {
            'org.junit.jupiter.api.Assertions.*',
            'org.junit.Assert.*',
            'org.mockito.Mockito.*',
          },
        },
      },
    },
    -- Den Debug-Adapter registriert nvim-jdtls selbst, sobald nvim-dap da ist und java-debug geladen wurde.
    -- Main-Klassen tauchen dann automatisch als Debug-Konfiguration bei <F5> auf.
    on_attach = function(_, bufnr)
      local map = function(mode, keys, func, desc) vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'Java: ' .. desc }) end
      local visual = function() return vim.fn.mode() ~= 'n' end
      map('n', '<leader>jo', jdtls.organize_imports, '[O]rganize Imports')
      map({ 'n', 'v' }, '<leader>jv', function() jdtls.extract_variable { visual = visual() } end, 'Extract [V]ariable')
      map({ 'n', 'v' }, '<leader>jc', function() jdtls.extract_constant { visual = visual() } end, 'Extract [C]onstant')
      map('v', '<leader>jm', function() jdtls.extract_method { visual = true } end, 'Extract [M]ethod')
      map('n', '<leader>jt', jdtls.test_nearest_method, '[T]est Methode unter Cursor (debugbar)')
      map('n', '<leader>jT', jdtls.test_class, '[T]est ganze Klasse')
      map('n', '<leader>jg', function() require('jdtls.tests').generate() end, 'Tests [G]enerieren')
      map('n', '<leader>js', function() require('jdtls.tests').goto_subjects() end, 'Zwischen Klasse und Test [S]pringen')
      map('n', '<leader>ju', '<cmd>JdtUpdateConfig<CR>', 'Projekt-Config neu laden ([U]pdate)')
    end,
  }, {
    -- Geänderten Code während einer Debug-Session automatisch nachladen
    dap = { hotcodereplace = 'auto' },
  })
end

return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      group = vim.api.nvim_create_augroup('custom-jdtls', { clear = true }),
      callback = start,
    })
    -- Der FileType-Event des ersten Java-Buffers ist schon vorbei, wenn lazy.nvim das Plugin lädt
    if vim.bo.filetype == 'java' then start() end
  end,
}

return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "java" }, -- Only load this plugin when opening a Java file
    config = function()
      local home = os.getenv("HOME")
      local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"

      -- Automatically resolve the dynamically updated Equinox Launcher path
      local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

      -- Unique workspace directory based on the current opened directory name
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = home .. "/.local/share/nvim/jdtls/workspace/" .. project_name

      -- Establish compilation command arguments
      local cmd = {
        "java", -- Assumes java is globally mapped; fallback to explicit SDKMAN path if needed
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens=java.base/java.util=ALL-UNNAMED",
        "--add-opens=java.base/java.lang=ALL-UNNAMED",

        "-jar",
        launcher_jar,
        "-configuration",
        jdtls_path .. "/config_mac", -- Explicitly targets your Mac environment
        "-data",
        workspace_dir,
      }

      -- Consolidate your SDKMAN, formatting, and auto-import preferences
      local settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = home .. "/.sdkman/candidates/java/current",
                default = true,
              },
            },
          },
          format = { enabled = true },
          saveActions = { organizeImports = true },
        },
      }

      -- Advertise blink.cmp's completion capabilities so jdtls supports completionItem/resolve
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("blink.cmp").get_lsp_capabilities()
      )

      -- Initialize the language server connection
      require("jdtls").start_or_attach({
        cmd = cmd,
        settings = settings,
        capabilities = capabilities,
        init_options = { extendedClientCapabilities = require("jdtls").extendedClientCapabilities },
        root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "build.gradle", "mvnw", "gradlew" }),
      })
    end,
  },
}

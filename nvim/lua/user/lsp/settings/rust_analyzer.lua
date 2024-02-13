return
{
    settings = {
        rust_analyzer = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
                extrEnv = {
                    ["RUSTUP_TOOLCHAIN"] = "stable"
                }
            },
            procMacro = {
                enable = true
            },
        }
    }
}

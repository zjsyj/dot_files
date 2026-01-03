return
{
    cmd = {'rust-analyzer'},
    filetypes = {'rust'},
    root_markers = {
        '.git',
        'Cargo.toml',
    },
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

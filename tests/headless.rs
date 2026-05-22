use std::process::{Command, Output};

fn run_lua_within_neovim(case: &str) -> Output {
    // nvim --headless -u NORC \
    // --cmd "set rtp^=$(pwd)" \
    // -c "lua print(package.cpath)" \
    // -c "lua print(require('taohua').parse_toml('tests/fixtures/simple.toml').data.zh)" \
    // -c "quit"

    let cwd = std::env::current_dir().unwrap();
    println!("{:?}", cwd);
    let rtp = format!("set rtp^={}", cwd.to_str().unwrap());
    let run_test = cwd.join("tests").join("run_test.lua");
    Command::new("nvim")
        .args([
            "--headless",
            "-u",
            "NORC",
            "--cmd",
            &rtp,
            "-l",
            run_test.to_str().unwrap(),
        ])
        .arg(case)
        .arg(cwd.to_str().unwrap())
        .output()
        .expect("failed to spawn Neovim")
}

#[test]
fn test_simple() {
    let output = run_lua_within_neovim("simple");
    assert!(
        output.status.success(),
        "{:?}",
        String::from_utf8(output.stderr)
    );
}

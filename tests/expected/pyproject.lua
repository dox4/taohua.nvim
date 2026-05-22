return {
  ok = true,
  value = {
    project = {
      authors = {
        {
          email = "nicole@randomplay.com",
          name = "Nicole Demara",
        },
      },
      dependencies = { "anby>=0", "billy>=2.0.0", "nekomata" },
      description = "只要薪酬到位，狡兔屋随时为您服务！",
      license = {
        text = "Nicole Demara's License",
      },
      name = "cunninhares",
      ["optional-dependencies"] = {
        dev = { "black", "ruff", "pytest" },
      },
      readme = "Demara.md",
      ["requires-python"] = ">=3.12",
      scripts = {
        anby = "theater:movie",
        billy = "starlight:kick",
        nekomata = "cat:friends",
        nicole = "always:make_money",
      },
      version = "2.8.0",
    },
    tool = {
      pytest = {
        ini_options = {
          addopts = "-v --fake",
        },
      },
      ruff = {
        ["line-length"] = 42,
        ["target-version"] = "py312",
      },
      uv = {
        ["dev-dependencies"] = { "fake-watch" },
      },
    },
  },
}

import Config

if Mix.env() == :dev do
  config :git_hooks,
    hooks: [
      pre_commit: [
        tasks: [
          {:cmd, "mix format --check-formatted"}
        ]
      ]
    ]

  config :git_ops,
    mix_project: Mix.Project.get!(),
    changelog_file: "CHANGELOG.md",
    repository_url: "https://github.com/bcksl/ash_geo",
    manage_mix_version?: true,
    manage_readme_version: ["README.md"],
    version_tag_prefix: "v"
end

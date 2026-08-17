# PlanetScale Claude Plugin

Plugin for installing the [PlanetScale MCP server](https://planetscale.com/docs/connect/mcp), [Database Skills](https://db-skills.com/), and PlanetScale skills into Claude Code.

## Prerequisites

- Claude Code with plugin support
- A PlanetScale account for authenticated MCP features

## Install from GitHub

In Claude Code, add this GitHub repository as a marketplace, then install the plugin:

```text
/plugin marketplace add planetscale/claude-plugin
/plugin install planetscale@planetscale
```

### Verify it loaded

In Claude Code, run `/mcp` to see the `planetscale` MCP server.

If it does not appear immediately after install, fully restart Claude Code and check `/mcp` again. Plugin-provided MCP server changes are applied on restart.

## Skills Source and Sync

Skills are **vendored** into this repository so Claude plugin installs work on a plain checkout (no `git submodule update --init`). Upstream remains the source of truth:

- [`planetscale/database-skills`](https://github.com/planetscale/database-skills) → `database-skills/skills` (plus LICENSE/README)
- [`planetscale/skills`](https://github.com/planetscale/skills) → `planetscale-skills`

Pinned upstream SHAs are recorded in [`.skills-versions.json`](.skills-versions.json).

### Manual one-off update

To pull the latest upstream skills into this repository:

```bash
bash scripts/sync-skills.sh
```

Commit the resulting content and `.skills-versions.json` changes.

### Local testing

To test this plugin from your local working copy (before branching/PR):

```bash
claude --plugin-dir .
```

1. Run `/mcp` to verify the `planetscale` MCP server is loaded (will require authentication).
2. Run `/skills` to verify the database and PlanetScale skills are loaded.

### Automated weekly updates

GitHub Actions runs `.github/workflows/update-skills.yml` weekly and also supports manual runs (`workflow_dispatch`).

When upstream `main` has new commits, the workflow opens or updates a PR that contains:

- Updated vendored files under `database-skills/` and/or `planetscale-skills/`
- Updated `.skills-versions.json`

### Alternative (development only)

You can also use this direct local plugin load command:

```bash
claude --plugin-dir .
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and pull request guidance.

## License

This project is licensed under the [Apache License 2.0](LICENSE).

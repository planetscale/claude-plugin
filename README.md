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

This plugin pulls in skills from the upstream `planetscale/database-skills` repository via the `database-skills` Git submodule.

- Source repo: `https://github.com/planetscale/database-skills`
- Submodule path: `database-skills`
- Tracked branch: `main`

This plugin also pulls in skills from the upstream `planetscale/skills` repository via the `skills` Git submodule.

- Source repo: `https://github.com/planetscale/skills`
- Submodule path: `skills`
- Tracked branch: `main`

### Local bootstrap

Clone with submodules:

```bash
git clone --recurse-submodules https://github.com/planetscale/claude-code-plugin.git
```

If you already cloned without submodules:

```bash
git submodule update --init --recursive
```

### Manual one-off update

To pull the latest upstream skills into this repository:

```bash
git submodule sync --recursive
git submodule update --init --remote database-skills skills
```

Commit the resulting submodule pointer changes in this repository.

### Local testing

To test this plugin from your local working copy (before branching/PR):

```bash
claude --plugin-dir .
```

1. Run `/mcp` to verify the `planetscale` MCP server is loaded (will require authentication).
2. Run `/skills` to verify the database and PlanetScale skills are loaded.

### Automated weekly updates

GitHub Actions runs `.github/workflows/update-skills.yml` weekly and also supports manual runs (`workflow_dispatch`).

When either submodule has new commits, the workflow opens or updates a PR that contains only:

- The `database-skills` and/or `skills` submodule pointer updates
- `.gitmodules` (if submodule metadata changed)

### Alternative (development only)

You can also use this direct local plugin load command:

```bash
claude --plugin-dir .
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and pull request guidance.

## License

This project is licensed under the [Apache License 2.0](LICENSE).

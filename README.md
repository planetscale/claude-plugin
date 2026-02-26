# PlanetScale Claude Plugin

PlanetScale plugin for installing the MCP server into Claude Code and Claude Cowork.

## Install from GitHub

In Claude Code, add this GitHub repository as a marketplace, then install the plugin:

```text
/plugin marketplace add planetscale/claude-plugin
/plugin install planetscale@planetscale-plugins
```

### Verify it loaded

In Claude Code, run `/mcp` to see the `planetscale` MCP server.

If it does not appear immediately after install, fully restart Claude Code and check `/mcp` again. Plugin-provided MCP server changes are applied on restart.

## Skills Source and Sync

This plugin pulls in skills from the upstream `planetscale/database-skills` repository via the `database-skills` Git submodule.

- Source repo: `https://github.com/planetscale/database-skills`
- Submodule path: `database-skills`
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
git submodule update --init --remote database-skills
```

Commit the resulting submodule pointer change in this repository.

### Automated weekly updates

GitHub Actions runs `.github/workflows/update-skills.yml` weekly and also supports manual runs (`workflow_dispatch`).

When `database-skills` has new commits, the workflow opens or updates a PR that contains only:

- The `database-skills` submodule pointer update
- `.gitmodules` (if submodule metadata changed)

### Alternative (development only)

If you are developing this plugin locally:

```bash
claude --plugin-dir .
```

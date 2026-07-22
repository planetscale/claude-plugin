# PlanetScale Claude Code Plugin

Install the hosted [PlanetScale MCP server](https://planetscale.com/docs/connect/mcp), [Database Skills](https://db-skills.com/), and PlanetScale operational skills in Claude Code from one plugin.

The MCP server provides authenticated access to PlanetScale organizations, databases, branches, schema, and Insights data. The two skill packs add database guidance and PlanetScale-specific operating workflows.

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

Run `/mcp` to confirm the `planetscale` MCP server is available, then run `/skills` to confirm skills from both `database-skills/skills` and `skills` are loaded. Restart Claude Code if a newly installed MCP server does not appear immediately.

## Skills source and sync

This plugin tracks two upstream PlanetScale repositories as Git submodules:

| Source | Submodule path | Skills path | Branch |
| --- | --- | --- | --- |
| [`planetscale/database-skills`](https://github.com/planetscale/database-skills) | `database-skills` | `database-skills/skills` | `main` |
| [`planetscale/skills`](https://github.com/planetscale/skills) | `skills` | `skills` | `main` |

### Local bootstrap

```bash
git clone --recurse-submodules https://github.com/planetscale/claude-plugin.git
cd claude-plugin
```

If you already cloned without submodules:

```bash
git submodule update --init --recursive
```

### Manual one-off update

```bash
git submodule sync --recursive
git submodule update --init --remote database-skills skills
```

Commit the resulting submodule pointer changes in this repository.

### Local testing

Load the plugin from the working copy:

```bash
claude --plugin-dir .
```

Run `/mcp` and `/skills` to verify the MCP server and both skill packs.

### Automated weekly updates

GitHub Actions runs `.github/workflows/update-skills.yml` weekly and also supports manual runs (`workflow_dispatch`). When either upstream repository changes, the workflow opens or updates a focused pull request containing the changed submodule pointers.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and pull request guidance. Submit changes to skill content in its upstream repository rather than editing a submodule here.

## License

The plugin wrapper and configuration are licensed under the [Apache License 2.0](LICENSE). The included skill repositories retain their MIT licenses; see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

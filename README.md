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

### Alternative (development only)

If you are developing this plugin locally:

```bash
claude --plugin-dir .
```

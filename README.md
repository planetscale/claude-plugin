# PlanetScale Claude Plugin

PlanetScale plugin for installing the MCP server into Claude Code and Claude Cowork.

## Install from GitHub

In Claude Code, add this GitHub repository as a marketplace, then install the plugin:

```text
/plugin marketplace add planetscale/claude-plugin
/plugin install planetscale@planetscale-plugins
```

No manual cloning is required.

### Verify it loaded

In Claude Code, run:

```text
/mcp
```

You should see the `planetscale` MCP server available.

### Alternative (development only)

If you are developing this plugin locally:

```bash
claude --plugin-dir .
```

## Coming soon

Once this plugin is listed in the Claude Directory, installation will be available through the built-in plugin flow.

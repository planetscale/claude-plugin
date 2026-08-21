# Contributing

Thanks for contributing to the PlanetScale plugin.

## Setup

Clone the repository normally. Skills are vendored in-tree, so no submodule init is required.

## Skill changes

Submit PlanetScale operating skill changes to [`planetscale/skills`](https://github.com/planetscale/skills) and database skill changes to [`planetscale/database-skills`](https://github.com/planetscale/database-skills).

Do not edit the vendored copies under `database-skills/` or `planetscale-skills/` directly in this repository except via sync:

```bash
bash scripts/sync-skills.sh
```

That updates the vendored trees and [`.skills-versions.json`](.skills-versions.json). Weekly automation also opens PRs when upstream `main` moves.

## Pull requests

- Keep changes focused.
- Describe the change and the validation performed.
- Update documentation when installation or behavior changes.
- Do not include credentials, tokens, customer data, or other sensitive information.

# Project conventions

## dbt targets

- `dev` — for local development on feature branches. Default target.
- `prod` — used when running the pipeline on the `main` branch (writes to the `prod` schema).

When on `main`, run dbt with `--target prod`:

```
DBT_PROFILES_DIR=. dbt run --target prod
DBT_PROFILES_DIR=. dbt test --target prod
```

On feature branches, omit `--target` (defaults to `dev`).

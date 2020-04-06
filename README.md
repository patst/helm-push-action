# Helm push action

This actions uses helm3 and uploads a helm chart to a chart repository.

The actions works on AMD64 and ARM runners.

## Usage

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Push helm chart
on: push

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: patst/helm-push-action@master
      env:
        SOURCE_DIR: '.'
        CHART_FOLDER: 'example-app'
        FORCE: 'True'
        CHARTMUSEUM_URL: 'https://chartmuseum.url'
        HELM_REPO_USERNAME: '${{ secrets.HELM_REPO_USERNAME }}'
        HELM_REPO_PASSWORD: ${{ secrets.HELM_REPO_PASSWORD }}
```

## Configuration

Authentication at chartmuseum:

| Key | Value | Suggested Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `CHART_FOLDER` | Folder with charts in repo | `env` | **Yes** |
| `CHARTREPOSITORY_URL` | Chartmuseum url | `env` | **Yes** |
| `HELM_REPO_USERNAME` | Username for the chart repository  | `secret` | No |
| `HELM_REPO_PASSWORD` | Password for the chart repository | `secret` | No |
| `SOURCE_DIR` | The local directory you wish to upload. For example, `./charts`. Defaults to the root of your repository (`.`) if not provided. | `env` | No |
| `FORCE` | Force chart upload (in case version exist in chartmuseum, upload will fail without `FORCE`). Defaults is `False` if not provided. | `env` | No |

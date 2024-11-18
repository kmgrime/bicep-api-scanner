# Bicep API Scanner

This Docker image uses the `az` CLI and `bicep` CLI to lint your Bicep files and check for outdated API versions based on the configuration in `bicepconfig.json`. It works both locally and in CI/CD pipelines.

## Prerequisites

- **Azure CLI**: Make sure the Azure CLI is authenticated (`az login`).
- **Docker** or **Podman**: To build and run the container locally.
- **Azure Access Token**: You need to pass an `AZURE_ACCESS_TOKEN` environment variable when running the container.

## Setup

1. **Clone the Repository**

   - Clone or create your project with the Bicep files.

2. **Configure `bicepconfig.json`**:

   - This configuration file checks for outdated API versions.

   Example of `bicepconfig.json`:

   ```json
   {
     "use-recent-api-versions": {
       "level": "warning",
       "maxAllowedAgeInDays": 365
     }
   }
   ```

3. Create Docker Image: Build the Docker image with the following command:

```bash
podman build -t bicep-api-scanner .
```

## Running locally

Run the Docker container with your Bicep files mounted:

```bash
  podman run -it \
-v ./biceptestfiles:/workspace \
bicep-api-scanner
```

This will lint your Bicep files for outdated API versions based on the bicepconfig.json configuration.

## Running in CI/CD Pipeline

To run the scanner on your own bicep files just change the path in the pipeline to your respective bicep file path.

```yaml
# Run the Bicep Linter
- name: Run Bicep Linter
  run: |
    docker run --rm \
      -v "${{ github.workspace }}/biceptestfiles:/workspace" \
      bicep-api-scanner

# Upload linting results (optional)
- name: Save Results
  if: always()
  run: |
    mkdir -p $GITHUB_WORKSPACE/lint-results
    docker run --rm \
      -v "${{ github.workspace }}/biceptestfiles:/workspace" \
      bicep-api-scanner > $GITHUB_WORKSPACE/lint-results/lint-output.txt
```

## Configuration

You can modify bicepconfig.json to change how the API version checks are handled. For example:
Set maxAllowedAgeInDays to allow older API versions.
Change the level to error to enforce recent API versions.

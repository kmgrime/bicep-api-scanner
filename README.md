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
       "maxAllowedAgeInDays": 0
     }
   }

3. Create Docker Image: Build the Docker image with the following command:

  ```bash
  docker build -t bicep-api-scanner .
  ```
## Running locally

Run the Docker container with your Bicep files mounted:
  ```bash
  docker run --rm \
  -e AZURE_ACCESS_TOKEN="$AZURE_ACCESS_TOKEN" \
  -v /path/to/your/bicep/files:/workspace \
  bicep-api-scanner
  ```
This will lint your Bicep files for outdated API versions based on the bicepconfig.json configuration.
## Running in CI/CD Pipeline
  
  Authenticate Azure CLI: Ensure that the pipeline authenticates to Azure (e.g., using a service principal):
```bash
az login --service-principal -u <app-id> -p <secret> --tenant <tenant-id>
```
Run the Scanner: In your pipeline, run the container to lint the Bicep files:
```bash
    docker run --rm \
      -e AZURE_ACCESS_TOKEN="$AZURE_ACCESS_TOKEN" \
      -v $(pwd)/bicep:/workspace \
      bicep-api-scanner
```
## Configuration

You can modify bicepconfig.json to change how the API version checks are handled. For example:

    Set maxAllowedAgeInDays to allow older API versions.
    Change the level to error to enforce recent API versions.

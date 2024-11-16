# Use an official Azure CLI image as the base
FROM mcr.microsoft.com/azure-cli:latest

# Install Bicep CLI
RUN curl -Lo /usr/local/bin/bicep https://github.com/Azure/bicep/releases/download/v0.16.3/bicep-linux-x64 && \
    chmod +x /usr/local/bin/bicep

# Set working directory for the application
WORKDIR /workspace

# Copy the Bicep config file into the image
COPY bicepconfig.json /workspace/bicepconfig.json

# Set the Bicep configuration path
ENV BICEP_CONFIG_PATH=/workspace/bicepconfig.json

# Ensure Azure CLI is authenticated via environment variable or az login
ENV AZURE_ACCESS_TOKEN ""

# Set up a default entrypoint (this can be overridden in CI/CD)
ENTRYPOINT ["bash", "-c", "az bicep build --file /workspace/*.bicep --config /workspace/bicepconfig.json"]

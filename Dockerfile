# Use an official Azure CLI image as the base
FROM mcr.microsoft.com/azure-cli:2.66.0-amd64

# Install dependencies (curl, libicu)
RUN tdnf install -y \
    curl \
    libicu

# Install Bicep CLI
RUN curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64

# Mark it as executable
RUN chmod +x ./bicep

# Add bicep to your PATH (requires admin)
RUN mv ./bicep /usr/local/bin/bicep

# Verify you can now access the 'bicep' command
RUN bicep --version

# Set working directory for the application
WORKDIR /workspace

# Copy the Bicep config file into the image
COPY bicepconfig.json /workspace/bicepconfig.json

# Set the Bicep configuration path
ENV BICEP_CONFIG_PATH=/workspace/bicepconfig.json

# Ensure Azure CLI is authenticated via environment variable or az login
ENV AZURE_ACCESS_TOKEN ""

# Default command to run the Bicep linter
ENTRYPOINT ["bash", "-c", "az bicep lint --file /workspace/*.bicep"]


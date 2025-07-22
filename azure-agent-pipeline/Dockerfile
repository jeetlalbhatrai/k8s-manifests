# FROM ubuntu:22.04

# # Create a non-root user
# RUN useradd -m agentuser

# # Install dependencies
# RUN apt-get update && apt-get install -y \
#     curl libcurl4 openssh-client jq zip unzip libicu70 libkrb5-3 ca-certificates \
#     && apt-get clean

# # Switch to non-root user
# USER agentuser
# WORKDIR /home/agentuser/azp

# # Copy the agent tarball and script
# COPY --chown=agentuser:agentuser vsts-agent-linux-arm64-4.258.1.tar.gz .
# COPY --chown=agentuser:agentuser start.sh .

# # Extract the agent
# RUN tar zxvf vsts-agent-linux-arm64-4.258.1.tar.gz && chmod +x ./start.sh

# ENTRYPOINT [ "./start.sh" ]

FROM ubuntu:22.04

# Create non-root user
RUN useradd -m agentuser

# Install dependencies and common tools
RUN apt-get update && apt-get install -y \
    curl git unzip zip wget jq gnupg software-properties-common ca-certificates \
    python3 python3-pip libicu70 libkrb5-3 \
    && apt-get clean

# ----------------------------
# Install Terraform (ARM64)
# ----------------------------
ARG TERRAFORM_VERSION=1.8.5
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_arm64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

# ----------------------------
# Install tfsec (ARM64)
# ----------------------------
RUN curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

# ----------------------------
# Install tflint (ARM64)
# ----------------------------
ARG TFLINT_VERSION=v0.50.3
RUN curl -L https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_arm64.zip -o tflint.zip \
    && unzip tflint.zip \
    && mv tflint /usr/local/bin/ \
    && rm tflint.zip

# ----------------------------
# Install Checkov (via pip)
# ----------------------------
RUN pip3 install checkov

# Install Azure CLI (ARM64)
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Switch to non-root user
USER agentuser
WORKDIR /home/agentuser/azp

# Copy agent files
COPY --chown=agentuser:agentuser vsts-agent-linux-arm64-4.258.1.tar.gz .
COPY --chown=agentuser:agentuser start.sh .

# Extract the agent
RUN tar zxvf vsts-agent-linux-arm64-4.258.1.tar.gz && chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]

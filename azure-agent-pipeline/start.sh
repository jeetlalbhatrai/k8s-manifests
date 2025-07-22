#!/bin/bash
set -e

if [ -z "$AZP_URL" ] || [ -z "$AZP_TOKEN" ]; then
  echo "Missing AZP_URL or AZP_TOKEN"
  exit 1
fi

./config.sh --unattended \
  --agent "${AZP_AGENT_NAME:-docker-agent}" \
  --url "$AZP_URL" \
  --auth pat \
  --token "$AZP_TOKEN" \
  --pool "${AZP_POOL:-Default}" \
  --work "${AZP_WORK:-_work}" \
  --replace \
  --acceptTeeEula

./run.sh

#curl -O https://download.agent.dev.azure.com/agent/4.258.1/vsts-agent-linux-arm64-4.258.1.tar.gz

# docker build -t azp-agent-arm64 .

# docker run --rm \
#   -e AZP_URL=https://dev.azure.com/jeetlalbhatrai \
#   -e AZP_TOKEN=BOcL2jWXWrU8tqLhLQlz3i88Zyl4PQFnCEYpKAGorlhBkqAFJkWNJQQJ99BGACAAAAAAAAAAAAASAZDO1k7e \
#   -e AZP_POOL=agent-ka-jhund \
#   -e AZP_AGENT_NAME=agent-one \
#  azp-agent-arm64:latest

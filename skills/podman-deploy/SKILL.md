---
name: podman-deploy
description: "Automate the deployment of rootless Podman containers with boot persistence via systemd user units. Use when Codex needs to: (1) Build a Podman image from a Containerfile, (2) Deploy a container as a background service, (3) Configure auto-start on boot for rootless containers, or (4) Manage Podman service lifecycles on Linux."
---

# Podman Deploy

This skill automates the transition from a project folder to a production-ready rootless Podman service with boot persistence.

## Core Workflow

1. **Prepare the Image**:
   - Create or verify a \`Containerfile\` (or \`Dockerfile\`) in the project root.
   - Build the image: \`podman build -t <image-name> .\`

2. **Define the Run Command**:
   - Determine the required port mappings (\`-p`) and volume mounts (\`-v`).
   - Use the \`:Z\` flag for volumes to handle SELinux labels in rootless mode.
   - Ensure the container is named uniquely.

3. **Deploy as a Service**:
   - Use the bundled script \`scripts/deploy.sh\` to create the systemd unit and enable persistence.
   - Command: \`./scripts/deploy.sh <service-name> \"podman run --name <service-name> --replace --rm <options> <image>\"\`
   - This script automatically handles:
     - \`mkdir -p ~/.config/systemd/user/\`
     - Writing a \`Type=simple\` unit file.
     - Running \`systemctl --user daemon-reload\` and \`enable --now\`.
     - Running \`loginctl enable-linger $USER\`.

## Best Practices

- **Prefer Simple Units**: Avoid \`podman generate systemd\` for rootless deployments as it is prone to status 125 errors and state mismatches.
- **Stateless Containers**: Use \`--replace --rm\` in the \`ExecStart\` command. This ensures the container is recreated from the image on every restart, preventing "name already in use" conflicts.
- **Persistent Data**: Always mount critical data directories (config, databases, logs) as volumes to the host.
- **Boot Persistence**: Remember that without \`loginctl enable-linger\`, rootless services will stop as soon as the user logs out.

## Resources

- **Systemd Templates**: For detailed unit configurations and troubleshooting, read [systemd-templates.md](references/systemd-templates.md).
- **Deploy Script**: The \`scripts/deploy.sh\` script is the primary tool for creating the service wrapper.

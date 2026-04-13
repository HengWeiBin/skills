#!/bin/bash
# podman-deploy helper script to automate rootless systemd service creation

set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <service-name> \"<podman-run-command>\""
    echo "Example: $0 open-alice \"podman run --name open-alice --replace --rm -p 3002:3002 -v /home/weibin/data:/app/data:Z localhost/open-alice:latest\""
    exit 1
fi

SERVICE_NAME=$1
RUN_CMD=$2
UNIT_FILE="$HOME/.config/systemd/user/${SERVICE_NAME}.service"

mkdir -p "$HOME/.config/systemd/user/"

echo "Creating systemd unit for $SERVICE_NAME..."
cat <<EOF > "$UNIT_FILE"
[Unit]
Description=Podman container $SERVICE_NAME
After=network-online.target

[Service]
Type=simple
ExecStartPre=-/usr/bin/podman stop -t 10 $SERVICE_NAME
ExecStart=/usr/bin/$RUN_CMD
ExecStop=/usr/bin/podman stop -t 10 $SERVICE_NAME
Restart=always

[Install]
WantedBy=default.target
EOF

echo "Reloading systemd and enabling service..."
systemctl --user daemon-reload
systemctl --user enable --now "${SERVICE_NAME}.service"
loginctl enable-linger "$USER"

echo "Deployment of $SERVICE_NAME complete."
echo "Status: $(systemctl --user is-active ${SERVICE_NAME}.service)"

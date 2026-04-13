# Podman Systemd Templates

## Rootless Boot Persistence
For rootless containers to start at boot without a user session, you MUST run:
\`loginctl enable-linger <username>\`

## Recommended Unit Type: Simple
Avoid \`podman generate systemd\` (Type=forking) as it is fragile. Use \`Type=simple\` with \`--replace --rm\`.

### Simple Template
\`\`\`ini
[Unit]
Description=My Service
After=network-online.target

[Service]
Type=simple
ExecStartPre=-/usr/bin/podman stop -t 10 my-service
ExecStart=/usr/bin/podman run --name my-service --replace --rm -p 80:80 localhost/my-image:latest
ExecStop=/usr/bin/podman stop -t 10 my-service
Restart=always

[Install]
WantedBy=default.target
\`\`\`

## Common Volume Flags
- \`:Z\` : Tell Podman to relabel the volume for SELinux (critical on RHEL/Fedora/CentOS).
- \`:ro\` : Mount as read-only.

## Podman Troubleshooting
- View logs: \`podman logs <container-name>\`
- Check status: \`systemctl --user status <service-name>\`
- Inspect rootless port binding: \`ss -tulpn | grep <port>\`

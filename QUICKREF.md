# Quick Reference

## Common Commands

```bash
# Create default container
wsc create

# Create named container
wsc create myproject

# Enter default container
wsc enter

# Enter named container
wsc enter myproject

# List all containers
wsc list

# Destroy default container
wsc destroy

# Destroy named container
wsc destroy myproject

# Rebuild image
wsc build

# Show help
wsc help
```

## Inside the Container

```bash
# Your editor (default)
nvim filename

# Your shell (default)
zsh

# Python
python3

# Network tools
wget https://example.com
tshark -i any
tcpdump -i any

# Access host home directory (read-only)
ls /host-home

# Your mounted configs are at:
~/.zshrc
~/.config/nvim
~/.gitconfig
~/.ssh

# Exit container
exit
# or
Ctrl+D
```

## Directory Structure

```
workspace-container/
├── wsc                    # Main CLI tool
├── Dockerfile            # Container image definition
├── README.md             # Full documentation
├── INSTALL.md            # Installation guide
└── example.sh            # Usage examples
```

## Workflow Examples

### Daily Development
```bash
# Morning: start working
wsc create
wsc enter

# Work on your projects...

# Evening: clean up
exit
wsc destroy
```

### Multiple Projects
```bash
# Set up different environments
wsc create frontend
wsc create backend
wsc create testing

# Switch between them
wsc enter frontend
# ... work ...
exit

# wsc enter backend
wsc enter backend
# ... work ...
exit

# Clean up when done
wsc destroy frontend
wsc destroy backend
wsc destroy testing
```

### Temporary Experiments
```bash
# Create temporary workspace
wsc create experiment

# Try things out
wsc enter experiment
# ... experiment ...
exit

# Clean up
wsc destroy experiment
```

## Configuration

### Config Files Auto-Mounted (if they exist):
- `.zshrc` - Zsh configuration
- `.config/nvim` - Neovim config
- `.vimrc` - Vim config
- `.bashrc` - Bash config
- `.gitconfig` - Git config
- `.ssh` - SSH keys

### Container Storage Location
Managed by Podman:
```bash
# List Podman containers
podman ps -a

# View container details
podman inspect workspace-default
```

## Troubleshooting

```bash
# Check Podman status
podman --version
podman machine list    # macOS only

# Start Podman machine (macOS)
podman machine start

# Clean up all containers and images
podman system prune -a

# View container logs
podman logs workspace-default

# Force remove a container
podman rm -f workspace-default
```

## Tips

- Container names must be unique
- Default container is named `workspace-default`
- Containers persist across reboots (until destroyed)
- Image is built once, containers created from it
- Rebuild image after modifying Dockerfile
- Config files are mounted, not copied (changes reflect immediately)

## Getting Help

```bash
# Built-in help
wsc help

# Community help
- Open an issue on GitHub
- Check README.md
- Review INSTALL.md
```

# Quick Reference

## Common Commands

```bash
# Create default container
workspace-container create

# Create named container
workspace-container create myproject

# Enter default container
workspace-container enter

# Enter named container
workspace-container enter myproject

# List all containers
workspace-container list

# Destroy default container
workspace-container destroy

# Destroy named container
workspace-container destroy myproject

# Rebuild image
workspace-container build

# Show help
workspace-container help
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
├── workspace-container    # Main CLI tool
├── Dockerfile            # Container image definition
├── README.md             # Full documentation
├── INSTALL.md            # Installation guide
├── CONTRIBUTING.md       # Contribution guidelines
├── LICENSE               # MIT License
└── example.sh            # Usage examples
```

## Workflow Examples

### Daily Development
```bash
# Morning: start working
workspace-container create
workspace-container enter

# Work on your projects...

# Evening: clean up
exit
workspace-container destroy
```

### Multiple Projects
```bash
# Set up different environments
workspace-container create frontend
workspace-container create backend
workspace-container create testing

# Switch between them
workspace-container enter frontend
# ... work ...
exit

workspace-container enter backend
# ... work ...
exit

# Clean up when done
workspace-container destroy frontend
workspace-container destroy backend
workspace-container destroy testing
```

### Temporary Experiments
```bash
# Create temporary workspace
workspace-container create experiment

# Try things out
workspace-container enter experiment
# ... experiment ...
exit

# Clean up
workspace-container destroy experiment
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
workspace-container help

# Community help
- Open an issue on GitHub
- Check README.md
- Review INSTALL.md
```

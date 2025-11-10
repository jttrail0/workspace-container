# Installation Guide

## macOS Installation

### 1. Install Podman

```bash
brew install podman
```

### 2. Initialize Podman Machine

```bash
# Initialize the machine (only needed once)
podman machine init

# Start the machine
podman machine start

# Verify it's running
podman machine list
```

### 3. Clone and Setup workspace-container

```bash
# Clone the repository
git clone https://github.com/jttrail0/workspace-container.git
cd workspace-container

# The script is already executable, but verify:
chmod +x workspace-container

# Optionally, add to your PATH by adding this to ~/.zshrc or ~/.bashrc:
export PATH="$PATH:$(pwd)"

# Or create a symlink (recommended):
sudo ln -s $(pwd)/workspace-container /usr/local/bin/workspace-container
```

### 4. Verify Installation

```bash
workspace-container help
```

## Linux Installation

### 1. Install Podman

For Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install podman
```

For Fedora:
```bash
sudo dnf install podman
```

For Arch:
```bash
sudo pacman -S podman
```

### 2. Clone and Setup workspace-container

```bash
# Clone the repository
git clone https://github.com/jttrail0/workspace-container.git
cd workspace-container

# The script is already executable, but verify:
chmod +x workspace-container

# Add to your PATH:
echo 'export PATH="$PATH:'$(pwd)'"' >> ~/.bashrc
source ~/.bashrc

# Or create a symlink:
sudo ln -s $(pwd)/workspace-container /usr/local/bin/workspace-container
```

### 3. Verify Installation

```bash
workspace-container help
```

## First Run

After installation, create your first container:

```bash
# Create default container (will build the image on first run)
workspace-container create

# This will:
# 1. Build the Docker image with all tools (takes a few minutes)
# 2. Create a container named 'workspace-default'
# 3. Mount your config files from your home directory

# Enter the container
workspace-container enter

# You're now in the container with zsh, nvim, python, etc.
# Exit with:
exit
```

## Troubleshooting

### macOS: "Cannot connect to Podman"

Make sure the Podman machine is running:
```bash
podman machine start
```

You can set it to start automatically:
```bash
podman machine set --rootful=false
```

### Linux: Permission Denied

If you get permission errors, you may need to configure podman for rootless mode:
```bash
podman system migrate
```

### Image Build Fails

If the image build fails, try:
```bash
# Clean up and try again
podman system prune -a
workspace-container build
```

### Config Files Not Mounting

Verify your config files exist and are readable:
```bash
ls -la ~/.zshrc ~/.config/nvim
```

The tool only mounts files that exist on your host system.

## Updating

To update workspace-container:

```bash
cd /path/to/workspace-container
git pull

# Rebuild the image to get latest changes
workspace-container build
```

## Uninstallation

To remove workspace-container:

```bash
# Destroy all containers
workspace-container list
workspace-container destroy <container-name>  # for each container

# Remove the image
podman rmi workspace-container

# Remove the symlink (if created)
sudo rm /usr/local/bin/workspace-container

# Remove the repository
cd ..
rm -rf workspace-container
```

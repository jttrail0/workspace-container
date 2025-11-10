# workspace-container

A simple container lifecycle management tool for macOS (and Linux) using Podman, similar to distrobox. Build and manage development workspace containers with your favorite tools and configurations.

## Features

- 🚀 Simple lifecycle management: `create`, `enter`, `destroy`
- 🛠️ Pre-configured with common development tools:
  - neovim (default editor)
  - zsh with Oh My Zsh (default shell)
  - Python 3
  - wget
  - tshark
  - tcpdump
- 📁 Automatic mounting of host configuration files (.zshrc, .config/nvim, .gitconfig, .ssh, etc.)
- 🔄 Support for multiple named containers
- 🎯 Default container for quick access
- 🏠 Read-only access to your full home directory at `/host-home`

## Prerequisites

- [Podman](https://podman.io/getting-started/installation) installed on your system
  - macOS: `brew install podman`
  - Linux: Follow [official installation guide](https://podman.io/getting-started/installation)

For macOS users, you'll also need to initialize the Podman machine:
```bash
podman machine init
podman machine start
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/jttrail0/workspace-container.git
cd workspace-container
```

2. Make the script executable (already done in repo):
```bash
chmod +x wsc
```

3. (Optional) Add to your PATH:
```bash
# Add to ~/.zshrc or ~/.bashrc
export PATH="$PATH:/path/to/workspace-container"
```

Or create a symlink:
```bash
sudo ln -s $(pwd)/wsc /usr/local/bin/wsc
```

## Usage

### Quick Start

```bash
# Create the default container
./wsc create

# Enter the container
./wsc enter

# When done, destroy the container
./wsc destroy
```

### Commands

#### Create a Container
```bash
# Create default container
./wsc create

# Create a named container
./wsc create myproject
```

Creates a new container with the specified name (or default). On first run, this will build the Docker image with all the development tools.

#### Enter a Container
```bash
# Create default container
./wsc create

# Create a named container
./wsc create myproject
```

Enters the specified container. If the container is stopped, it will be started automatically.

# Enter default container
./wsc enter

# Enter a named container
./wsc enter myproject
# Destroy a named container
./wsc destroy myproject
```

# Destroy default container
./wsc destroy

# Destroy a named container
./wsc destroy myproject
```

Lists all managed containers and their status.

./wsc list
```bash
./wsc build
```

./wsc build

#### Help
```bash
./wsc help

Shows usage information and available commands.

1. **Image Building**: The tool builds a Docker image based on Fedora 38 with all specified tools

The tool automatically mounts configuration files from your home directory if they exist:

- `.zshrc` - Zsh configuration
- `.config/nvim` - Neovim configuration directory
- `.vimrc` - Vim configuration (if using vim)
- `.bashrc` - Bash configuration
- `.gitconfig` - Git configuration
- `.ssh` - SSH keys and configuration

Your entire home directory is also available at `/host-home` (read-only) for accessing other files as needed.

## Customization

### Modifying the Dockerfile

Edit the `Dockerfile` to add or remove tools:

```dockerfile
RUN apt-get install -y \
    your-package-here \
    another-package
```

After modifying, rebuild the image:
```bash
./wsc build
```

### Adding More Config Mounts

Edit the `wsc` script and add to the `configs` array in the `create_container()` function:

```bash
local configs=(
    ".zshrc"
    ".config/nvim"
    ".your-config-file"
)
```

## Examples

### Multiple Development Environments

```bash
# Create separate containers for different projects
./wsc create frontend-dev
./wsc create backend-dev
./wsc create data-science

# Enter the frontend container
./wsc enter frontend-dev

# List all containers
./wsc list

# Clean up when done
./wsc destroy frontend-dev
```

### Daily Workflow

```bash
# Morning: create and enter your workspace
./wsc create
./wsc enter

# Work on your projects with all your tools and configs...

# Evening: exit (Ctrl+D or 'exit') and optionally destroy
./wsc destroy
```

## How It Works

1. **Image Building**: The tool builds a Docker image based on Ubuntu 22.04 with all specified tools
2. **User Mapping**: Your local user ID and group ID are mapped into the container for seamless file permissions
3. **Config Mounting**: Selected configuration files are mounted from your home directory
4. **Container Creation**: A container is created from the image with all mounts configured
5. **Entry**: When you enter, it starts the container (if needed) and drops you into a zsh shell

## Troubleshooting

### Podman not found
Make sure Podman is installed and in your PATH:
```bash
podman --version
```

On macOS, ensure the Podman machine is running:
```bash
podman machine start
```

### Container won't start
Check Podman logs:
```bash
podman logs workspace-default
```

### Permission issues
The container uses your user ID, but if you encounter permission issues, check that the mounted config files are readable:
```bash
ls -la ~/.zshrc ~/.config/nvim
```

### Rebuild from scratch
If you encounter issues with the image:
```bash
# Remove the image
podman rmi workspace-container

# Rebuild
./wsc build
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits

Inspired by [distrobox](https://github.com/89luca89/distrobox) - an excellent tool for container-based development environments.

#!/usr/bin/env bash
# Example usage of workspace-container tool

set -e

echo "=== workspace-container Example Usage ==="
echo ""

# Show help
echo "1. Showing help:"
./wsc help
echo ""

# List containers (should be empty initially)
echo "2. Listing containers (should be empty):"
./wsc list
echo ""

echo "=== To use the tool manually ==="
echo ""
echo "Create a container:"
echo "  ./wsc create"
echo ""
echo "Enter the container:"
echo "  ./wsc enter"
echo ""
echo "Inside the container, you'll have access to:"
echo "  - nvim (your editor)"
echo "  - zsh with Oh My Zsh"
echo "  - python3"
echo "  - wget, tshark, tcpdump"
echo "  - Your config files from home directory"
echo ""
echo "Exit the container:"
echo "  exit  (or Ctrl+D)"
echo ""
echo "Destroy the container when done:"
echo "  ./wsc destroy"
echo ""
echo "Create named containers for different projects:"
echo "  ./wsc create project1"
echo "  ./wsc create project2"
echo "  ./wsc enter project1"
echo ""

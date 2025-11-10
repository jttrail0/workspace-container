# Contributing to workspace-container

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- A clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your environment (OS, Podman version)

### Suggesting Enhancements

Feature requests are welcome! Please open an issue describing:
- The use case
- Why this feature would be useful
- Potential implementation approach (optional)

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes thoroughly
5. Ensure your code passes shellcheck: `shellcheck workspace-container`
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to your branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

## Development Guidelines

### Code Style

- Follow existing code style and conventions
- Use meaningful variable names
- Add comments for complex logic
- Keep functions focused and small

### Shell Script Standards

- Use `#!/usr/bin/env bash` shebang
- Use `set -e` for error handling where appropriate
- Quote variables to prevent word splitting: `"${variable}"`
- Use `[[` instead of `[` for conditionals
- Run `shellcheck` before committing

### Testing

Before submitting a PR, test:
- Help command: `./workspace-container help`
- List command: `./workspace-container list`
- Error handling: `./workspace-container invalid-command`
- If possible, test create/enter/destroy cycle

### Dockerfile Changes

If modifying the Dockerfile:
- Keep the image size reasonable
- Document why packages are needed
- Test the build: `./workspace-container build`
- Verify tools work in the container

## Areas for Contribution

Here are some ideas for contributions:

### Easy
- Add more useful tools to the Dockerfile
- Improve documentation
- Add more examples
- Fix typos or improve wording

### Medium
- Add support for custom Dockerfiles
- Implement container backup/restore
- Add configuration file for default settings
- Better error messages and user guidance

### Advanced
- Add support for Docker (in addition to Podman)
- Implement container export/import
- Add networking options
- Support for GPU passthrough
- Integration with IDE/editor plugins

## Questions?

If you have questions, feel free to:
- Open an issue for discussion
- Check existing issues for similar questions
- Review the README and documentation

Thank you for contributing! 🎉

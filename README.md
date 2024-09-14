# Dotfiles

This repository contains my personal dotfiles and an Ansible-based setup for quickly provisioning new development environments. It's designed to automate the process of setting up a new machine with my preferred tools, configurations, and aliases.

## Overview

This project uses Ansible to automate the installation and configuration of various development tools and utilities on both macOS and Linux systems. It includes:

- Installation of common development tools
- Configuration of shell environments (Bash for Linux, Zsh for macOS)
- Setup of version managers (nvm, tfenv)
- Installation and configuration of tools like Terraform, kubectl, Docker, and more
- Configuration of useful aliases and shortcuts

## Repository Structure

```
.
├── Makefile
└── ansible
    ├── inventory
    │   └── localhost
    ├── playbooks
    │   └── main.yml
    └── roles
        ├── common
        │   └── tasks
        │       └── main.yml
        ├── linux
        │   └── tasks
        │       └── main.yml
        └── macos
            └── tasks
                └── main.yml
```

## Prerequisites

- Git
- Make
- Python 3
- Ansible (will be installed by the Makefile if not present)

## Usage

To use this tool to set up a new development environment:

1. Clone this repository:
   ```
   git clone https://github.com/pcnoic/dotfiles.git
   cd dotfiles
   ```

2. Run the setup:
   ```
   make
   ```

   This will detect your OS, install Ansible if necessary, and run the Ansible playbook to set up your environment.

3. Enter your sudo password when prompted (required for some installation tasks).

## What Gets Installed

- Common tools: `tree`, `watch`, `jq`, `kubectl`, `k9s`, `lazygi`t, `gh` (GitHub CLI), `gcc`, `fzf`, `yq`
- Version managers: `nvm` (Node.js), `tfenv` (Terraform)
- Shell enhancements: Starship prompt, Oh My Zsh (macOS), Oh My Bash (Linux)
- And more, depending on your OS...

## Customization

You can customize the installation by modifying the Ansible roles:

- `roles/common/tasks/main.yml`: Tasks common to all systems
- `roles/macos/tasks/main.yml`: macOS-specific tasks
- `roles/linux/tasks/main.yml`: Linux-specific tasks

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open-source and available under the [MIT License](LICENSE).

## Disclaimer

Use at your own risk. Always review scripts and playbooks carefully before running them on your system.

```
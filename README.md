# Forge My Machine

An automated Linux or WSL workstation setup using Ansible.
This playbook installs and configures essential development tools, GUI applications, and system settings optimized for multi-language development

## Features

- Installs core dev tools: shell utilities, compilers
- Modular: add/remove features with simple Ansible roles
- Supports Ubuntu, Debian, and WSL (Windows Subsystem for Linux)

## What This Sets Up

### CLI Enhancements

- **Core Tools**: Git, SSH, GPG, Docker, Dropbox, HashiCorp Vault
- **AI/ML**: ollama, n8n, hugging face
- **CLI**: oh-my-zsh, bash-it
- **CLI AI**: claude-code, gemini-cli, OpenAI Codex, opencode, ampcode
- **Dotfiles**: Optional dotfiles management.
- **devops tools**: AWS, Azure, GCP, kubectl, minikube, terraform, Jenkins
- **System Tools**: Monitoring, file management, and productivity tools

### GUI

- **Editors/IDEs**: VS Code, JetBrains IDEs, Windsurf, Cursor
- **Database Tools**: DBeaver, pgAdmin
- **Browser Tools**: Firefox, Chrome, Browserstack
- **API Testing** - Postman/Insomnia for API development
- **Other GUI Apps**: Slack, Warp, Open WebUI
- **Development Fonts** - Coding-optimized fonts (Fira Code, JetBrains Mono)

### Languages SDKs/runtimes:

- **Python**: pyenv, virtualenv (Version Managers), conda, minconda (package managers)
- **.NET SDK**: 
- **Java**: sdkman! (Version Manager), 
- **Node.js**: nvm (Version Manager), pnpm, yarn (package managers), Angular (framework)
- **Ruby**: rbenv, rvm (Version Managers)
- **Go**: 
- **Rust**: 
- **C/C++**:
- **Kotlin**:

## Quick Start

### Requirements

- Ubuntu 20.04+ (desktop/server/WSL) / Debian 11+
- Internet connection
- Sudo privileges

1. **Run the bootstrap script** (installs Python3, pip, git, and Ansible):

```bash
curl https://raw.githubusercontent.com/jrocha-io/forge-my-machine/main/bootstrap.sh | bash
```

2. **Clone this repository**

```bash
git clone https://github.com/jrocha-io/forge-my-machine.git
cd forge-my-machine
```

3. **Edit group_vars/all.yml** to customize your setup:

```yml
# User preferences
user_name: "Your Name"
user_email: "your.email@example.com"

# Feature toggles
install_gui_apps: true
setup_dotnet: true
setup_docker_desktop: false  # Use Docker Engine instead

# Version preferences
dotnet_version: "8.0"
nodejs_version: "20"
```

4. **Run the Ansible playbook**

```bash
# Run the complete setup
ansible-playbook setup.yml --ask-become-pass

# Or run specific roles only
ansible-playbook setup.yml --tags "development,vscode" --skip-tags "docker" --ask-become-pass
```

The `--ask-become-pass` flag allows Ansible to use sudo when needed.

### Available Tags

| Tag	| Description |
|---|---|
| system | Base system packages and configuration |
| development | Development tools (.NET, Git, Node.js) |
| gui-apps | GUI applications (browsers, IDEs, tools) |
| docker | Docker Engine and Docker Compose |
| vscode | VS Code installation and configuration |
| terminal | Terminal emulator and shell setup |

## Repository Structure

```txt
forge-my-machine/
├── ansible/
│   ├── playbook.yml         # Main Ansible playbook
│   └── roles/               # Modular roles for each tool/language
│       ├── system-basics/     # Base system setup
│       ├── development/       # Development tools
│       ├── gui-apps/          # GUI applications
│       ├── docker/            # Docker setup
│       ├── vscode/            # VS Code configuration
│       ├── jetbrains/         # JetBrains configuration
│       ├── dotnet/
│       ├── go/
│       ├── java/
│       ├── nodejs/
│       ├── python/
│       └── rust/
└── files/
│   ├── dotfiles/          # Configuration files
│   └── scripts/           # Utility scripts
├── group_vars/
│   └── all.yml              # Global variables
├── ansible.cfg              # Ansible configuration
├── bootstrap.sh             # Bootstrap script for prerequisites
├── inventory.yml            # Host configuration
├── README.md                # This file
└── setup.yml                # Main playbook
```

## Customization

Use tags to install subsets (e.g., --tags core,gui).
Edit ansible/playbook.yml to enable/disable roles as needed.
Modify role variables or add your own roles in ansible/roles/.
See each role's README for additional configuration options (coming soon).

## Usage Scenarios

### New Machine Setup

```bash
# Complete workstation setup
./bootstrap.sh
ansible-playbook setup.yml
```

### Update Existing Setup

```bash
# Update all components
ansible-playbook setup.yml

# Update only VS Code extensions
ansible-playbook setup.yml --tags "vscode"
```

### Project-Specific Development

After workstation setup, use Docker for project environments:

```bash
# Example: Spring Boot project
cd my-spring-project
docker-compose up -d
code .
```

## Development Workflow

1. **Workstation Setup** (this repository) - One-time setup of your development machine
2. **Project Development** - Use Docker Compose for project-specific environments
3. **Native Development** - Use installed tools (.NET, Node.js) for optimal performance when needed

## Common Issues

### Permission Errors

```bash
# Ensure your user can run sudo without password for automation
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
```

### WSL2 Specific Issues

```bash
# Enable systemd in WSL2 (Ubuntu 22.04+)
echo -e "[boot]\nsystemd=true" | sudo tee -a /etc/wsl.conf
```

```ps
# Restart WSL:
wsl --shutdown
```

### Docker Permission Issues

```bash
# Add user to docker group (logout/login required)
sudo usermod -aG docker $USER
```

## TODO

[] Review this README.md file
[] Add support for Fedora/CentOS
[] Implement backup/restore functionality
[] Add more IDE options
[] Create uninstall playbook
[] Add automated testing with molecule

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Ansible Community for the excellent automation platform
- Development community for tool recommendations and configurations

## Support

If you encounter any issues:

1. Check the Common Issues section
2. Search existing issues
3. Create a new issue with:
  - Your OS version
  - Error messages
  - Steps to reproduce

## Contributing

This is a personal project, but contributions are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Test your changes on a fresh VM
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

Feel free to fork it and adapt it to your own needs.

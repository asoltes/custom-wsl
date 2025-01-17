# custom-wsl
This folder contains scripts and instructions to generate a personalized WSL Ubuntu image..

Whoops! This code was whipped up in a caffeine-fueled frenzy and barely tested. So hang tight—code enhancements coming soon, I promise! 🚀😅

## Ansible Way

`vi /etc/sudoers`
```shell
# Allow members of group sudo to execute any command
%sudo     ALL=(ALL:ALL) ALL
username  ALL=(ALL) NOPASSWD: ALL
```

```shell
ansible-playbook -i inventory.ini site.yml 
```
## 

```shell
TASK [ets-toolkit : Add Gaz Configuration] *****************************************************************************************************************************************************************************************************************
changed: [localhost]

TASK [ets-toolkit : Source the zshrc script] ***************************************************************************************************************************************************************************************************************
changed: [localhost]

TASK [ets-toolkit : Congratulations! you are almost done, :p] **********************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": [
        "< Congrats, andres! you can now create a new terminal session! and rerun the playbook just to make sure :p lol!>",
        "  -----------------------",
        "    \\",
        "      \\",
        "          .--.",
        "        |o_o |",
        "        |:_/ |",
        "        //   \\ \\",
        "      (|     | )",
        "      /'\\_   _/`\\",
        "      \\___)=(___/",
        ""
    ]
}
```

## Docker Way
Documentation: https://etsinternal.atlassian.net/wiki/spaces/TA/pages/5346101038/How+To+Build+Custom+WSL+Image+with+DevOps+Tools
To make the image type:

```shell
> ./docker/build_image.sh
```

To install the image type

```shell
wsl --import <name> <destination> /path/to/wsl-ubuntu-24.04.tar.gz
```

## Tools and ZSH plugins

| **Command/Tool**                           | **Description**                                                                                           |
|--------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| `iptables, lsof, socat, rsync, gnupg`      | Installs useful distro plumbing tools.                                                                    |
| `wslu`                                     | A collection of utilities for WSL (Windows Subsystem for Linux).                                          |
| `ntpdate`                                  | Synchronizes the system clock with remote NTP servers.                                                    |
| `show-motd`                                | Displays Message of the Day at login.                                                                     |
| `command-not-found`                        | Provides suggestions for command names when a command is not found.                                        |
| `Homebrew`                                 | Installs Homebrew, a package manager for Linux.                                                           |
| `apt-utils, sudo, debianutils`             | Installs packages essential for development and system utilities.                                         |
| `build-essential, pkg-config`              | Installs compilers and related tools.                                                                     |
| `man-db, bash-completion`                  | Installs manual database and bash completion.                                                             |
| `locales`                                  | Generates and installs locale information.                                                                |
| `vim, nano`                                | Installs text editors.                                                                                    |
| `curl, wget`                               | Installs command-line tools for transferring data.                                                        |
| `gzip, unzip`                              | Installs compression and decompression tools.                                                             |
| `tcpdump`                                  | Network packet analyzer.                                                                                  |
| `jq`                                       | Command-line JSON processor.                                                                              |
| `git`                                      | Version control system.                                                                                   |
| `nmap`                                     | Network exploration tool and security scanner.                                                            |
| `dnsutils`                                 | DNS utilities for querying DNS servers.                                                                   |
| `iputils-ping, traceroute, mtr`            | Network diagnostic tools.                                                                                 |
| `whois`                                    | Queries WHOIS database for domain information.                                                            |
| `postgresql-client, redis-tools`           | Database client tools for PostgreSQL and Redis.                                                           |
| `bat`                                      | A cat clone with syntax highlighting and Git integration.                                                 |
| `telnet`                                   | Legacy protocol for communicating with remote devices.                                                    |
| `netcat-openbsd`                           | Versatile networking tool.                                                                                |
| `software-properties-common`               | Manages repository sources.                                                                               |
| `python3, python3-pip, python-is-python3`  | Installs Python 3 and package manager (pip).                                                              |
| `pipx`                                     | Installs Python CLI tools.                                                                                |
| `ripgrep`                                  | Line-oriented search tool.                                                                                |
| `ansible`                                  | IT automation tool.                                                                                       |
| `tzdata`                                   | Installs and configures timezone data.                                                                    |
| `unminimize`                               | Prepares the distribution for interactivity.                                                              |
| `zsh`                                      | Installs Zsh shell.                                                                                       |
| `ohmyzsh`                                  | Framework for managing Zsh configuration.                                                                 |
| `powerlevel10k`                            | Theme for Zsh.                                                                                            |
| `zsh-syntax-highlighting, zsh-autosuggestions` | Plugins for Zsh to provide syntax highlighting and command suggestions.                                |
| `asdf`                                     | CLI tool for managing multiple runtime versions.                                                          |
| `bash-my-aws`                              | Collection of shell scripts for managing AWS resources.                                                   |
| `aws-cli`                                  | Command Line Interface for AWS.                                                                            |
| `terraform`                                | Infrastructure as Code tool.                                                                               |
| `pip3 install pre-commit`                  | Installs pre-commit hooks.                                                                                |
| `terraform-docs`                           | Tool for generating documentation for Terraform modules.                                                   |
| `terrascan`                                | Static code analyzer for Infrastructure as Code.                                                           |
| `tflint`                                   | Linter for Terraform configurations.                                                                      |
| `tfsec`                                    | Security scanner for Terraform code.                                                                      |
| `trivy`                                    | Vulnerability scanner for containers and other artifacts.                                                |
| `tfupdate`                                 | Tool to update Terraform versions.                                                                         |
| `hcledit`                                  | Command-line editor for HashiCorp Configuration Language (HCL).                                           |
| `granted`                                  | Tool for multi-account access for AWS.                                                                    |
| `wsl.conf`                                 | Copies WSL configuration file.                                                                            |
| `add-apt-repository ppa:wslutilities/wslu` | Adds WSL utilities repository.                                                                            |
| `update-motd.d`                            | Copies Message of the Day scripts.                                                                        |
| `hosts`                                    | Copies hosts file.                                                                                        |
| `register.sh`                              | Copies and sets permissions for a registration script.                                                    |
| `.zshrc`                                   | Copies Zsh configuration file.                                                                            |
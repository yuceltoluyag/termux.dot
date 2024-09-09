[Turkish Language](./README.md)

# Termux Installation Script

This script is designed to automate the installation and configuration of various software on Termux. Below you can find the supported software and usage instructions.

## Supported Software

- **Elixir**
- **Golang**
- **Python**
- **Neovim** (with NvChad)
- **Node.js (LTS)**
- **Tmux**
- **Ruby**
- **PHP**
- **Zsh** (with Oh-My-Zsh)
- **Clang and Development Tools**
- **Various utilities**: curl, wget, git, vim, nano, ffmpeg, imagemagick, zip, unzip, cmatrix, figlet, cowsay, toilet, lolcat, and more.

## Installation Instructions

To run this script, first ensure you have Termux installed, and then follow the steps below:

### 1. Clone or download the repository

```bash
git clone https://github.com/yuceltoluyag/termux.dot.git
cd termux.dot
```

### 2. Make the script executable

```bash
chmod +x install.sh
```

### 3. Run the script

Depending on what software you want to install, you can use one of the following commands.

#### To install all software

```bash
./install.sh --all
```

#### To install specific software

| Software | Command                 |
| -------- | ----------------------- |
| Elixir   | `./install.sh --elixir` |
| Go       | `./install.sh --golang` |
| Python   | `./install.sh --python` |
| Neovim   | `./install.sh --nvim`   |
| Node.js  | `./install.sh --nodejs` |
| Tmux     | `./install.sh --tmux`   |
| Ruby     | `./install.sh --ruby`   |
| PHP      | `./install.sh --php`    |
| Zsh      | `./install.sh --zsh`    |

### 4. Restart Termux

For changes like shell updates (e.g., after installing Zsh) or some software configurations, you may need to restart Termux. After installing Zsh, you can restart Termux with the following command:

```bash
exit
```

## Required Dependencies

This script checks and installs the following dependencies if they are missing:

- `git`
- `curl`
- `wget`
- `nano`
- `vim`
- `zip`
- `unzip`
- `nmap`
- `openssh`
- `tmux`
- `ffmpeg`
- `imagemagick`
- `clang`
- `libcrypt-dev`
- `binutils`
- `pkg-config`
- `python3`
- `cmatrix`
- `figlet`
- `cowsay`
- `toilet`
- `lolcat`
- `net-tools`
- `w3m`

## Customization

To customize which software gets installed, you can edit the `install.sh` file. If there are any packages you do not need, you can remove or modify the respective `install_` functions.

## Contributing

If you'd like to contribute, feel free to fork this project, make your changes, and submit a pull request. You can also open an issue for bugs or suggestions.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

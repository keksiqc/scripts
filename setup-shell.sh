# Prompt for Atuin key
echo "Please enter your Atuin key:"
read ATUIN_KEY

# Check and install zsh
echo "Checking zsh installation..."
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    DEBIAN_FRONTEND=noninteractive sudo apt install zsh -y
else
    echo "zsh is already installed"
fi

# Install starship
echo "Checking starship installation..."
if ! command -v starship &> /dev/null; then
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "starship is already installed"
fi

# Install atuin
echo "Checking atuin installation..."
if ! command -v atuin &> /dev/null; then
    echo "Installing atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
else
    echo "atuin is already installed"
fi

# Install zinit
echo "Checking zinit installation..."
if [ ! -d "$HOME/.local/share/zinit" ]; then
    echo "Installing zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
else
    echo "zinit is already installed"
fi

echo "Loading atiuin..."
. "$HOME/.atuin/bin/env"

# Update zinit
echo "Updating zinit..."
zinit self-update

# Configure atuin
echo "Configuring atuin..."
atuin login -u keksi --key "$ATUIN_KEY"
atuin import auto
atuin sync

# Set up zsh configuration
echo "Setting up zsh configuration..."
echo '
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

eval "$(starship init zsh)"
' > ~/.zshrc

# Change default shell to zsh
echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo "✅ Setup complete! Shell has been changed to zsh. Please log out and log back in for changes to take effect."
echo "Please note: The first time you start zsh, zinit will download and install plugins."
echo "This might take a moment. After that, your shell environment will be fully configured."
echo "Starting zsh now..."
exec zsh

#!/usr/bin/env bash
# Sets up everything your .zshrc references, on a clean Mac with Homebrew already installed.
# Run with: bash setup-zshrc-deps.sh
set -e

echo "==> CLI tools your aliases/functions reference"
brew install neovim tmux fzf bat tldr htop lazydocker deno uv volta bash

echo "==> Oh My Zsh (your ZSH_THEME / plugins= line needs this framework)"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "==> Powerlevel10k theme"
[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] || \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

echo "==> zsh plugins NOT bundled with Oh My Zsh (the rest in your plugins= line are built in)"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

echo "==> tmuxifier (used by tf alias)"
[ -d "$HOME/.tmuxifier" ] || git clone https://github.com/jimeh/tmuxifier.git "$HOME/.tmuxifier"
# NOTE: your PATH line says $HOME/.tmuxifierr/bin (double "r") — that looks like a typo.
# Either fix it to .tmuxifier in the zshrc, or rename this clone to match.

echo "==> ThePrimeagen's tmux-sessionizer (bound to Alt+f in your zshrc)"
mkdir -p "$HOME/local/bin"
curl -fsSL -o "$HOME/local/bin/tmux-sessionizer" \
  https://raw.githubusercontent.com/ThePrimeagen/tmux-sessionizer/master/tmux-sessionizer
chmod +x "$HOME/local/bin/tmux-sessionizer"
# NOTE: your PATH line is lowercase: /users/yosefsaaid/local/bin
# macOS's default filesystem is case-insensitive so it'll still resolve, but worth
# fixing to /Users/... to avoid surprises if you ever move to a case-sensitive volume.

echo "==> Apache Spark"
brew install apache-spark
echo "    Your SPARK_HOME is hardcoded to /usr/local/Cellar/apache-spark/3.2.1/libexec"
echo "    Run 'brew info apache-spark' and update the version number in .zshrc to match."

echo "==> Window manager tools (only needed if you actually use skhd/yabai — reload_wm fn assumes them)"
brew install koekeishiya/formulae/skhd koekeishiya/formulae/yabai

echo "==> Deno zsh completions (your FPATH line expects these)"
mkdir -p "$HOME/.zsh/completions"
deno completions zsh > "$HOME/.zsh/completions/_deno"

echo ""
echo "Done with what's scriptable. Manual steps left:"
echo "  1. Restore ~/.p10k.zsh from a backup, or run 'p10k configure' after restarting your shell."
echo "  2. Recreate ~/-_-/mpj — that's a personal scripts folder on your PATH with no public"
echo "     source, so brew/git can't fetch it. Pull it from your old machine or dotfiles repo."
echo "  3. Docker Desktop isn't brew-installable as a CLI-only dep the way these are —"
echo "     'brew install --cask docker' if you want it, then open it once to finish setup."
echo "  4. Restart your terminal (or run: exec zsh) once everything above is in place."

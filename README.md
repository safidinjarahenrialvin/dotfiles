# Dotfiles

Configuration de mon système EndeavourOS (Hyprland/Wayland), suivie avec Git
via la méthode du **bare repository**.

## Méthode utilisée : bare repo + alias

Contrairement à un dépôt Git classique, ce dépôt ne contient pas de
work-tree : le `git-dir` est stocké séparément (`~/.dotfiles`), et
`$HOME` sert directement de work-tree. Un alias shell relie les deux.

Référence : https://wiki.archlinux.org/title/Dotfiles

## Reproduire cette config sur une nouvelle machine

1. Cloner le dépôt en mode bare :
```bash
   git clone --bare git@github.com:votrenom/dotfiles.git $HOME/.dotfiles
```

2. Définir l'alias (à ajouter aussi dans `~/.zshrc`) :
```bash
   alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
```

3. Récupérer les fichiers dans `$HOME` :
```bash
   dotfiles checkout
```
   Si des fichiers existants entrent en conflit, les sauvegarder avant
   (`mv` vers un dossier de backup) puis relancer `checkout`.

4. Masquer les fichiers non suivis dans `git status` :
```bash
   dotfiles config status.showUntrackedFiles no
```

## Utilisation au quotidien

```bash
dotfiles status
dotfiles add <fichier ou dossier>
dotfiles commit -m "message"
dotfiles push
```

## Contenu suivi

- `~/.config/hypr/` — Hyprland (compositeur, layout Scrolling, keybinds)
- (à compléter au fur et à mesure)

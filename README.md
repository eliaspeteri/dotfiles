# Dotfiles

## Pulling dotfiles into local machine

1. `alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'`
2. `git clone --bare <dotfiles-repo-url> $HOME/dotfiles`
3. `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'` if it's not done already.
4. `config checkout`

  `config checkout` might fail with the following message:
  ```
  error: The following untracked working tree files would be overwritten by checkout:
      .bashrc
      .gitignore
  Please move or remove them before you can switch branches.
  Aborting
  ```
  This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care. I provide you with a possible rough shortcut to move all the offending files automatically to a backup folder:
  ```shell
  mkdir -p .config-backup && \
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
  ```
5. Set `showUntrackedFiles` to `no` with `config config --local status.showUntrackedFiles no`

Used this tutorial --> https://www.atlassian.com/git/tutorials/dotfiles

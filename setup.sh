#!/usr/bin/env sh

dir=~/dotfiles                  # dotfiles directory
olddir=~/dotfiles_old           # old dotfiles backup directory
files1="bashrc zshrc"           # list of files in shell/ to be symlinked
files2="vimrc vimrc-sensible irbrc tmux.conf"               # list of files to be symlinked
folders="oh-my-zsh vim"         # list of folders to be symlinked

echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

echo -n "Creating $dir for new dotfiles in ~ ..."
mkdir -p $dir
echo "done"
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

for folder in $folders; do
    echo "Moving existing $folder folder from ~ to $olddir"
    mv ~/.$folder $olddir/
    echo "Creating symlink to $folder in home directory."
    ln -s $dir/$folder ~/.$folder
done

for file in $files1; do
    echo "Moving existing $file file from ~ to $olddir"
    mv ~/.$file $olddir/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/shell/$file ~/.$file
done

for file in $files2; do
    echo "Moving existing $file file from ~ to $olddir"
    mv ~/.$file $olddir/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

install_zsh () {
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    platform=$(uname);
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh

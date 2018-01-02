#!/bin/sh
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# Variables

dir=~/dotfiles                    # dotfiles directory
old_dir=dotfiles_old              # old dotfiles backup directory
target_dir=~                      # target directory
files="zlogin vimrc vim zshrc gitconfig gitignore_global aliases osx"    # list of files/folders to symlink in homedir

# create dotfiles_old in target dir
echo "Creating $old_dir for backup of any existing dotfiles in $target_dir"
mkdir -p $target_dir/$old_dir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $old_dir"
    mv ~/.$file $target_dir/$old_dir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file $target_dir/.$file
done

echo "Cloning vim plugins"
cd $dir/vim/bundle
git submodule sync
git submodule update --init

cd $dir
echo "...done"

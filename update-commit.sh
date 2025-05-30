Dir=/home/babu/.config/nixos
git -C $Dir add -A &&
git -C $Dir commit -m "$(date)" &&
sudo nixos-rebuild switch --flake $Dir/#msi &&
git -C $Dir push 

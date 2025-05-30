Dir=/home/babu/.config/nixos
git -C $Dir add -A &&
git -C $Dir commit -m "Stable $(date)" &&
git -C $Dir push 

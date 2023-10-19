# b48
A 2048 game implementation written purely in bashscript. Since the random "2" placement was generated via `gshuf`, if `coreutils` is not installed on your machine, you will need to install it:
```
brew install coreutils
```
Currently only supports WASD keys and Q to quit. Also, the game currently 
does not detect game loss. It will quit once it cannot generate new tiles.

### TODO
- [ ] Arrow-key command support
- [X] View of final board (Oct.18.2023)
- [ ] Refactor repetitive logic
- [ ] Detection of game ending

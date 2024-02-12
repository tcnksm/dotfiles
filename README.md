tcnksm does dotfiles [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/tcnksm/dotfiles/blob/master/LICENCE)
====

Your dotfiles are how you personalize your system. These are mine :memo:

## Setup

Add a new SSH key to your GitHub account 🔐:

```bash
$ mkdir ~/.ssh
$ cd ~/.ssh
$ ssh-keygen -t ed25519 -C "email@example.com" -f github_ed25519
$ pbcopy < github_ed25519.pub
```

Clone this repository: 

```bash
$ mkdir -p ~/src/github.com/tcnksm/
$ cd ~/src/github.com/tcnksm/
$ git clone git@github.com:tcnksm/dotfiles.git
```

## Author

[Taichi Nakashima](https://github.com/tcnksm)

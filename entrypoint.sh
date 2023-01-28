#!/bin/sh

repo="$(printenv REPO)"

mkdir -v "$HOME/build"
cd "$HOME"

asp update linux
asp export linux

cd linux

sed -i 's/^pkgbase=.*$/pkgbase=linux-alexcoder04/' PKGBUILD
sed -i 's/^pkgname=.*/pkgname=("$pkgbase" "$pkgbase-headers")/' PKGBUILD

makepkg -s

printenv GITHUB_KEY | gh auth login --with-token
gh release create "latest" ./*.pkg.tar.zst --repo "$repo"
gh auth logout -h github.com

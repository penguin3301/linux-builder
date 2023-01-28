#!/bin/sh

set -e

repo="$(printenv REPO)"

cd "/data"
sudo mkdir "build"
sudo chown -vR "builder:builder" "build"
sudo chmod -v 700 build
ls -l
cd "build"

gpg --keyserver keys.openpgp.org --recv-keys 19802F8B0D70FC30
gpg --keyserver keys.openpgp.org --recv-keys 3B94A80E50A477C7

asp update linux
asp export linux

cd linux

sed -i 's/^pkgbase=.*$/pkgbase=linux-alexcoder04/' PKGBUILD
sed -i 's/^pkgname=.*/pkgname=("$pkgbase" "$pkgbase-headers")/' PKGBUILD

makepkg -s

printenv GITHUB_KEY | gh auth login --with-token
gh release create "latest" ./*.pkg.tar.zst --repo "$repo"
gh auth logout -h github.com

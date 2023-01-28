#!/bin/sh

set -e

repo="$(printenv REPO)"

cd "/data"

sudo mkdir "build"
sudo chown -vR "builder:builder" "build"
sudo chmod -v 700 "build"

sudo mkdir "cache"
sudo chown -vR "builder:builder" "cache"
sudo chmod -v 700 "cache"

cd "build"

gpg --keyserver keys.openpgp.org --recv-keys 19802F8B0D70FC30
gpg --keyserver keys.openpgp.org --recv-keys 3B94A80E50A477C7

asp update linux
asp export linux

cd linux

sed -i 's/^pkgbase=.*$/pkgbase=linux-alexcoder04/' PKGBUILD
sed -i 's/^pkgname=.*/pkgname=("$pkgbase" "$pkgbase-headers")/' PKGBUILD

export CCACHE_DIR="/data/cache"
export CC="ccache gcc"
export MAKEFLAGS="-j$(nproc)"
ccache -M 9
ccache -s

makepkg -s

printenv GITHUB_KEY | gh auth login --with-token
gh release create "latest" ./*.pkg.tar.zst --repo "$repo"
gh auth logout -h github.com

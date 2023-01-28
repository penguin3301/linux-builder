#!/bin/sh

set -e

repo="$(printenv REPO)"

cd "/data/linux"

gpg --recv-keys 3B94A80E50A477C7
gpg --recv-keys 19802F8B0D70FC30

asp update linux
asp export linux

cd linux

sed -i 's/^pkgbase=.*$/pkgbase=linux-alexcoder04/' PKGBUILD
sed -i 's/^pkgname=.*/pkgname=("$pkgbase" "$pkgbase-headers")/' PKGBUILD

makepkg -s

printenv GITHUB_KEY | gh auth login --with-token
gh release create "latest" ./*.pkg.tar.zst --repo "$repo"
gh auth logout -h github.com

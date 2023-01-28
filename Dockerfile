FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel bc cpio github-cli
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
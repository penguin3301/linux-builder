FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel bc cpio github-cli asp
RUN useradd -m builder
USER builder
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
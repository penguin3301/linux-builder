FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel bc cpio github-cli
RUN useradd -m xanmod_builder
USER xanmod_builder
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
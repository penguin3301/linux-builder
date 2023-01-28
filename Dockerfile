FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel bc cpio github-cli asp
RUN adduser builder wheel
RUN usermod -aG wheel builder
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD:ALL" >/etc/sudoers.d/00-sudo-nopasswd
USER builder
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
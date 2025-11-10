# Use Fedora base image
FROM fedora:43

# Install packages via dnf
RUN dnf -y update && dnf -y install \
    curl \
    wget \
    git \
    zsh \
    python3 \
    python3-pip \
    neovim \
    wireshark-cli \
    tcpdump \
    sudo \
    glibc-langpack-en \
    passwd \
    util-linux-user \
    && dnf -y clean all

# Set locale env
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a non-root user
ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN /bin/sh -c '\
    if ! getent group "$USER_GID" >/dev/null 2>&1; then \
        groupadd --gid "$USER_GID" "$USERNAME"; \
    else \
        echo "group with GID $USER_GID already exists"; \
    fi && \
    if ! id -u "$USERNAME" >/dev/null 2>&1; then \
        useradd --uid "$USER_UID" --gid "$USER_GID" -m "$USERNAME"; \
    else \
        echo "user $USERNAME already exists"; \
    fi && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

# Copy helper CLI into image and make executable
# (copied before switching to non-root user)
COPY wsc /usr/local/bin/wsc
RUN chmod +x /usr/local/bin/wsc || true

# Switch to the non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# Install Oh My Zsh (as non-root user)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true

# Set zsh as the default shell for the user
RUN sudo chsh -s $(which zsh) $USERNAME || true

# Set default editor to nvim
ENV EDITOR=nvim
ENV VISUAL=nvim

# Default command starts the wsc helper
CMD ["wsc"]

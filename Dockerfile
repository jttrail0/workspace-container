FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install base packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    zsh \
    python3 \
    python3-pip \
    neovim \
    tshark \
    tcpdump \
    sudo \
    locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a non-root user
ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the user
USER $USERNAME
WORKDIR /home/$USERNAME

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set zsh as the default shell
RUN sudo chsh -s $(which zsh) $USERNAME

# Set default editor to nvim
ENV EDITOR=nvim
ENV VISUAL=nvim

CMD ["/bin/zsh"]

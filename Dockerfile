FROM ubuntu:latest
LABEL maintainer="Anooj Patel &lt;<a href="mailto://1996anoojpatel@gmail.com">1996anoojpatel@gmail.com</a>&gt;"

########################################################
# Essential packages for remote debugging and login in
########################################################

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends\
    apt-utils gcc g++ openssh-server cmake build-essential gdb gdbserver rsync neovim locales 
# Deal with docker hanging waiting for stdin
RUN apt-get install -y --no-install-recommends git-core bzip2 wget gnupg locales fonts-powerline zsh curl dirmngr apt-transport-https ca-certificates openssh-server tmux && \
    locale-gen en_US.UTF-8 && \
    adduser --quiet --disabled-password --shell /bin/zsh --home /home/devuser --gecos "User" devuser && \
    echo "devuser:p@ssword1" | chpasswd &&  usermod -aG sudo devuser && \
    apt-get clean

#setup ssh
RUN mkdir /var/run/sshd && \
    echo 'root:root_pwd' |chpasswd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    mkdir /root/.ssh

#remove leftovers
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose 22 for ssh server. 7777 for gdb server.
EXPOSE 22 7777

# add user for debugging
RUN useradd -ms /bin/bash debugger
RUN echo 'debugger:debugger_pwd' | chpasswd

########################################################
# Add custom packages and development environment here
########################################################

########################################################

CMD ["/usr/sbin/sshd", "-D"]

#add support for English and Italian

ADD scripts/installthemes.sh /home/devuser/installthemes.sh
USER devuser
ENV TERM xterm
ENV ZSH_THEME agnoster
CMD ["zsh"]


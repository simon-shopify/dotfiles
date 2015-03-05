FROM ubuntu:14.04
MAINTAINER Simon Génier <simon.genier@shopify.com>

RUN apt-get -y --force-yes update \
 && apt-get -y --force-yes install \
      software-properties-common \
 && apt-add-repository -y ppa:brightbox/ruby-ng \
 && apt-get -y --force-yes update \
 && apt-get -y --force-yes install \
      build-essential \
      sudo \
      ruby2.2 ruby2.2-dev \
      emacs24-nox emacs24-el \
      git \
      zsh \
      tmux \
 && gem install pry pry-byebug pry-stack_explorer \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN groupadd -g 999 docker \
 && useradd \
      -G sudo,docker \
      -d /home/sgnr \
      -m \
      -s /bin/zsh \
      sgnr
USER sgnr
ENV HOME /home/sgnr
ENV SSH_AUTH_SOCK /home/sgnr/.ssh/auth-sock/auth-sock

RUN mkdir -p ${HOME}/src \
 && mkdir -p ${HOME}/.config \
 && mkdir -p ${HOME}/.ssh \
 && cd ${HOME}/src \
 && git clone --recursive https://github.com/sgnr/dotfiles.git dotfiles \
 && cd dotfiles \
 && ./link.rb \
 && git remote rm origin \
 && git remote add origin git@github.com:sgnr/dotfiles.git

WORKDIR /home/sgnr
CMD /bin/zsh

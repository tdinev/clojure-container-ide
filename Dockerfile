# The latest tag contains Clojure CLI as well as Leiningen.
FROM clojure:latest

LABEL maintainer="todor.dinev@gmail.com"

# Install some packages and add a user and a group.
RUN apt-get update && \
    apt-get install -y emacs git curl tree httpie jq figlet lolcat && \
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g 1001 developers && \
    useradd -m -s /bin/bash -g developers -u 1001 dev && \
    chown -R dev:developers /home/dev

USER dev

# Install Prelude and a local copy of some Emacs package archives.
RUN --mount=type=bind,source=init-prefix.el,target=/home/dev/init-prefix.el \
    git clone https://github.com/bbatsov/prelude.git ~/prelude && \
    ln -s ~/prelude ~/.emacs.d && \
    git clone --depth 1 https://github.com/d12frosted/elpa-mirror.git ~/prelude/elpa-mirror && \
    cat ~/init-prefix.el ~/prelude/init.el > ~/merged && mv ~/merged ~/prelude/init.el && \
    echo 'eval "$(starship init bash)"' >> ~/.bashrc

WORKDIR /home/dev/workspace

CMD ["bash"]

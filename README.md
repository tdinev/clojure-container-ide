# Portable Clojure development environment

## 💼 Contents

The `Dockerfile` in this repository allows building an OCI image usable as a portable development environment based on the [official Clojure image](https://hub.docker.com/_/clojure) tagged `tools-deps-bookworm`.
The produced image contains, apart from the Clojure CLI, the following manually added utilities:

* [Emacs](https://www.gnu.org/software/emacs)
* [Prelude configuration](https://prelude.emacsredux.com) for Emacs
* [CIDER](https://cider.mx/) for Clojure development in Emacs (because, somehow, Prelude does not install it by default, contrary to what is written in its [docs](https://prelude.emacsredux.com/en/latest/modules/clojure/))
* Local mirrors of the following package archives for Emacs:
  * [GNU ELPA](https://elpa.gnu.org)
  * [Org mode ELPA](https://orgmode.org)
  * [MELPA](https://melpa.org)

  maintained by [d12frosted](https://github.com/d12frosted/elpa-mirror) and as instructed by [ninrod](https://github.com/ninrod/emacs-antiproxy).

* some command-line utilities like
  * [Starship](https://starship.rs/) prompt
  * [tree](https://en.wikipedia.org/wiki/Tree_(command)) for recursive directory listings
  * [HTTPie](https://httpie.io/) for HTTP API testing
  * [jq](https://jqlang.github.io/jq/) for JSON processing
  * [figlet](http://www.figlet.org/) for making ASCII art
  * [lolcat](https://github.com/busyloop/lolcat) for rainbow colouring text (accessible under `/usr/games/lolcat`)
* [deps-new](https://github.com/seancorfield/deps-new), a Clojure tool for handily creating projects

This repository arose from a need to be able to play and experiment with Clojure and functional programming in general in environments that are behind a corporate firewall and thus make downloading artifacts and installing executables difficult or at the very least unpleasant.

> [!WARNING]
> The produced image is *by no means minimal* and it is not designed to be.
> On the contrary, a handful of development tools deemed useful are installed to make for a more enjoyable developer experience.
> This, and above all the local versions of the Emacs package archives, leads to a large image size, currently around 3.5 GB.

## ❗️ Prerequisites

The only prerequisite is a container platform like [Docker](https://www.docker.com) or [Podman](https://podman.io).

## 💡 Usage

The following are instructions for novices.

### Get contents

Clone this repository using Git

```bash
git clone https://github.com/tdinev/clojure-container-ide.git
```

or download and extract the [ZIP archive](https://github.com/tdinev/clojure-container-ide/archive/refs/heads/master.zip).

### Build local image

Build the OCI image:

```bash
docker build -t clojure-ide clojure-container-ide
```

`clojure-ide` denotes the name of the image, its tag is `latest` (since no tag has explicitly been specified), and `clojure-container-ide` is the name of the directory containing the contents of this repository.

This step may take some time (probably up to two minutes) as several packages need to be downloaded.

### Start a container

Spin off a container in interactive mode:

```bash
docker run -it --name clojure-dev clojure-ide
```

The container will be called `clojure-dev` in this case.

### Use the container

You are now in a bash environment.
You can play around with the Clojure REPL:

```bash
clojure
```

(You can exit the REPL by sending the `EOF` character, usually by typing `CTRL+D` or `CTRL+Z`.)

or you can create a new application using *deps-new:*

```bash
clojure -Tnew app :name tdinev/demo
```

Interacting (via [Git Bash](https://git-scm.com/downloads/win) on Windows) looks like this:

![The end result](docs/end-result.png)

### Stopping the container

You can exit the container from within by typing

```bash
exit
```

in the shell.

### Resuming the container

If the container is exited, you can resume it to avoid the somewhat long waiting time when creating a new one

```bash
docker container start clojure-dev
docker attach clojure-dev
```

### Deploying commands as `root`

If you want to spawn off a bash as `root` in a running container (e.g., to install further packages), you can use

```bash
docker exec -it -u root clojure-dev bash
```

provided the container name is `clojure-dev`.

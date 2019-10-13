# Understand your code with Machine Learning on Source Code

Workshop given at [DevFest Nantes 2019](https://devfest.gdgnantes.com/sessions/understand_your_code_with_machine_learning_on_source_code/).

<details>
<summary>Abstract</summary>

> Machine Learning on Source Code (MLonCode) is an emerging and exciting research domain which stands at the sweet spot between deep learning, natural language processing, social science, and programming.
>
> During this 2 hours workshop, we are going to show you how to extract insights from code bases—step by step—by shedding light on those crucial aspects:
>
> - What information is available in your code
> - How to extract this information
> - What can you do with this knowledge: what are the tasks solvable by MLonCode
> - Which models can be used to solve them
>
> To get our hands dirty, we will solve several example tasks, using source{d}, an open source stack to gain insights from codebases:
>
> - Suggest function names automatically
> - Cluster developers
> - Search projects by similarity
>
> Prerequisites: a laptop with Docker installed. We will provide an image to all participants.

</details>

## Setup

### With make

To build the workshop image and launch the 3 required containers

```shell
make build-and-run
```

To only launch the 3 required containers

```shell
make
```

### Without make

Run bblfsh

```shell
docker run \
    --detach \
    --rm \
    --name devfest_bblfshd \
    --privileged \
    --publish 9432:9432 \
    bblfsh/bblfshd:v2.15.0-drivers \
    --log-level DEBUG
```

Run gitbase

```shell
docker run \
    --detach \
    --rm \
    --name devfest_gitbase \
    --publish 3306:3306 \
    --link devfest_bblfshd:devfest_bblfshd \
    --env BBLFSH_ENDPOINT=devfest_bblfshd:9432 \
    --env MAX_MEMORY=1024 \
    --volume /home/mog/work/devfest2019-workshop/repos:/opt/repos \
    srcd/gitbase:v0.24.0-rc2
```

Build the jupyter image

```shell
docker build -t devfest .
```

Run the jupyter image

```shell
docker run \
    --rm \
    --name devfest_jupyter \
    --publish 8888:8888 \
    --link devfest_bblfshd:devfest_bblfshd \
    --link devfest_gitbase:devfest_gitbase \
    --volume /home/mog/work/devfest2019-workshop/notebooks:/devfest/notebooks \
    --volume /home/mog/work/devfest2019-workshop/repos:/devfest/repos \
    devfest
```

# Understand your code with Machine Learning

Workshop given at [DevFest Nantes 2019](https://devfest.gdgnantes.com/sessions/understand_your_code_with_machine_learning_on_source_code/).

Slides: on [gDrive](https://docs.google.com/presentation/d/1vF0JMagmXXzn-h-OaJu6CsDt78oSQSg58YFJsBUaHxk/edit#slide=id.g4f0d75b8b4_0_0)

OSS tools covered:

- [gitbase](https://docs.sourced.tech/gitbase)
- [bblfsh](https://doc.bblf.sh)
- [BigARTM](http://bigartm.org)
- [OpenNMT](http://opennmt.net)

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

Slides: on [gDrive](https://docs.google.com/presentation/d/1vF0JMagmXXzn-h-OaJu6CsDt78oSQSg58YFJsBUaHxk/edit#slide=id.g4f0d75b8b4_0_0)

## Prerequisites

- Docker

## Dependencies

Import Docker images (works offline):

```
docker load -i images/jupyter.tgz
docker load -i images/gitbase.tgz
docker load -i images/bblfshd-with-drivers.tgz

docker images
```

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
    --volume $(pwd)/repos/git-data:/opt/repos \
    srcd/gitbase:v0.24.0-rc2
```

Run the jupyter image

```shell
docker run \
    --rm \
    --name devfest_jupyter \
    --publish 8888:8888 \
    --link devfest_bblfshd:devfest_bblfshd \
    --link devfest_gitbase:devfest_gitbase \
    --volume $(pwd)/notebooks:/devfest/notebooks \
    --volume $(pwd)/repos:/devfest/repos \
    devfest
```

<details>
<summary>With make</summary>

To build the workshop image and launch the 3 required containers

```shell
make build-and-run
```

To only launch the 3 required containers

```shell
make
```

</details>

## Workflow

### 1. Download the data

We are going to use top XXX repositories from Apache Software Foundation though this workshop.

[Notebook 1: data collection pipeline](#link to local jupyther)

### 2. Project and Developer Similarities

TBD

[Notebook 2: project and developer similarities](#link to local jupyther)

### 3. Function Name Suggestion

TBD

[Notebook 2: function name suggestion](#link to local jupyther)

Images, created for workshop to be used offline.

# bblfshd + drivers image

```
docker pull bblfsh/bblfshd:v2.15.0-drivers
docker save -o images/bblfshd-with-drivers.tgz bblfsh/bblfshd:v2.15.0-drivers
```


# gitbase image

```
docker pull srcd/gitbase:v0.24.0-rc2
docker save -o images/gitbase.tgz srcd/gitbase:v0.24.0-rc2
```

# jupyter image

Build the jupyter image:

```shell
docker build -t mloncode/devfest .
docker save -o images/jupyter.tgz mloncode/devfest
```

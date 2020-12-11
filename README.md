# hello tikv + rust

This is an example of using the rust tikv client to
talk to tikv.  It uses `docker stack` to bring up tikv.

It's based on [this document](https://tikv.org/docs/4.0/tasks/try/docker-stack/).

## start tikv using docker stack

```sh
docker stack deploy --compose-file stack.yml tikv
```

## build the client app

You need to build the app in docker so that it can be run as
part of the docker stack environment.

```sh
docker build -t hello-tikv-rust .
```

## run the client app

```sh
docker run -ti --rm --network tikv tikv-example
```

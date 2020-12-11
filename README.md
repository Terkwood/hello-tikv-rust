# hello tikv + rust

This is an example of using the rust tikv client to
talk to tikv.  It uses `docker stack` to bring up tikv.

Everything in this repository is based on [this official document](https://tikv.org/docs/4.0/tasks/try/docker-stack/). But we had to make changes to get the client app `Dockerfile` working.

## start tikv using docker stack

```sh
docker swarm init
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
docker run -ti --rm --network tikv hello-tikv-rust
```

## when you're done

If you normally run `docker-compose` as a single node, and you
don't want anything to do with `docker swarm`, you can leave
the swarm.  _Be careful, this is destructive._

```sh
docker swarm leave --force
```

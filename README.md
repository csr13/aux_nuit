## Tools

These are just some tools that I must have when working. I keep adding tools.

### Two use cases:
* First drop on a fresh ubuntu server.
* Running experiments inside a docker image.

---

#### Use case one.

On a fresh server -- Displays help.

```
$~: git clone https://github.com/csr13/aux_nuit.git ~/tools && cd ~/tools && /bin/bash setup.sh
```

---

#### Use case two

For a docker container to conduct exepriments or reverse code, contain apps, etc, build the docker file and then run it

```
$~: docker build --tag=dev:dev .
$~: docker run --rm -it dev:dev bash
```

Inside container run this to install tmux and vim, to ease the pain.

```shell
$~: ansible-playbook setup.yml
```

#### To Do

- [ ] Update setup.sh

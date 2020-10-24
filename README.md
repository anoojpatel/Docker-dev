# Dockerfile and Scripts for Docker Development Environment
Easily launch a docker container around your working directory to maintain state. This is the barebones version of 
and Ubuntu instance. Build via:
```
docker build --rm -f Dockerfile -t ubuntu:<NAME> .
```
To run a specific directory as `/developer` for the working directory do:
```
docker run --rm -it -v `pwd`:/developer ubuntu:<NAME>

```
Then run:
```
docker container ls -a
```
to get the list of the current running containers to snapshot via:
```
docker commit <SHA START> ubuntu:<NAME>
```

To start deleting things go [here](https://linuxize.com/post/how-to-remove-docker-images-containers-volumes-and-networks/#:~:text=Docker%20provides%20a%20docker%20image,remove%20dangled%20and%20unused%20images.&text=y%2FN%5D%20y-,Use%20the%20%2Df%20or%20%2D%2Dforce%20option%20to%20bypass%20the,tag%2C%20it%20would%20be%20removed.)


## Contains the Dockerfile and subsequent scripts to install zsh themes
 - ~Note:~ On the first install, you will need to instantiate the `~/.zshrc` and set the theme.
### 

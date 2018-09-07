hadoop 3 ecosystem
===

# 1) create hadoop image

```bash
$ docker build -t hadoop-3 hadoop/
```

**obs1:** The download parts are the more slow, if this is a problem to you if you try refac this image, i recommend to you download the .tar files and use COPY in Dockerfile else download


**obs2:** The data example are from https://www.kaggle.com/abecklas/fifa-world-cup/data


# 2) up docker-compose
```bash
$ docker-compose up
```

# 3) enter in spark docker
```bash
$ docker exec -it spark bash
```
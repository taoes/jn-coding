---
title: Docker构建镜像的最佳实践
date: 2021-10-04 23:42:20
urlName: docker-build-opt
categories: Docker
tags: 
    - docker
    - 最佳实践
---

Docker多阶段构建的特性是在17.05以后引入的新功能，旨在解决编入和构建逻辑复杂的问题，依次减少每一个图层。想象一下，你需要自动构建一个基于Maven或者基于NodeJS的项目，那么通过源码构建的时候Maven或者NPM 都会下载大量的依赖的问题，这些文件旨在构建的时候的时候有用，我们也仅仅是需要一个JAR文件或者NodeJS编译出来的文件!!! 

<!--more-->
这种场景下就可以祭出这张图了
![docker镜像构建时依赖](https://pic.zhoutao123.com/blog/docker-build-1.png)
同样的还有其他的步骤，比如Maven的多模块构建，那么**多阶段构建镜像**就是为了解决这样的问题: 使Docker镜像尽可能的小，在交付中更加方便！


这里我们以普通的 nodeJS 项目为例，下面的Dockfile文件展示了标准的Maven项目构建过程。
```dockerfile
FROM node:latest
COPY . /tmp/source
WORKDIR /tmp/source
RUN npm install && npm build
COPY /tmp/source/dist /app
ENTRYPOINT ["nginx","start"]
```
对于上面的构建过程，一些读者可能会发现，在构建的过程中将产生大量的文件，这些文件将一直存放在镜像层中。通常情况下，我们可能会使用shell脚本实现这种

1. 先构建依赖的镜像 I1 
1. 使用镜像I1,运行容器C1
1. 从容器C1  中拷贝出需要的文件
1. 重新构建新的容器，将上述步骤中生成的文件拷贝到新的镜像中
1. 删除构建过程中的冗余的镜像和容器


在使用多阶段构建之后，步骤就会少了很多，多阶段构建大大简便了这种流程！！

## 多阶段构建
对于多阶段构建，您可以在Dockerfile中使用多个FROM语句。每个FROM指令可以使用不同的基础，并且每个指令都开始一个新的构建。您可以选择性地将工件从一个阶段复制到另一个阶段，从而在最终image中只留下您想要的内容。
```dockerfile
FROM node:latest
COPY . /tmp/source
WORKDIR /tmp/source
RUN npm install && npm build



FROM nginx:latest
#从第一个构建阶段中拷贝文件
COPY --from=0 /tmp/source /web/app/
```
在终端中使用 `docker builf -t test-image:1.0 .` 后就可以执行多阶段构建，不需要多余的脚本！ `COPY --from=0`  是将前一阶段的构建产物中复制，其他数据则被丢弃。

默认情况下，阶段未命名，只能通过阶段数来标识，比如上面的Dockerfile就是通过整数0 标识从第一个构建的阶段中获取数据。因此可以通过为阶段命名的方式，使构建文件可读性增强
```dockerfile
FROM node:latest AS BUILD
COPY . /tmp/source
WORKDIR /tmp/source
RUN npm install && npm build

FROM nginx:latest
#从第一个构建阶段中拷贝文件
COPY --from=BUILD /tmp/source /web/app/
```
在构建阶段，还有一种场景，您希望仅仅调试应用数据，比如只要通过第一步构建就够了，那么多阶段构建脚本也支持在某个阶段停止继续构建的功能, 比如使用下面的命令构建当执行完BUILD阶段的时候则不会继续执行下一阶段
```shell
docker build --target=BUILD -t test-image:1.0 .
```


<a name="7EzkA"></a>
### 从其他镜像中构建
使用多阶段构建时，您不仅可以从Dockerfile中创建的镜像中进行复制。您还可以使用COPY –from指令从单独的image中复制，使用本地image名称，本地或Docker注册表中可用的标记或标记ID。 如有必要，Docker会提取image并从那里开始复制，当该镜像不存在的时候，Docker会自动拉取该镜像，在拉取完成后继续执行。

```shell
COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf
```
<a name="PrKyA"></a>
## JIB 插件构建

JIB 是Google提供的一个为Java应用构建Docker镜像的工具，Jib无需Docker守护程序即可为Java应用程序构建优化的Docker和OCI映像-无需深入掌握Docker最佳实践。它可以作为Maven和Gradle的插件以及Java库使用。笔者使用其最重要的功能就是，每次推送镜像仅仅构建变动的文件记录，不在推送整个层，构建文件的体积以及拉取的体积大大减少。笔者实践的过程，构建过程中，从1分钟的构建到只需要10S构建，镜像拉取也是瞬间完成，非常推荐使用。
JIB的目标是为了提供:

- **快速**-**快速**部署您的更改。Jib将您的应用程序分成多个层，将依赖项与类分开。现在，您不必等待Docker重建整个Java应用程序-只需部署已更改的层。
- **可重现**-用相同的内容重建容器映像始终会生成相同的映像。永远不要再次触发不必要的更新。
- **无守护程序**-减少CLI依赖性。从Maven或Gradle内部构建Docker映像，然后推送到您选择的任何注册表。_无需再编写Dockerfile并调用docker build / push。_
- _

_您可以参考 [JIB 官网提供的 集成SpringBoot构建的项目](https://github.com/GoogleContainerTools/jib/blob/master/examples/spring-boot/build.gradle) 的功能完成配置_

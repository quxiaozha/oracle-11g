FROM centos:7
MAINTAINER jaspeen

ADD assets /assets

#设置时区 设置yum源为阿里云 执行oracle安装前置脚本
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo 'Asia/Shanghai' >/etc/timezone \
  && mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
  && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum makecache \
  && chmod -R 755 /assets \
  && /assets/setup.sh

EXPOSE 22 1521 8080

CMD ["/assets/entrypoint.sh"]

FROM centos:7

#基于https://github.com/jaspeen/oracle-11g
#https://github.com/quxiaozha/oracle-11g/
MAINTAINER quxiaozha

ADD assets /assets

#设置时区 设置yum源为阿里云 执行oracle安装前置脚本
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo 'Asia/Shanghai' >/etc/timezone \
  && mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
  && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && yum clean all \
  && chmod -R 755 /assets \
  && /assets/setup.sh

EXPOSE 22 1521 8080

CMD ["/assets/entrypoint.sh"]

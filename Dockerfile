FROM mattrayner/lamp:latest-1804-php7

RUN apt-get update -y
RUN apt-get install -y samba
COPY src/smb.conf /etc/samba/smb.conf
COPY src/supervisord-smbd.conf /etc/supervisor/conf.d/supervisord-smbd.conf
RUN sed -i 's#files=/etc/supervisor/conf\.d/supervisord-apache2\.conf /etc/supervisor/conf\.d/supervisord-mysqld\.conf#files=/etc/supervisor/conf.d/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-smbd.conf#' /etc/supervisor/supervisord.conf
EXPOSE 445

COPY src/index.php /app/index.php

CMD ["/run.sh"]

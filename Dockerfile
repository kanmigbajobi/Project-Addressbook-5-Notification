FROM httpd:2.4
COPY index.html /var/www/html/

ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD [ "-D", "FOREGROUND" ]
EXPOSE 80

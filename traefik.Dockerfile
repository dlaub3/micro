FROM traefik:latest
RUN mkdir /etc/traefik
RUN touch /etc/traefik/acme.json
RUN chmod -R 600 /etc/traefik/acme.json

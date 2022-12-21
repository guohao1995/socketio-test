FROM node:12.20.1-alpine3.12

ENV PORT 8080
WORKDIR /usr/src/app
COPY app /usr/src/app
RUN npm install
# Start and enable SSH
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd \
     && chmod +x /app/init_container.sh \
     && cd /etc/ssh/ \
     && ssh-keygen -A

COPY sshd_config /etc/ssh/

EXPOSE 8080 2222
ENTRYPOINT [ "/app/init_container.sh" ]

# EXPOSE 8080 2222
# CMD npm start

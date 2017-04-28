FROM nginx:1.12.0

RUN apt-get update && \
    apt-get install --no-install-recommends -y curl \
                                               unzip \
                                               ca-certificates

RUN mkdir /moodle && cd /moodle && \
    curl -L https://download.moodle.org/download.php/direct/stable32/moodle-3.2.2.tgz | tar xz && \
    mv moodle source && \
    cd source/auth && \
    curl -L https://moodle.org/plugins/download.php/13249/auth_saml2_moodle32_2017021700.zip -o auth_saml2.zip && \
    unzip -q auth_saml2.zip && \
    rm auth_saml2.zip

RUN apt-get remove --purge -y curl \
                              unzip && \
    apt-get autoremove -y && \
    apt-get clean && \ 
    rm -r /var/lib/apt/lists/*

ADD conf/moodle-config.php /moodle/config-templates/moodle-config.php
ADD conf/moodle-nginx.conf /moodle/config-templates/moodle-nginx.conf
ADD conf/moodle-nginx-ssl.conf /moodle/config-templates/moodle-nginx-ssl.conf
ADD docker-entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/moodle/web", "/moodle/data", "/moodle/conf.d/"]

WORKDIR /moodle/web

EXPOSE 80 443

ENTRYPOINT ["entrypoint.sh"]

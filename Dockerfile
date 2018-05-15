FROM sentry:latest

MAINTAINER Philipp Schmitt <philipp.schmitt@post.lu>

COPY requirements.txt .

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
        libldap2-dev libsasl2-dev && \
    pip install -r requirements.txt && \
    apt-get remove -y -q \
        libldap2-dev libsasl2-dev && \
    rm -rf /var/lib/apt/lists/* requirements.txt

COPY ldap-entrypoint.sh /ldap-entrypoint.sh

VOLUME ["/config"]

ENTRYPOINT ["/ldap-entrypoint.sh"]

FROM debian:bullseye

# Create a mysql user and group
RUN groupadd -r mysql && useradd -r -g mysql mysql --home-dir /var/lib/mysql

RUN set -ex; \
  apt update; \
  apt upgrade;

ENV LANG C.UTF-8

RUN set -ex; \
  # install signing certificates, curl, and other dependencies
  apt install dirmngr ca-certificates software-properties-common apt-transport-https curl -y; \
  # Get GPG key for mariadb
  curl -fsSL http://mirror.mariadb.org/PublicKey_v2 | gpg --dearmor | tee /usr/share/keyrings/mariadb.gpg > /dev/null; \
  # use key to sign repo in our sources.list.d (will be used when installing)
  echo "deb [arch=amd64,arm64,ppc64el signed-by=/usr/share/keyrings/mariadb.gpg] http://mirror.mariadb.org/repo/11.2/debian/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/mariadb.list

# pick the version of mariadb we want I picked this one because it's available as a supported release on Debian until November 2024.
ARG MARIADB_VERSION=1:11.2.3+maria~deb11
ENV MARIADB_VERSION $MARIADB_VERSION

RUN set -ex; \
  apt update; \
  apt install -y mariadb-server=$MARIADB_VERSION mariadb-backup;

EXPOSE 3306

# CMD ["mariadb"]

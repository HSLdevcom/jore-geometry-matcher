FROM python:2

ENV WORKDIR="/opt/jore-geometry-matcher"
ENV PG_CONNECTION_STRING="postgres://postgres:mysecretpassword@jore-postgis:5432/postgres"

WORKDIR $WORKDIR

RUN apt-get update && \
  apt-get -y install git build-essential software-properties-common && \
  # Needs new versions from the Buster repo, otherwise the matcher won't work
  apt-add-repository 'deb http://ftp.us.debian.org/debian buster main contrib non-free' && \
  apt-get update && \
  apt-get -y install protobuf-compiler python-dev \
    libprotobuf-dev make swig g++ libreadosm-dev libboost-graph-dev libproj-dev \
    libgoogle-perftools-dev osmctools unzip zip wget && \
  rm -rf /var/lib/apt/lists/*

RUN pip install imposm.parser && \
  pip install argh && \
  pip install pyproj && \
  pip install psycopg2

ADD . $WORKDIR

RUN cd $WORKDIR && make -C pymapmatch

CMD cd ${WORKDIR} && \
  wget http://download.geofabrik.de/europe/finland-latest.osm.pbf && \
  python jore_shape_mapfit.py finland-latest.osm.pbf +init=epsg:3067 $PG_CONNECTION_STRING


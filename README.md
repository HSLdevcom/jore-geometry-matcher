# jore-geometry-matcher

Run this container after running jore-graphql-import to improve the route geometries

`git clone --recursive https://github.com/HSLdevcom/jore-geometry-matcher.git`

`docker build -t gtfs_shape_mapfit gtfs_shape_mapfit`

`docker run --link jore-postgis -e "PG_CONNECTION_STRING=postgres://postgres:mysecretpassword@jore-postgis:5432/postgres" gtfs_shape_mapfit`

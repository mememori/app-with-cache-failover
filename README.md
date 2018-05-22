# App With Cache Failover
[![Build Status](https://travis-ci.org/mememori/app-with-cache-failover.svg?branch=master)](https://travis-ci.org/mememori/app-with-cache-failover)

## About
Just a simple Phoenix WebApp with a cache layer (Redis) that handles cache unavailabity.

### How it works
The application is comprised of an RESTful API with three simple operations: fetching _all_ customers, creating _many_ customers and removing _all_ customers.

Naturally both `POST` and `DELETE` actions causes the cache to be invalidated and, since there is no filter in the fetching endpoint, it's a single key/value entry on the cache.

Considering that, whenever someone hits the `GET` endpoint, the controller will try to fetch the expected payload from the cache layer. If either the cache is unavailable (checked by health monitoring status and request timeout) or the cache does not have up-to-date data, the controller will hit the database and cache the response afterwards.

## Using the application
### Configuration
#### Environment variables
- `DATABASE_USERNAME` - _optional_ - Sets the Database username
- `DATABASE_PASSWORD` - _optional_ - Sets the Database user password
- `DATABASE_HOSTNAME` - _optional_ - Sets the Database hostname
- `DATABASE_URL` - _optional_ - Sets the Database connection url (if set, the connection will ignore the username, password and hostname passed before)

### Compiling the application
This step is needed before executing any of the other actions (start server, test, document, ...)

```bash
sudo docker-compose -f "automation/docker/docker-compose.yml" build
```

### Starting the server
This will start the server listening to `http://localhost/`.

```bash
sudo docker-compose -f "automation/docker/docker-compose.yml" up
```

### Testing the codebase
```bash
sudo docker-compose -f "automation/docker/docker-compose.yml" run --rm application mix test
```

## License
Copyright (c) 2018 Charlotte Lorelei Oliveira.
This source code is released under GPL 3.

Check [LICENSE](LICENSE) or [GNU GPL3](https://www.gnu.org/licenses/gpl-3.0.en.html)
for more information.

[![GPL3](https://www.gnu.org/graphics/gplv3-88x31.png)](https://www.gnu.org/licenses/gpl-3.0.en.html)

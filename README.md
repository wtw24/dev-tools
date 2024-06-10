# Docker Development Tools

## Services
1. Traefik:
   - URL: https://traefik.app.loc
   - Network: `proxy`
2. Buggregator:
   - URL: https://buggregator.app.loc
   - Network: `develop`

## Used Docker Images:
- https://hub.docker.com/_/traefik
- https://github.com/buggregator/server

---

## First run:

### 1. Generate certificate for domain `app.loc` and their subdomains with `mkcert` 
- https://github.com/FiloSottile/mkcert

   > **IMPORTANT**: The `rootCA-key.pem` file that `mkcert` automatically generates gives complete power to intercept 
   > secure requests from your machine. Do not share it.
   
   **- Install on Ubuntu `mkcert`**
   ~~~shell
   sudo apt install libnss3-tools mkcert
   ~~~
   
   **- Install the local CA in the system trust store**
   ~~~shell
   mkcert -install
   ~~~
   Requires browser restart!
   
   **- Generate certificate for domain `app.loc` and their subdomains**
   ~~~shell
   cd docker/development/traefik/certs
   mkcert -cert-file local-cert.pem -key-file local-key.pem "app.loc" "*.app.loc"
   ~~~
   
   > **IMPORTANT**: X.509 wildcards only go one level deep, so this won't match a.b.app.loc

### 2. Add subdomains to host /etc/hosts
~~~shell
127.0.0.1 traefik.app.loc
127.0.0.1 buggregator.app.loc
~~~

### 3. Initialize the project with
~~~shell
make init
~~~

---

# Commands:

## Initialize
~~~shell
make init
~~~

## Start
~~~shell
make up
~~~

## Stop
~~~shell
make down
~~~

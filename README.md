# Docker of OpenCart

## Setup localhost enviroment

### Prepares
1. docker-compose down && ./clean.sh
2. create docker-compose.override.yml to change some enviroment values

### Running setup
```
docker-compose run --rm setup
```
If you modified the Dockerfile, you need to rebuild the images
```
docker-compose build --force-rm --no-cache setup
```

### Running app
```
docker-compose up -d app
```
#### Update app container
If you need to modify app container, there are two methods:
1. You just attach to the container and modify the enviroment
```
docker exec -it webdev_app_1 bash
```

2. Modify outside and restart the container.
If you modified the Dockerfile, you need to rebuild the images
```
docker-compose build --force-rm --no-cache app
```
Stop and remove the container
```
docker stop webdev_app_1
docker rm webdev_app_1
```
Start the modified container again
```
docker-compose up -d app
```

### Setup Xdebug
#### Xdebug server
You should override "XDEBUG_CONFIG" in docker-compose.override.yml, e.g. set your remote host ip.

#### Xdebug client
For sublime, you should install Xdebug plugin first and then add some configs to your project setting, e.g. 
```
{
	"folders":
	[
		{
			"follow_symlinks": true,
			"path": "."
		}
	],

    "settings": {
        "xdebug": {
            "url": "http://localhost/",
        	"path_mapping": {"/var/www/html/localhost/" : "/home/cong/web-dev/webroot/localhost/"}        
        }
    }

}

```
Refer to https://github.com/martomo/SublimeTextXdebug for details.

## Setup real domain enviroment

### Prepares
Similar to localhost's setup, but you need to prepare some other files too.
For examples, if your domain is xxx.com, what you need to do is
1. Define build args and envs "DOMAIN_NAME: xxx.com" in docker-compose.override.yml, see docker-compose.override.yml.dist for detais.
2. Create your xxx.com.conf or xxx.com.https.conf and add it to apache-php/conf directory.
3. For https website, you should put your ssl certs in apache-php/certs/xxx.com directoty.

How to issue a cert ?
Refer to https://github.com/Neilpang/acme.sh.

### Running setup
### Running app
Same as localhost's.

### SSL certs renew
Run setup_acme.sh in app container.
```
setup_acme.sh apache-php/certs/xxx.com
```
This step is used to install acme tool and cron job. It will re-issue certs for us.
Remeber to backup certs before destorying the docker container!!!


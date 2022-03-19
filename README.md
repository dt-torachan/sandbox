# sandbox
Docker Env for Multi Language

## Dockerfile_dart
Docker file for compile scss to css by Dart Sass
1. Build Docker Image with the following command
```
cd path/to/sandbox
docker build -t sass -f Dockerfile_dart .
```
2. Run Docker Container with the following command
```
docker run -it --rm -v absolute/path/to/sandbox/data:/var/www/html -e TZ=Asia/Tokyo --name sass sass /bin/bash
```
3. Do Compile with the following command in Docker Container
```
sass --watch --no-source-map befofre.scss after.css
e.g.
sass --watch --no-source-map item_list.scss item_list.css
```
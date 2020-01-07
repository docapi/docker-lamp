# Docker PHP/MySQL Generator

A tool that generates a running PHP/MySQL DEV environment with Docker

## Features

* select PHP Engine (5.6, 7.1, 7.2, 7.3)
* select host name for local development (*.test recommended)
* select port for local development (default: 80)
* select host name for staging
* select DB name

## How to start

1. Clone this project to any folder on your local file system
2. Run create script
```
./create_project.sh
```
3. Go to the folder you selected in step 2
4. Start engine
```
./start_system.sh
```
5. Stop engine (optional)
```
./stop_system.sh
```

## Author

* **Alexander Pisculla**
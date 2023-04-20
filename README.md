# Kill it with fire :fire:

Fire is a simple bash script that allows users to kill processes by name or port number. It's a very thin wrapper, but definitely easier to remember to kill it with `fire` than to remember `lsof -ti :8080 | awk '{print "kill -9", $1}' | xargs -L 1 sh -c`

## Installation
- `git clone git@github.com:evpgh/fire.git`
- `cd fire`
- `chmod +x fire.sh`

## Mac OS X shortcut
- `ln -s $(pwd)/fire.sh /usr/local/bin/fire`

## Usage
`fire [process name]` or `fire [port number]`

## Examples
- Open a terminal and run the following command to start a background process:
```sleep 300 &```
- Run `fire sleep` to kill the process
---
- Open a terminal and run the following command to start a simple HTTP server on port 8080:
```python -m SimpleHTTPServer 8080 &```
- Run `fire 8080` to kill the process
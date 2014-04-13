passtheword
===========
My attempt at making passwords a bit more secure. From a security stand point every body should ideally have a different password for every account on. This gets convoluted quickly and becomes very hard to manage.

This project aims to provide you with a web site as well as a command line utility to allow you generate long and convoluted passwords based on a simple and easy to remember name. It does by hashing the name you have chosen plus a secret string (salt) using the secure SHA2 algorithm (sha256).

The result of the hash can then be used as a password for any site. This allows you to type 'gmail.com' into passtheword and the result will be a salted hash which you can use as password for gmail.com.

For those cases where you are trying to log on from a computer that doesn't belong to you, you can run the stand-alone web server using a self-signed SSL certificate or similar.

setup
=====
```bash
git clone git@github.com:nerdyness/passtheword.git
cd passtheword
```
- create a salt.secret file containing a random string of characters
```bash
dd if=/dev/random of=./salt.secret bs=10K count=1
```
- had to install xclip for 'clipboard' to work. xsel was installed but didn't work through clipboard.
```bash
sudo apt-get install xclip
```

run
===
- to run from the command line
```bash
$ bundle exec ./passtheword.rb gmail.com
The password will be in your paste buffer for the next 5 seconds. Go!
```
- to run as a standalone web server
```bash
$ bundle exec ./server.rb
[2014-04-13 18:03:42] INFO  WEBrick 1.3.1
[2014-04-13 18:03:42] INFO  ruby 1.9.3 (2012-02-16) [x86_64-linux]
== Sinatra/1.4.4 has taken the stage on 4567 for development with backup from WEBrick
[2014-04-13 18:03:42] INFO  WEBrick::HTTPServer#start: pid=13158 port=4567
```

Dependencies
============
- needs xsel / xclip to access the clipboard
- [sinatra](http://rubygems.org/gems/sinatra)
- [haml](http://rubygems.org/gems/haml)
- [clipboard](http://rubygems.org/gems/clipboard)
- tested using Ruby 1.9.3-p125

ToDo
====
- what to do on mobile phones?
- replace some characters in the hash with special characters

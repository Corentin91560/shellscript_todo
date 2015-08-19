# todo.sh

## About

`todo` is a simple shell command for **adding, listing, and deleting todo list** within your **bash command**!

## Install

### Run on Terminal

```bash

# Download todo.sh
$ curl https://raw.githubusercontent.com/KENJU/shellscript_todo/master/todo.sh > /usr/local/bin/todo

# Add permission
$ chmod u+x /usr/local/bin/todo.sh

# Run todo
$ todo -h

```

If you have not yet added `/usr/local/bin` to your path, run the below command.

```bash

# Add /usr/local/bin to yoru $PATH
$ export PATH=/usr/local/bin:$PATH

```

## Usage

### Add

```bash

// 1
$ todo -a "Fixes minor bug"
// 2
$ todo --add "Fixes minor bug"

```

### List

```bash

// 1
$ todo
// 2
$ todo -l
// 3
$ todo --list

```

### Delete

```bash
// 0
$ todo --list
// 1
$ todo -d 120
// 2
$ todo --delete 120

```

## License

```text

The MIT License (MIT)

Copyright (c) 2015 Kenju Wagatsuma

Permission is hereby granted, free of charge, to any person 
obtaining a copy of this software and associated documentation 
files (the "Software"), to deal in the Software without 
restriction, including without limitation the rights to use, 
copy, modify, merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following 
conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
OTHER DEALINGS IN THE SOFTWARE.


```
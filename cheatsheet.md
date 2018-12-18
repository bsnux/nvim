# Vim cheatsheet

## Buffers

* `:bd`: Close current buffer
* `:bn`: Go to next buffer

## Folding

* `za`: Toggle folds

## Files explorer

* `Ctrl-e`: Toggle files explorer

## Autocomplete

* Type and hit `Ctrl-n`. Then, `Ctrl-p` will move cursor up on the dialog box.
* Type and hit `tab`: Python Jedi plugin.
* `Ctrl-x Ctrl-o`: Go plugin.

## Go plugin

* `GoRun`: Execute code
* `GoBuild`: Build from code
* `GoLint`: Lint code
* `GoVet`: Call to `go vet`
* `GoTest`: Test code

## Navigation

* `f<char>`: Move to next `<char>`. Example: `fa` moves to next `a`
* `b<char>`: Move to previous `<char>`. Example: `fb` moves to previous `a`
* `e`: Move to end of current word
* `%`: Go to match parenthesis, bracket or similar
* `H`: Go to top of the screen
* `L`: Go to bottom of the screen
* `M`: Go to medium of the screen
* `;`: Repeat last cursor movement

## Text objects

* `vi'`: Select text delimited by `'` character
* `yi'`: Copy text delimited by `'` character
* `yiw`: Copy word

## Tags

Installing `ctags`:

```
$ sudo yum install ctags-etags
```

You can ignore some folders globally, adding following lines to your `~/.ctags` file:

```
--recurse=yes
--exclude=.git
--exclude=vendor/*
--exclude=node_modules/*
--exclude=db/*
--exclude=log/*
```

Generating tags for current folder:

```
$ ctags .
```

Ignoring generated `tags` file globally:

```
echo "tags" >> ~/.global_ignore
git config --global core.excludesfile $HOME/.global_ignore
```

Usefull commands:

* `:tag name`: Jump to `name` tag
* `vim -t name`: Jump to `name` tag from command line
* `:tn` Move to next definition
* `:tp` Move to previous definition
 `Ctrl-]`: Jump to definition
* `Ctrl-t`: Jump back from definition
* `:Tagbar`: Open tag bar

## Indentation

* `>`: Indent
* `<`: Outdent
* `ggG=`: Re-indent file
* `=`: Indent selection

## Fugitive: Git

* `,gs`: Open a new window executing **git status**
* `-`: Add file
* `C`: Commit added file/files

## Copying from system clipboard on terminal

```
:put+
```

## Multipe-cursors

`Ctrl-n` will activate multiple-cursors. Every time you click that sequence a
new selection will be marked. Then click `c`, insert your text, click on `Esc` and
all occurrences will be replaced.

## Remote editing

```
$ vim scp://username@host//path/to/file
```

## Easy motion

* ` ,,w`: Activating easy motion

## Macros

1. Start recording by pressing `q`, followed by a lower case character to name the macro
2. Perform any editing actions inside editor, which will be recorded
3. Stop recording by pressing `q`
4. Play the recorded macro by pressing `@` followed by the macro name
5. To repeat macros multiple times, press `:nn @macro_name`. ``nn`` is a number

## Displaying indentation guides/lines

```
:set listchars=tab:\|\
:set list
```

## Selecting and replacing (similar to selected multiples words)

Example, let's replace `foo` with `bar`:

1. `/foo`
2. `cgnbar<esc>`
3. `.`

## Re-formating lines to wrap to 80 chars

```
:set textwidth=80
```

Select lines with `v` and then reformat lines with `gq`

## Misc

* `:retab`: Replace tabs for spaces
* `,fc`: Searching for conflict markers
* `,y`: Google YAPF code formater
* `X`: Encrypt file
* `:%!python -m json.tool`: Format current JSON file
* `:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<`: Displaying invisible chars
* `:set list!`: Hide invisible chars
* `$ gvim --remote-tab README.md`: Open `README.md` file using a new tab on `gvim`

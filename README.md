[![GPL License](https://img.shields.io/badge/license-GPL-blue.svg?longCache=true&style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.7.1-blue.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-blue.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)
[![Install](https://img.shields.io/badge/-Install-brightgreen?style=flat-square)](#install)

# Swap

> A plugin for [Oh My Fish](https://www.github.com/oh-my-fish/oh-my-fish)

A wrapper function to allow `mv` to swap the location or contents of targeted files or folders

## Syntax

`mv [option] [file] [file]`

## Options

`-s/--swap`

Trigger this function

`-c/--contents`

Swap contents intead of location. Contents of a file can only be swaped with those of another file, the same applies for folders.

`-h/--help`

Display the function description and instructions

## Install

```fish
omf repositories add https://gitlab.com/argonautica/argonautica 
omf install swap
```

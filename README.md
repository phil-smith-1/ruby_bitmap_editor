# Bitmap editor

A Ruby 2.3.4 script that produces a bitmap based on certain commands. Bitmaps are represented as an M x N matrix of pixels with each element representing a colour.

## Dependencies

You need to install:

Ruby

[Bundler](http://bundler.io/)

Install all of the required gems:

`>bundle`

## Input

The input consists of a file containing a sequence of commands, where a command is represented by a single capital letter at the beginning of the line. Parameters of the command are separated by white spaces and they follow the command character.
Pixel co-ordinates are a pair of integers: a column number between 1 and 250, and a row number between 1 and 250. Bitmaps starts at coordinates 1,1. Colours are specified by capital letters.

## Commands

There are 6 supported commands:
* I M N - Create a new M x N image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L X Y C - Colours the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* S - Show the contents of the current image

## Running

`>bin/bitmap_editor examples/show.txt`

## Testing

Unit testing has been created using [RSpec](http://rspec.info). In order to run the tests, from the root directory, use:

`>rspec`

The project uses [Rubocop](http://batsov.com/rubocop) for code linting. To run Rubocop, from the root directory, use:

`>rubocop`
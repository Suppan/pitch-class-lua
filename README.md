# **pitch-class-lua**
basic set class calculator written in Lua

## Why?

Lua is a really fast und lightweight scripting language. Also a perfect tool for computer-assistend-composition. In 2021 I started to build the application "Delta-Score", a tool for computer-assistend-composition for my personal needs and based on Lua. When I started the project I found out there are not many music related Lua resources out there - compared to other languages. To enhance this situation I decided share this code on this platform.   

## Usage

after installing Lua (ie via homebrew: brew install lua)

enter midi values [0-127] in terminal: 
```
lua pc-info.lua 60 64 55
```
result:
```
midi: 60 64 55
normal: 0 4 7
prime: 037
name: 3-11
vector: 001110
```
*************
This program is free software. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
*************

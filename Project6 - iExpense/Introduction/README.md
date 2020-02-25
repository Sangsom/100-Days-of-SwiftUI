# Introduction

In this project we will learn about `@ObservedObject`, `sheet()`, `onDelete()`, and more.

## Why @State only works with structs

`State` property wrapper is designed for simple data that is local to the current view, but as soon as you want to share data between views it stops being useful.

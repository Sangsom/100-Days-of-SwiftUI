# Introduction

In this app we will look more about `Codable`, `URLSession`, `disabled()` modifier and more.

## Codable conformance for @Published properties

By default if we want to add `Codable` conformance for `@Published` properties, Swift doesn't allow that and we need to add extra work.

We need to implement `Codable` conformance by self.

First we need to create a `CodingKeys` enum that conforms to `CodingKey`, listing all the properties we want to archive and unarchive.

And then create a custom initializer that will be used to read values for all our properties.

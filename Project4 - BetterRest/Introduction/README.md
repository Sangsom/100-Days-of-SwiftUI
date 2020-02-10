# Introduction

In current project we will review `Stepper`, `DatePicker`, `DateFormatter`, and more.

## Stepper

This adds stepper with limited values that can be selected.

```swift
Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
    Text("\(sleepAmount, specifier: "%.2f") hours")
}
```

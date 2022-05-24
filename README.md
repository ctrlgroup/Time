<img src="Logo.png" width="178" max-width="60%" alt="Time" />

<p>
  <img src="https://img.shields.io/badge/Swift-5.5-orange.svg" />
  <a href="https://swift.org/package-manager">
    <img src="https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
  </a>
  <img src="https://img.shields.io/badge/platforms-iOS+macOS-brightgreen.svg?style=flat" alt="iOS + macOS" />
  <a href="https://twitter.com/ctrl_group">
    <img src="https://img.shields.io/badge/twitter-@ctrl_group-blue.svg?style=flat" alt="Twitter: @ctrl_group" />
  </a>
</p>

Welcome to **Time**, a swift package to simplify calendar, date and time handling.

## Introduction
Time was built by [Ctrl Group](https://www.ctrl-group.com) to make working with date and time simple and to avoid the common mistakes made when using the standard `Date` object.

### What does Time provide over the Foundation library
The Foundation library provides a [`Date`](https://developer.apple.com/documentation/foundation/date) object which represents a single point in time, independent of any calendar or time zone. This object needs to be used in conjunction with a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter), [`TimeZone`](https://developer.apple.com/documentation/foundation/timezone), [`Locale`](https://developer.apple.com/documentation/foundation/locale), [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents) and [`Calendar`](https://developer.apple.com/documentation/foundation/calendar) in order to perform calendar arithmetic and create meaningful representations of dates and times.

**Time** uses these tools and provides a simple API to allow you to represent a `CalendarDate`, `TimeOfDay`, `Timestamp`, `CalendarDateRange`, `TimeRange` and more.

### Key features
1. Provides types which accurately represents the information you want to store, and semantically conveys what is being stored to the reader of the code.
2. Provides types which group contextual information such as the `TimeZone`.
3. Makes performing calendar arithmetic fast and simple.
4. Simplifies serialising and parsing date and time information.
5. Provides an easy way to stub the time for unit tests.

## Installation
Time is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, add it as a dependency within your Package.swift manifest:
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/ctrlgroup/Time.git", from: "1.0.0")
    ],
    ...
)
```

Then import Time wherever you’d like to use it:
```swift
import Time
```

## Examples
### Calendar Dates
`CalendarDate` allows you to represent a date in the gregorian calendar, without the time, and irrespective of the time zone.

You can create them with a day, month and year explicitly, or you can create them using a `Date` and `TimeZone`.
```swift
let europeLondon: TimeZone = ...
let date: Date = ...

// April 4th, 1994
let dateOfBirth = try? CalendarDate(day: 03, month: 04, year: 1994)

// Can also be created from a `Date`
let calendarDate = CalendarDate(date: date, timeZone: europeLondon)
```

Once instantiated, you can query them for their day, month, year, and even weekday.
```swift
print(calendarDate.month)
print(calendarDate.dayOfWeek)
```

They can also be converted back to a `Date` (representing the moment of midnight on that day)
```swift
// Can be converted back to a `Date` using a time zone
let date: Date = calendarDate.date(in: europeLondon)
```

You can also easily do calendar arithmetic, and usually without having to do any complex `Calendar` conversions.
```swift
let nextWeek = dateOfBirth + 7 // Adds 7 days
let difference: Int = nextWeek - dateOfBirth // 7

// Calendar dates are comparable
let firstOfMay = try? CalendarDate(day: 01, month: 05, year: 2022)
let tenthOfJune = try? CalendarDate(day: 10, month: 06, year: 2022)
tenthOfJune > firstOfMay // true

// Easily find weekdays (uses a Calendar to compute the weekday)
dateOfBirth.previous(weekday: .sunday) // Finds the previous Sunday
dateOfBirth.next(weekday: .sunday) // Finds the next Sunday
```

Arithmetic with calendar dates is a trivial operation as the underlying raw value is just an `Int`. This means you don’t need to worry about the overhead of using a `Calendar`, and can easily do things like iterate over a [￼￼`CalendarDateRange`￼￼](#CalendarDateRange).

### Time Interval
We’ve added some conveniences for writing `TimeInterval`s in an easily readable way.

```swift
let seconds: TimeInterval = 12.hours + 34.minutes + 56.seconds
let fiveDays: TimeInterval = 5.days
```

### TimeOfDay
To represent just time (without a date) you can use `TimeOfDay`. This is useful for things like recording the time for a repeating reminder or alarm.

A `TimeOfDay` can be created in various different ways:
```swift
let example1 = try? TimeOfDay(hour: 18, minute: 30, second: 0)
let example2 = try? TimeOfDay(secondsSinceMidnight: 3600 * 12)
let example3 = TimeOfDay(date: Date(), timeZone: europeLondon)
let example4 = 18⁝30 // Use the "tricolon" operator
let example5 = 12⁝34⁝56 // Also supports seconds
```

You can do arithmetic with a `TimeOfDay` and  `TimeInterval`:
```swift
let midday = 11⁝30 + 30.minutes
let elevenAM = 11⁝30 - 30.minutes
let fiveMins: TimeInterval = 06⁝00 - 05⁝55
let oneAM = 23⁝30 + (1.hours + 30.minutes) // Can span over midnight
```

It also supports various string conversions:
```swift
let timeOfDay = 15⁝34⁝56
let locale = Locale(identifier: "en-US")
timeOfDay.string(style: (.short, .twelveHour), locale: locale) // 3:34 PM
timeOfDay.string(style: (.medium, .twentyFourHour)) // 15:34:56

// Converting from a string
let result = TimeOfDay(string: "3:34 PM", 
                       style: (.short, .twelveHour),
                       locale: locale)
```

`TimeOfDay` is also `Equatable`, `Hashable`, `Codable` and `Comparable`.

### CalendarDateRange
`CalendarDateRange` allows you to easily represent a range of calendar dates which you can iterate over, and use all the commonly available operators of a `Range`.

```swift
// A calendar date range is simply a Swift Range
public typealias CalendarDateRange = Range<CalendarDate>

// Can be created in the usual way
let range = startDate ..< endDate

// It can be indexed using integers
sut[0] == startDate
sut[1] == startDate + 1

// Convenience initializers make calendar date ranges easy to understand
CalendarDateRange(firstDate: startDate, lastIncludedDate: lastDate)
CalendarDateRange(startDate: startDate, endDate: endDate)
```

### TimeRange
A `TimeRange` is slightly more complex as a `TimeOfDay` isn’t strictly sequential (they loop when continually adding seconds). However it’s still useful to be able to form ranges over them.

```swift
// Can be created in the usual way
let timeRange: TimeRange = 11⁝30 ..< 18⁝00
let timeRangeOverMidnight: TimeRange = 23⁝30 ..< 01⁝00

// Can test is a time exists in the range
timeRange.contains(12⁝30) // true
```

### DateTime
`DateTime` can be used when you want to represent a specific time on a specific calendar date, but in any time zone.

```swift
let calendarDate: CalendarDate = ...
let timeOfDay: timeOfDay = ...
let dateTime = DateTime(calendarDate: calendarDate, timeOfDay: timeOfDay)

// Can be created from a `Date` and `TimeZone`
let dateTime = DateTime(date: Date(), timeZone: europeLondon)

// Can be converted to a `Date` or `Timestamp`
let date = dateTime.date(in: europeLondon)
let timestamp = dateTime.timestamp(in: europeLondon)
```

### Timestamp
Most of the time a `Timestamp` would be a more appropriate type to replace `Date`. It is simply an ecapsulation of a `Date` with the `TimeZone` it was recorded at, so similarly it represents a single point in time, but contains the necessary context to understand what date and time it represents as well.

```swift
let timestamp = Timestamp(date: Date(), timeZone: europeLondon)
timestamp.day // 1st March
timestamp.timeOfDay // 12pm
timestamp.dateTime = // 1st March at 12pm
```

One other difference between `Timestamp` and `Date` is in the way it implements `Equatable`. As `Date` is based on a `Double` it suffers from inaccuracies of floating point arithmetic. This means comparing two `Date` objects can somtimes give unexpected results…

```swift
let date1 = dateFormatter.date(from: "2022-01-01T12:34:56.1234Z")!
let date2 = Date(timeIntervalSinceReferenceDate: 662733296.123)
print(date1) // 2022-01-01 12:34:56 +0000
print(date2) // 2022-01-01 12:34:56 +0000
date1 == date2 // false
```

`Timestamp` fixes this by considering the dates equal if they are within a millisecond of each other.

### Clock
`Clock` is a class which can be read to learn the current date and time. It should be used instead of every using the `Date()` initialiser. By injecting a `Clock` instance into your code you are able to stub it out in tests in order to unit test code which depends on the current time.

### Other functionality
Many of the types (`CalendarDate`, `TimeOfDay` etc.) are also `Equatable`, `Comparable`, `Hashable`, and `Codable`.

When serializing with `Codable` the package will prefer to save types as a standard ISO8601 string e.g. 
- `2022-01-01T12:30:00Z` for a `DateTime`
- `2022-01-01` for a `CalendarDate`
- `12:30:00` for a `TimeOfDay`

A `Timestamp` need the context of a `TimeZone` so will encode like this in JSON:

```json
{
  "timestamp": "...",
  "timeZone": "Europe/London"
}
```

Here, the `timestamp` property is an encoded `Date`. This will encode in the default way (as a double, number of seconds since the reference date) unless you specify to use an ISO8601 representation using the date encoding strategy property:

```swift
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
let date = try? encoder.encode(timestamp)
```

## String Formatting
Time tries to provide a simpler way to create strings from dates and times without having to use a `DateFormatter` class directly.
- It simplifys localizing your date formats by always preferring to use a _localized template string_ or date and time style parameters.
- It cuts down on lines of code by providing a simple to use API
- It tries to improve on performance by caching `DateFormatter` classes that are commonly used.

```swift
let dateFormat = "dd-MM-yyyy"

// Using Foundation
let date: Date = ...
let timeZone: TimeZone = ...
let dateFormatter = DateFormatter()
dateFormatter.timeZone = timeZone
dateFormatter.locale = .current
dateFormatter.setLocalizedDateFormatFromTemplate(dateFormat)
let result = dateFormatter.string(from: date)

// Using Time
let calendarDate: CalendarDate = ...
let result = calendarDate.string(withFormat: dateFormat, locale: .current)
```

Similar methods also exist for `TimeOfDay` and additional methods exist on `CalendarDate`, `TimeOfDay`, `DateTime`, and `Timestamp` for creating ISO8601 strings.

## Author
Time was designed and implemented by the team at [Ctrl Group](https://www.ctrl-group.com).
* Website: [ctrl-group.com](https://www.ctrl-group.com)
* Twitter: [@ctrl_group](https://twitter.com/ctrl_group)

## License
Time is available under the MIT license. See the LICENSE file for more info.

## Contributions and support
We would like `Time` to developed completely in the open going forward, and your contributions are more than welcome!

If you find any problems, have any suggestions, or wish to improve on the documentaion then we encourage you to [open a Pull Request](https://github.com/ctrlgroup/Time/compare) and we will be actively reviewing and accepting contributions.

We hope that you’ll find this package useful and enjoyable!
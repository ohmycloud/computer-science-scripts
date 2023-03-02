    let possibleString: String? = "An optional string."
    let forcedString: String = possibleString! // requires an exclamation point

    let assumedString: String! = "An implicitly unwrapped optional string."
    let implicitString: String = assumedString // no need for an exclamation point
    print(forcedString)
    print(implicitString)

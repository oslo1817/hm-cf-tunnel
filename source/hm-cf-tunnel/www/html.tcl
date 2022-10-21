#!/bin/tclsh

proc __element {name {attributes ""} {content ""}} {
    if { [string length $attributes] > 0 } {
        set attributes " $attributes"
    }

    if { [string length $content] > 0 } {
        return "<$name$attributes>$content</$name>"
    } else {
        return "<$name$attributes>"
    }
}


proc html args {
    return [__element html {*}$args]
}

proc head args {
    return [__element head {*}$args]
}

proc meta {{attributes ""}} {
    return [__element meta $attributes]
}

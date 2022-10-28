#!/bin/tclsh

proc html_put {value} {
    puts -nonewline "$value"
}

# Writes an HTML element.
#
# When using HTML elements that require a closing tag, the closing tag must be
# written manually with `html_element_end` after writing the element's contents.
#
# @param name The name/tag of the element.
# @param attributes A list of attributes.
proc html_element {name args} {
    set element "<$name"

    foreach attribute $args {
        append element " $attribute"
    }

    html_put "$element>"
}

# Writes an HTML element's closing tag.
#
# @param name The name/tag of the element.
proc html_element_end {name} { html_put "</$name>" }


# Writes an `html` element.
#
# Use `html_end` to close the `html` element after writing its contents.
#
# @param attributes A list of attributes.
proc html args { html_element html {*}$args }

# Writes an `html` element's closing tag.
proc html_end {} { html_element_end html }

# Writes a `head` element.
#
# Use `head_end` to close the `head` element after writing its contents.
#
# @param attributes A list of attributes.
proc head args { html_element head {*}$args }

# Writes a `head` element's closing tag.
proc head_end {} { html_element_end head }

# Writes a `meta` element.
#
# @param attributes A list of attributes.
proc meta args { html_element meta {*}$args }

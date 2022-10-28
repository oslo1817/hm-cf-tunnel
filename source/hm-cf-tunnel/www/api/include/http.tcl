#!/bin/tclsh

proc http_put {value} {
    puts -nonewline "$value\r\n"
}

# Writes an HTTP status line.
#
# @param code The HTTP status code.
# @param message The HTTP status message.
proc http_status {code message} {
    http_put "HTTP/1.1 $code $message"
}

# Writes a single HTTP header.
#
# @param name The header name.
# @param value The header value.
proc http_header {name value} {
    http_put "$name: $value"
}

# Writes HTTP CORS headers.
#
# @param origin The allowed origins. Defaults to "*".
# @param methods The allowed methods. Defaults to "*".
# @param headers The allowed headers. Defaults to "*".
proc http_header_cors {{origin *} {methods *} {headers *}} {
    http_header Access-Control-Allow-Origin $origin
    http_header Access-Control-Allow-Methods $methods
    http_header Access-Control-Allow-Headers $headers
}

# Writes the end of HTTP headers.
proc http_head_end {} { http_put "" }


# Decodes an URL-encoded query string.
#
# @param query The query string.
# @return The decoded key-value pairs.
proc http_query_decode {query_string} {
    set parameters [split $query_string &]

    foreach parameter $parameters {
        set parts [split $parameter =]

        lassign $parts name value
        set query($name) $value
    }

    return [array get query]
}

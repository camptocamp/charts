vcl 4.0;

backend default {
    .host = "localhost";
    .port = "8080";
    .probe = {
        .url = "/.internal_healthcheck";
        .timeout = 1s;
        .interval = 2s;
        .window = 5;
        .threshold = 3;
    }
}

#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and https://www.varnish-cache.org/trac/wiki/VCLExamples for more examples.

import std;

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.

    std.log("time_vcl_recv:" + std.time2real(now, 0));

    if (!req.http.X-Request-ID) {
        if (req.http.X-Amzn-Trace-Id) {
            set req.http.X-Request-ID = req.http.X-Amzn-Trace-Id;
            unset req.http.X-Amzn-Trace-Id;
        }
        else {
            set req.http.X-Request-ID = req.xid;
        }
    }
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.

    if (beresp.http.content-type ~ "(?i).*(text|json|javascript|css|html|xml|svg).*") {
        set beresp.do_gzip = true;
    }
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.

    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
        set resp.http.X-Cache-Hits = obj.hits;
    } else {
        set resp.http.X-Cache = "MISS";
    }

    std.log("time_vcl_deliver:" + std.time2real(now, 0));
}

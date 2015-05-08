The `overlay` filesystem has bugs concerning Unix domain sockets.  This repository builds a Docker image that will exercise this bug.  Build an image from this repository:

    docker build -t sockettest .

Run the image to perform the test:

    docker run -it --rm sockettest

When using the `devicemapper` driver, you should see:

    Ensuring that /tmp/sock exists
    Creating socket /tmp/sock/1
    Creating hard link /tmp/sock/2 to /tmp/sock/1
    Writing to /tmp/sock/2
    Hello world

    ======================================================================
    TEST PASSED
    ======================================================================


When using the `overlay` storage driver, you will see:

    Ensuring that /sock exists
    Creating socket /sock/1
    Creating hard link /sock/2 to /sock/1
    Writing to /sock/2
    2015/05/08 16:46:01 socat[11] E connect(5, AF=1 "/sock/2", 9): Connection refused

    ======================================================================
    TEST FAILED
    ======================================================================


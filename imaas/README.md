# IMaaS

ImageMagick as a Service.

## Configuration

You can configure on what port it will be started via `PORT`
environmet variable (4000 port is default).

## Usage

It accepts the following HTTP form data parameters:

  - image -- a file to convert (required);
  - options -- a url-encoded string of imagemagick options (may be
    ommited);

and returns a converted image.

IMaaS expects `Content-Type` header to reflect current file format and
uses it to a produced image. In case you need to change an output
format you can specify `Accept` header with desired format.

On the event of a failure it returns a response with 400 HTTP Status
Code and the program's exit code and stdout as HTTP body.

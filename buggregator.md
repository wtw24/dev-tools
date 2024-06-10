# Buggregator

## Links:
- https://buggregator.dev/

# Laravel Integration

## Symfony VarDumper server
Set environment variables in your `.env` file:
~~~
VAR_DUMPER_FORMAT=server
VAR_DUMPER_SERVER=host.docker.internal:9912
~~~

## Sentry exceptions
Set environment variables in your `.env` file:
~~~
SENTRY_LARAVEL_DSN=http://sentry@host.docker.internal:8000/1
~~~

## Fake SMTP server
Set environment variables in your `.env` file:
~~~
MAIL_MAILER=smtp
MAIL_HOST=host.docker.internal
MAIL_PORT=1025
~~~

## Monolog
Set environment variables in your `.env` file:
~~~
LOG_CHANNEL=socket
LOG_SOCKET_URL=host.docker.internal:9913
~~~

`config/logging.php`
~~~php
return [
    // ...
    'channels' => [
        // ...
        'socket' => [
            'driver' => 'monolog',
            'level' => env('LOG_LEVEL', 'debug'),
            'handler' => \Monolog\Handler\SocketHandler::class,
            'formatter' => \Monolog\Formatter\JsonFormatter::class,
            'handler_with' => [
                'connectionString' => env('LOG_SOCKET_URL', '127.0.0.1:9913'),
            ],
        ],
    ],
];
~~~

## Ray Dumps
~~~
RAY_HOST=ray@host.docker.internal
RAY_PORT=8000
~~~


# Test Scripts

## Symfony VarDumper
~~~php
dump(__FILE__, date(), 'test message');
~~~

## Sentry exceptions
~~~php
report(new \Exception('This is Test Exception!'));
~~~

## Fake SMTP server:
~~~php
Mail::to('info@app.loc')->send(
    (new Mailable())->view('email.test')
);
~~~

## Monolog:
~~~php
logger()->info('Hello, World!', [
    'success' => true,
    'foo' => 'bar',
]);
~~~

## HttpDump
~~~php
Http::get('http://http-dump@host.docker.internal:8000?foo=bar');
~~~

## 
Ray Dumps
~~~php
ray('Hello, World!');

ray()->measure();
sleep(1)
ray()->measure();

ray()->showQueries();
ray()->phpinfo('xdebug.enabled', 'default_mimetype');
ray()->notify('This is my notification');
ray()->caller();
ray()->trace();
ray()->pause();
ray()->phpinfo();
ray()->confetti();
~~~
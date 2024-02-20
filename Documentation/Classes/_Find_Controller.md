# _Find_Controller : _CLI_Controller

`_Find_Controller` is a subclass of `_CLI_Controller` to execute the `find` command on macOS without UI. 

## .bind() 

**.bind**($instance : cs._CLI)

Binds the `cs._CLI` instance to a callback functionality. 

The instance will receive callback methods for the following events:

* **.onResponse**($files : Collection; $parameters : Collection)
* **.onTerminate**($parameters : Collection)

`$parameters` is `Copy parameters(2)` from `.bind()`.
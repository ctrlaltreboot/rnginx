rnginx Cookbook
======================
This installs nginx from source by default.

Requirements
------------
This is tested on Virtualbox and Vagrant using Ubuntu 12.04 - which would probably make it work with that distribution and derivatives.

#### packages
The cookbook tries to install package dependencies.

Usage
-----
#### rnginx::default

e.g.
Just include `rnginx` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[rnginx]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

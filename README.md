# DiceBag

[![Code Climate](https://codeclimate.com/github/mdsol/dice_bag.png)](https://codeclimate.com/github/mdsol/dice_bag)

DiceBag is a library of rake tasks for configuring web apps in the style of [The
Twelve-Factor App][1]. Configuration values are picked up from the environment
and used to populate configuration files from templates. Pre-packaged templates
for common configuration files are provided.

[1]: http://www.12factor.net/

## Install

Add the following to your `Gemfile`:

```ruby
gem 'dice_bag'
```

If you are using these tasks outside of a Rails project, add the following to
your `Rakefile` or wherever your local rake tasks are defined:

```ruby
require 'dice_bag/tasks'
```

Run the following command to see the new tasks:

```
[bundle exec] rake -D config
```

## Create configuration files from templates

When the rake "config" task is run, configuration files are populated for all
ERB template files in the project that have a ".dice" extension. Configuration
values from the environment are made available to the templates through the
`configured` object.

For example, take a "database.yml.dice" file containing this template:

```erb
development:
  database: development
  username: <%= configured.database_username || 'root' %>
  password: <%= configured.database_password %>
```

Then run the following command:

```
[bundle exec] rake DATABASE_USERNAME=alice DATABASE_PASSWORD=xyzzy config
```

The following "database.yml" file is generated:

```yaml
development:
  database: development
  username: alice
  password: xyzzy
```

See the [feature documentation][features] for further examples and
functionality.

[features]: https://www.relishapp.com/mdsol/dice-bag/docs

As discussed in [The Twelve-Factor App section on configuration][2], do not
commit your generated configuration files to source control. Instead, commit the
templates to source control and then regenerate the configuration files at
deployment time by running the rake `config:deploy` task.

[2]: http://www.12factor.net/config

## Generate pre-packaged templates

Pre-packaged templates for the following configuration files in the `config`
directory are provided:

* `database.yml` for [Rails](https://github.com/rails/rails/)
* `newrelic.yml` for [NewRelic](https://github.com/newrelic/rpm)

Run the following command to generate them:

```
[bundle exec] rake config:generate_all
```

As with your own templates, you should commit these pre-packaged templates to
source control.

You can customize these pre-packaged template to your needs but if the change is
a generic fix or extension, please consider contributing it back to this project
so that everyone benefits.

### Define your own pre-packaged templates

If you want DiceBag to generate your own pre-packaged templates when you run the
rake "config:generate_all" task, you can create a plug-in. Read the
[templates.md](./templates.md) file to learn how to do this.

## Contributors

* [Andrew Smith](https://github.com/asmith-mdsol)
* [Jordi Carres](https://github.com/jcarres-mdsol)
* [Dan Hoizner](https://github.com/dhoizner-mdsol)
* [Aaron Weiner](https://github.com/HonoreDB)
* [Luke Greene](https://github.com/lgreene-mdsol)
* [Johnny Lo](https://github.com/jlo188)

